import 'package:flutter/material.dart';

class PassengersFormScreen extends StatelessWidget {
  const PassengersFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Passenger Information')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'TODO: Build Passenger Form\n\n- Name, passport, DOB fields\n- Multiple passengers support',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/services');
              },
              child: const Text('Continue to Services (Placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}
