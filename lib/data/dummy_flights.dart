import '../models/flight_model.dart';

class DummyFlights {
  static List<FlightModel> getFlights({
    required String fromCode,
    required String toCode,
  }) {
    // TODO: Replace with API call in Phase 6
    // Returns dummy flights filtered by route
    return _allFlights
        .where((f) => f.fromCode == fromCode && f.toCode == toCode)
        .toList();
  }

  static List<FlightModel> getAllFlights() => _allFlights;

  static const List<FlightModel> _allFlights = [
    // AMM → DXB
    FlightModel(
      id: 'rj501',
      airline: 'Royal Jordanian',
      flightNumber: 'RJ 501',
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'DXB',
      toCity: 'Dubai',
      departureTime: '10:00 AM',
      arrivalTime: '12:30 PM',
      duration: '2h 30m',
      stops: 'Direct',
      price: 150.0,
      currency: 'JOD',
      travelClass: 'Economy',
      availableSeats: 42,
    ),
    FlightModel(
      id: 'ek903',
      airline: 'Emirates',
      flightNumber: 'EK 903',
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'DXB',
      toCity: 'Dubai',
      departureTime: '02:00 PM',
      arrivalTime: '04:30 PM',
      duration: '2h 30m',
      stops: 'Direct',
      price: 175.0,
      currency: 'JOD',
      travelClass: 'Economy',
      availableSeats: 18,
    ),
    FlightModel(
      id: 'fy201',
      airline: 'Flynas',
      flightNumber: 'FY 201',
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'DXB',
      toCity: 'Dubai',
      departureTime: '07:00 PM',
      arrivalTime: '11:30 PM',
      duration: '4h 30m',
      stops: '1 Stop',
      price: 120.0,
      currency: 'JOD',
      travelClass: 'Economy',
      availableSeats: 60,
    ),

    // AMM → LHR
    FlightModel(
      id: 'rj111',
      airline: 'Royal Jordanian',
      flightNumber: 'RJ 111',
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'LHR',
      toCity: 'London',
      departureTime: '08:00 AM',
      arrivalTime: '01:00 PM',
      duration: '5h 00m',
      stops: 'Direct',
      price: 320.0,
      currency: 'JOD',
      travelClass: 'Economy',
      availableSeats: 24,
    ),
    FlightModel(
      id: 'ba156',
      airline: 'British Airways',
      flightNumber: 'BA 156',
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'LHR',
      toCity: 'London',
      departureTime: '11:30 AM',
      arrivalTime: '04:45 PM',
      duration: '5h 15m',
      stops: 'Direct',
      price: 350.0,
      currency: 'JOD',
      travelClass: 'Economy',
      availableSeats: 10,
    ),

    // AMM → CAI
    FlightModel(
      id: 'rj201',
      airline: 'Royal Jordanian',
      flightNumber: 'RJ 201',
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'CAI',
      toCity: 'Cairo',
      departureTime: '09:00 AM',
      arrivalTime: '10:15 AM',
      duration: '1h 15m',
      stops: 'Direct',
      price: 85.0,
      currency: 'JOD',
      travelClass: 'Economy',
      availableSeats: 55,
    ),
  ];
}
