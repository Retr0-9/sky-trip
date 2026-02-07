import 'package:flutter/material.dart';

class AvailableFlightsScreen extends StatelessWidget {
  const AvailableFlightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Flights')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TODO: Build Flight List\n\n- Flight cards\n- Filter/Sort options',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/flight-details');
              },
              child: const Text('Select Flight (Placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}
