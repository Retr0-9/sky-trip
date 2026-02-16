class FlightModel {
  final String id;
  final String airline;
  final String flightNumber;
  final String fromCode;
  final String fromCity;
  final String toCode;
  final String toCity;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String stops; // 'Direct' or '1 Stop'
  final double price;
  final String currency;
  final String travelClass;
  final int availableSeats;

  const FlightModel({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.fromCode,
    required this.fromCity,
    required this.toCode,
    required this.toCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.stops,
    required this.price,
    required this.currency,
    required this.travelClass,
    required this.availableSeats,
  });
}
