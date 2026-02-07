import 'package:flutter/material.dart';

class SeatMapScreen extends StatelessWidget {
  const SeatMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Seat')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TODO: Build Seat Map\n\n- Interactive grid\n- Available/Occupied indicators\n- Seat pricing',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/payment');
              },
              child: const Text('Confirm Seat (Placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}
