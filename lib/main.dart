import 'package:flutter/material.dart';
import 'widgets/main_scaffold.dart';
import 'screens/available_flights_screen.dart';
import 'screens/flight_details_screen.dart';
import 'screens/passengers_form_screen.dart';
import 'screens/services_screen.dart';
import 'screens/seat_map_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/hotel_booking_screen.dart';
import 'screens/van_rental_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/contact_us_screen.dart';

void main() {
  runApp(const SkyTripApp());
}

class SkyTripApp extends StatelessWidget {
  const SkyTripApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sky Trip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const MainScaffold(),
      routes: {
        '/available-flights': (context) => const AvailableFlightsScreen(),
        '/flight-details': (context) => const FlightDetailsScreen(),
        '/passengers-form': (context) => const PassengersFormScreen(),
        '/services': (context) => const ServicesScreen(),
        '/seat-map': (context) => const SeatMapScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/hotel-booking': (context) => const HotelBookingScreen(),
        '/van-rental': (context) => const VanRentalScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/contact-us': (context) => const ContactUsScreen(),
      },
    );
  }
}
