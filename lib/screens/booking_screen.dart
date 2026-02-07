import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'TODO: Build Booking Form\n\n- From/To fields\n- Date picker\n- Passenger count\n- Search button',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // TODO: Validate form, then navigate
              Navigator.pushNamed(context, '/available-flights');
            },
            child: const Text('Search Flights (Placeholder)'),
          ),
        ],
      ),
    );
  }
}
