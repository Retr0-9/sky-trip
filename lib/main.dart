import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
// ❌ تم حذف import 'package:hive_flutter/hive_flutter.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import 'package:skytrip/theme/app_theme.dart';
import 'package:skytrip/providers/user_provider.dart';
import 'package:skytrip/providers/booking_provider.dart';
import 'package:skytrip/providers/vehicle_provider.dart';
import 'package:skytrip/providers/hotel_booking_provider.dart';
import 'package:skytrip/screens/auth_screen.dart';
import 'package:skytrip/widgets/main_scaffold.dart';
import 'package:skytrip/screens/booking_screen.dart';
import 'package:skytrip/screens/available_flights_screen.dart';
import 'package:skytrip/screens/flight_details_screen.dart';
import 'package:skytrip/screens/passengers_form_screen.dart';
import 'package:skytrip/screens/services_screen.dart';
import 'package:skytrip/screens/seat_map_screen.dart';
import 'package:skytrip/screens/payment_screen.dart';
import 'package:skytrip/screens/payment_success_screen.dart';
import 'package:skytrip/screens/payment_cancel_screen.dart';
import 'package:skytrip/screens/hotel_booking_screen.dart';
import 'package:skytrip/screens/van_rental_screen.dart';
import 'package:skytrip/screens/settings_screen.dart';
import 'package:skytrip/screens/contact_us_screen.dart';
import 'package:skytrip/screens/boarding_pass_screen.dart';
import 'package:skytrip/screens/sign_up_screen.dart';
import 'package:skytrip/screens/email_verification_screen.dart';
import 'package:app_links/app_links.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userProvider = UserProvider();
  await Future.wait([
    userProvider.loadTheme(),
    userProvider.loadLanguage(),
    userProvider.loadCurrency(),
  ]);

  final vehicleProvider = VehicleProvider();
  await vehicleProvider.init();

  final hotelProvider = HotelBookingProvider();
  await hotelProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: userProvider),
        ChangeNotifierProvider.value(value: vehicleProvider),
        ChangeNotifierProvider.value(value: hotelProvider),

        // BookingProvider
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: const SkyTripApp(),
    ),
  );
}

class SkyTripApp extends StatefulWidget {
  const SkyTripApp({super.key});

  @override
  State<SkyTripApp> createState() => _SkyTripAppState();
}

class _SkyTripAppState extends State<SkyTripApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  void _initDeepLinks() {
    _appLinks = AppLinks();
    _appLinks.uriLinkStream.listen((uri) {
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    closeInAppWebView();
    // skytrip://payment-success?ticketId=XXX
    if (uri.host == 'payment-success') {
      final ticketId = int.tryParse(uri.queryParameters['ticketId'] ?? '');
      _navigatorKey.currentState?.pushNamed(
        '/payment-success',
        arguments: {'ticketId': ticketId},
      );
    }
    // skytrip://payment-cancel
    else if (uri.host == 'payment-cancel') {
      _navigatorKey.currentState?.pushNamed('/payment-cancel');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'SkyTrip',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: userProvider.themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: userProvider.locale,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            userProvider.isLoggedIn ? const MainScaffold() : const AuthScreen(),
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const MainScaffold(),

        // Booking Flow
        '/booking': (context) => const BookingScreen(),
        '/available-flights': (context) => const AvailableFlightsScreen(),
        '/flight-details': (context) => const FlightDetailsScreen(),
        '/passengers-form': (context) => const PassengersFormScreen(),
        '/services': (context) => const ServicesScreen(),
        '/seat-map': (context) => const SeatMapScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/payment-success': (context) => const PaymentSuccessScreen(),
        '/payment-cancel': (context) => const PaymentCancelScreen(),

        // Extras
        '/hotel-booking': (context) => const HotelBookingScreen(),
        '/van-rental': (context) => const VanRentalScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/contact-us': (context) => const ContactUsScreen(),
        '/boarding-pass': (context) => const BoardingPassScreen(),
        '/sign-up': (context) => const SignUpScreen(),
        '/verify-email': (context) => const EmailVerificationScreen(),
      },
    );
  }
}
