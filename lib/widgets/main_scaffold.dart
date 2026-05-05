import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
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

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;

    final booking = context.read<BookingProvider>();

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

  void _showCancelBookingDialog({required VoidCallback onConfirm}) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: theme.colorScheme.secondary,
              size: 26,
            ),
            const SizedBox(width: 8),
            Text(
              l10n.dialogCannotCancel,
              style: theme.textTheme.titleMedium,
            ),
          ],
        ),
        content: Text(
          l10n.dialogCancelBookingDesc,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              l10n.dialogKeepGoing,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
            ),
            child: Text(
              l10n.dialogCancel,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onDrawerItemTapped(String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  void _onLogout() {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          l10n.dialogLogout,
          style: theme.textTheme.titleMedium,
        ),
        content: Text(
          l10n.dialogLogoutConfirm,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              l10n.dialogCancel,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<UserProvider>().logout();
              Navigator.pushReplacementNamed(context, '/auth');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
            ),
            child: Text(
              l10n.dialogLogout,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onError,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final booking = context.watch<BookingProvider>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,

        // ───────────────── APP BAR ─────────────────
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          elevation: 0,

          leading: Builder(
            builder: (ctx) => IconButton(
              icon: Icon(
                Icons.menu,
                color: colorScheme.onPrimary,
              ),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),

          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colorScheme.onPrimary,
                  borderRadius: AppRadius.sm,
                ),
                child: Icon(
                  Icons.flight,
                  color: colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                l10n.appTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onPrimary,
                ),
              ),

              if (booking.isInBookingFlow) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary.withOpacity(0.2),
                    borderRadius: AppRadius.full,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.pending,
                        color: colorScheme.onPrimary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.drawerBooking,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          centerTitle: true,
        ),

        // ───────────────── DRAWER ─────────────────
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: colorScheme.onPrimary,
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      user.isLoggedIn
                          ? l10n.drawerWelcomeName(user.firstName)
                          : l10n.drawerWelcome,
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (user.isLoggedIn)
                      Text(
                        user.email,
                        style: TextStyle(
                          color: colorScheme.onPrimary.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),

              ListTile(
                leading: Icon(Icons.hotel),
                title: Text(l10n.drawerHotel),
                onTap: () => _onDrawerItemTapped('/hotel-booking'),
              ),

              ListTile(
                leading: Icon(Icons.directions_car),
                title: Text(l10n.drawerVanRental),
                onTap: () => _onDrawerItemTapped('/van-rental'),
              ),

              ListTile(
                leading: Icon(Icons.settings),
                title: Text(l10n.settingsTitle),
                onTap: () => _onDrawerItemTapped('/settings'),
              ),

              ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text(l10n.contactUsTitle),
                onTap: () => _onDrawerItemTapped('/contact-us'),
              ),

              const Divider(),

              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: colorScheme.error,
                ),
                title: Text(
                  l10n.dialogLogout,
                  style: TextStyle(
                    color: colorScheme.error,
                  ),
                ),
                onTap: _onLogout,
              ),
            ],
          ),
        ),

        // ───────────────── BODY ─────────────────
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),

        // ───────────────── BOTTOM NAV ─────────────────
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: colorScheme.primary,
          unselectedItemColor: theme.iconTheme.color,
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
      ),
    );
  }
}