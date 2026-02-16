import 'package:flutter/material.dart';
import '../widgets/flight_card.dart';
import '../models/booking_search_model.dart';
import '../models/flight_model.dart';
import '../data/dummy_flights.dart';

class AvailableFlightsScreen extends StatefulWidget {
  const AvailableFlightsScreen({super.key});

  @override
  State<AvailableFlightsScreen> createState() => _AvailableFlightsScreenState();
}

class _AvailableFlightsScreenState extends State<AvailableFlightsScreen> {
  late BookingSearchModel _search;
  late List<FlightModel> _flights;
  bool _argumentsLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argumentsLoaded) {
      // Receive search data from BookingScreen
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is BookingSearchModel) {
        _search = args;
      } else {
        // Fallback dummy search if no args passed
        _search = BookingSearchModel(
          fromCode: 'AMM',
          fromCity: 'Amman',
          toCode: 'DXB',
          toCity: 'Dubai',
          departureDate: DateTime(2025, 3, 15),
          tripType: 'one_way',
          adults: 1,
          youth: 0,
          children: 0,
          infants: 0,
          travelClass: 'Economy',
        );
      }
      _flights = DummyFlights.getFlights(
        fromCode: _search.fromCode,
        toCode: _search.toCode,
      );
      // Fallback: show all flights if no route match found
      if (_flights.isEmpty) {
        _flights = DummyFlights.getAllFlights();
      }
      _argumentsLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Flights'),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildSearchSummary(),
          _buildFilterSortBar(),
          const Divider(height: 1),
          Expanded(child: _buildFlightList()),
        ],
      ),
    );
  }

  Widget _buildSearchSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.cyan.shade50,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  _search.fromCode,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, size: 16),
                ),
                Text(
                  _search.toCode,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${_search.departureDate.day}/${_search.departureDate.month}/${_search.departureDate.year}',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
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
                  '${_search.totalPassengers}',
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
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filter: TODO in Phase 5')),
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
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sort: TODO in Phase 5')),
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
    if (_flights.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flight_off, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(
              'No flights found',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _flights.length,
      itemBuilder: (context, index) {
        final flight = _flights[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FlightCard(
            airline: flight.airline,
            flightNumber: flight.flightNumber,
            fromCode: flight.fromCode,
            toCode: flight.toCode,
            departureTime: flight.departureTime,
            arrivalTime: flight.arrivalTime,
            duration: flight.duration,
            stops: flight.stops,
            price: flight.price.toStringAsFixed(0),
            currency: flight.currency,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/flight-details',
                arguments: {'flight': flight, 'search': _search},
              );
            },
          ),
        );
      },
    );
  }
}
