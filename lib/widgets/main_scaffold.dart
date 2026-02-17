import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../screens/home_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/tickets_screen.dart';
import '../screens/profile_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    BookingScreen(),
    TicketsScreen(),
    ProfileScreen(),
  ];

  // ── Tab switch guard ────────────────────────────────────────
  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    final booking = context.read<BookingProvider>();

    // If user is mid-booking flow and taps away, show cancel dialog
    if (booking.isInBookingFlow) {
      _showCancelBookingDialog(
        onConfirm: () {
          booking.resetBooking();
          setState(() => _currentIndex = index);
        },
      );
    } else {
      setState(() => _currentIndex = index);
    }
  }

  // ── Cancel dialog ───────────────────────────────────────────
  void _showCancelBookingDialog({required VoidCallback onConfirm}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 26),
            SizedBox(width: 8),
            Text('Cancel Booking?'),
          ],
        ),
        content: const Text(
          'You have a booking in progress. Leaving now will lose all your selections.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(), // Stay
            child: const Text('Keep Going'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Cancel Booking',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Drawer actions ──────────────────────────────────────────
  void _onDrawerItemTapped(String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  void _onLogout() {
    Navigator.pop(context); // close drawer
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<UserProvider>().logout();
              Navigator.pushReplacementNamed(context, '/auth');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Log Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user    = context.watch<UserProvider>();
    final booking = context.watch<BookingProvider>();

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.cyan, AppColors.cyanDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: AppRadius.sm,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withOpacity(0.3),
                    blurRadius: 8, offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.flight, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 10),
            const Text(
              'Sky Trip',
              style: TextStyle(
                fontWeight: FontWeight.w800, fontSize: 20,
                color: AppColors.textPrimary, letterSpacing: -0.3,
              ),
            ),
            // Booking in-progress badge
            if (booking.isInBookingFlow) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: AppRadius.full,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.pending, color: Colors.orange, size: 14),
                    SizedBox(width: 4),
                    Text('Booking',
                        style: TextStyle(fontSize: 11, color: Colors.orange)),
                  ],
                ),
              ),
            ],
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header — uses real user data from provider
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.cyan),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 30, color: Colors.cyan),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.isLoggedIn ? 'Welcome, ${user.firstName}' : 'Welcome',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (user.isLoggedIn)
                    Text(user.email,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8), fontSize: 12)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.hotel),
              title: const Text('Book a Hotel'),
              onTap: () => _onDrawerItemTapped('/hotel-booking'),
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: const Text('Van Rental'),
              onTap: () => _onDrawerItemTapped('/van-rental'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => _onDrawerItemTapped('/settings'),
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Contact Us'),
              onTap: () => _onDrawerItemTapped('/contact-us'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: _onLogout,
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.cyan,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.flight_takeoff), label: 'Book'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    ), // Scaffold
    ); // GradientBackground
  }
}
