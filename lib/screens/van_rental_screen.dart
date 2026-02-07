import 'package:flutter/material.dart';

class VanRentalScreen extends StatelessWidget {
  const VanRentalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Van Rental')),
      body: const Center(
        child: Text(
          'TODO: Build Van Rental\n\n- Available vehicles\n- Pickup/Return dates\n- Pricing',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
