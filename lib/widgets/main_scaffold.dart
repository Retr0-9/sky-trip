import 'package:flutter/material.dart';
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

  // TODO: Track if user is in booking flow (will be implemented with state management)
  bool _isInBookingFlow = false;

  final List<Widget> _screens = const [
    HomeScreen(),
    BookingScreen(),
    TicketsScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    // TODO: If _isInBookingFlow is true, show "Cancel booking?" dialog
    // For now, just switch tabs
    setState(() {
      _currentIndex = index;
    });
  }

  void _onDrawerItemTapped(String route) {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, route);
  }

  void _onLogout() {
    Navigator.pop(context); // Close drawer
    // TODO: Implement logout logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout clicked - TODO: Implement')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.flight, color: Colors.cyan),
            const SizedBox(width: 8),
            const Text('Sky Trip'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.cyan),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 30),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Welcome, User',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flight_takeoff),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
