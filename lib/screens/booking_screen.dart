import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/booking_search_model.dart';
import '../providers/booking_provider.dart';
import '../providers/user_provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // State variables (dummy values for now)
  String _selectedTripType = 'one_way'; // one_way, round_trip, multi_city
  int _passengerCount = 1;
  String _selectedClass = 'Economy';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Section
          _buildGreetingSection(),
          const SizedBox(height: 24),

          // Trip Type Selector
          _buildTripTypeSelector(),
          const SizedBox(height: 24),

          // From Field
          _buildSectionLabel('From'),
          const SizedBox(height: 8),
          _buildLocationField(hint: 'Departure city'),
          const SizedBox(height: 16),

          // To Field
          _buildSectionLabel('To'),
          const SizedBox(height: 8),
          _buildLocationField(hint: 'Arrival city'),
          const SizedBox(height: 16),

          // Departure Date
          _buildSectionLabel('Departure'),
          const SizedBox(height: 8),
          _buildDateField(),
          const SizedBox(height: 16),

          // Return Date (conditional on round trip)
          if (_selectedTripType == 'round_trip') ...[
            _buildSectionLabel('Return'),
            const SizedBox(height: 8),
            _buildDateField(),
            const SizedBox(height: 16),
          ],

          // Passengers and Class Row
          Row(
            children: [
              // Passengers
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel('Passengers'),
                    const SizedBox(height: 8),
                    _buildPassengerCounter(),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Class
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel('Class'),
                    const SizedBox(height: 8),
                    _buildClassSelector(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Search Button
          _buildSearchButton(),
        ],
      ),
    );
  }

  // ==================== SECTION BUILDERS ====================

  Widget _buildGreetingSection() {
    // TODO: Get actual user name and time of day
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.wb_sunny_outlined, color: Colors.orange, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Good Afternoon, User',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text(
          'Where would you like to go today?',
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTripTypeSelector() {
    // TODO: Replace with reusable tab widget in Phase 3
    return Row(
      children: [
        _buildTripTypeButton('One Way', 'one_way'),
        const SizedBox(width: 8),
        _buildTripTypeButton('Round Trip', 'round_trip'),
        const SizedBox(width: 8),
        _buildTripTypeButton('Multi City', 'multi_city'),
      ],
    );
  }

  Widget _buildTripTypeButton(String label, String value) {
    final isSelected = _selectedTripType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTripType = value;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.cyan.shade100 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.cyan.shade700 : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildLocationField({required String hint}) {
    // TODO: Replace with proper airport search widget in Phase 3
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          Text(
            hint,
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    // TODO: Replace with actual date picker in Phase 3
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today_outlined, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          Text(
            'mm/dd/yyyy',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerCounter() {
    // TODO: Replace with detailed passenger selector (Adults/Children/Infants) in Phase 3
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.person_outline, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          Text(
            '$_passengerCount Passenger${_passengerCount > 1 ? 's' : ''}',
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildClassSelector() {
    // TODO: Replace with dropdown/modal selector in Phase 3
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.airline_seat_recline_normal, color: Colors.grey.shade400),
          const SizedBox(width: 12),
          Text(
            _selectedClass,
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // TODO: Add form validation in Phase 7
          final search = BookingSearchModel(
            fromCode: 'AMM', // TODO: Get from field widget
            fromCity: 'Amman',
            toCode: 'DXB',
            toCity: 'Dubai',
            departureDate: DateTime.now(),
            tripType: _selectedTripType,
            adults: _passengerCount,
            youth: 0,
            children: 0,
            infants: 0,
            travelClass: _selectedClass,
          );
          // Save to provider
          context.read<BookingProvider>().setSearch(search);
          Navigator.pushNamed(context, '/available-flights', arguments: search);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.cyan,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Search Flights',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}
