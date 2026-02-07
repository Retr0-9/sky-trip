import 'package:flutter/material.dart';

class HotelBookingScreen extends StatelessWidget {
  const HotelBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book a Hotel')),
      body: const Center(
        child: Text(
          'TODO: Build Hotel Booking\n\n- Search hotels\n- Filters\n- Booking flow',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
