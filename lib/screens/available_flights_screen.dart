import 'package:flutter/material.dart';
import '../widgets/flight_card.dart';

class AvailableFlightsScreen extends StatefulWidget {
  const AvailableFlightsScreen({super.key});

  @override
  State<AvailableFlightsScreen> createState() => _AvailableFlightsScreenState();
}

class _AvailableFlightsScreenState extends State<AvailableFlightsScreen> {
  // TODO: Replace with actual search criteria passed from booking screen
  final String _fromCity = 'AMM';
  final String _toCity = 'DXB';
  final String _departureDate = 'Mar 15';
  final int _passengers = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Flights'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Summary Header
          _buildSearchSummary(),
          
          // Filter and Sort Bar
          _buildFilterSortBar(),
          
          const Divider(height: 1),
          
          // Flight List
          Expanded(
            child: _buildFlightList(),
          ),
        ],
      ),
    );
  }

  // ==================== SECTION BUILDERS ====================

  Widget _buildSearchSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.cyan.shade50,
      child: Row(
        children: [
          // Route
          Expanded(
            child: Row(
              children: [
                Text(
                  _fromCity,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 16),
                const SizedBox(width: 8),
                Text(
                  _toCity,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Date
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              _departureDate,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          
          // Passengers
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.person, size: 14),
                const SizedBox(width: 4),
                Text(
                  '$_passengers',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSortBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Filter Button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Show filter bottom sheet in Phase 4
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filter: TODO in Phase 4')),
                );
              },
              icon: const Icon(Icons.filter_list, size: 18),
              label: const Text('Filter'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Sort Button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // TODO: Show sort options in Phase 4
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sort: TODO in Phase 4')),
                );
              },
              icon: const Icon(Icons.sort, size: 18),
              label: const Text('Sort'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightList() {
    // TODO: Replace with actual flight data from API/dummy data in Phase 4
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5, // Dummy count
      itemBuilder: (context, index) {
        return _buildFlightCard(index);
      },
    );
  }

  Widget _buildFlightCard(int index) {
    // TODO: Replace with actual flight model data in Phase 4
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FlightCard(
        airline: 'Royal Jordanian',
        flightNumber: 'Flight RJ ${1000 + index}',
        fromCode: _fromCity,
        toCode: _toCity,
        departureTime: '10:00 AM',
        arrivalTime: '${12 + index}:30 PM',
        duration: '${2 + index}h 30m',
        stops: index % 3 == 0 ? '1 Stop' : 'Direct',
        price: '${150 + (index * 20)}',
        currency: 'JOD',
        onTap: () {
          Navigator.pushNamed(context, '/flight-details');
        },
      ),
    );
  }
}
