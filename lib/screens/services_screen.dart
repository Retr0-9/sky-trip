import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Additional Services')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TODO: Build Services\n\n- Baggage options\n- Meal preferences\n- Insurance',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            const Text(
              'Seat Selection:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Random seat → Skip to payment
                    Navigator.pushNamed(context, '/payment');
                  },
                  child: const Text('Random Seat'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Manual selection → Go to seat map
                    Navigator.pushNamed(context, '/seat-map');
                  },
                  child: const Text('Choose Seat'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
