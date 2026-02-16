class BookingSearchModel {
  final String fromCode;
  final String fromCity;
  final String toCode;
  final String toCity;
  final DateTime departureDate;
  final DateTime? returnDate;
  final String tripType; // 'one_way', 'round_trip', 'multi_city'
  final int adults;
  final int youth;
  final int children;
  final int infants;
  final String travelClass;

  const BookingSearchModel({
    required this.fromCode,
    required this.fromCity,
    required this.toCode,
    required this.toCity,
    required this.departureDate,
    this.returnDate,
    required this.tripType,
    required this.adults,
    required this.youth,
    required this.children,
    required this.infants,
    required this.travelClass,
  });

  int get totalPassengers => adults + youth + children + infants;
}
