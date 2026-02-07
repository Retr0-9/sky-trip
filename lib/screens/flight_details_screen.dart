import 'package:flutter/material.dart';

class FlightDetailsScreen extends StatelessWidget {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flight Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TODO: Build Flight Details\n\n- Airline, time, duration\n- Price breakdown\n- Confirm button',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/passengers-form');
              },
              child: const Text('Continue to Passengers (Placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}
