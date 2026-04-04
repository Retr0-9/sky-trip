/// Returned by all FlightSchedules search endpoints.
class FlightScheduleModel {
  final int flightScheduleId;
  final String departureCity;
  final String arrivalCity;
  final String departureTime; // e.g. "10:00:00"
  final String arrivalTime;   // e.g. "12:30:00"
  final DateTime flightDate;
  final double basePrice;
  final double classFee;
  final double totalPrice;

  const FlightScheduleModel({
    required this.flightScheduleId,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.flightDate,
    required this.basePrice,
    required this.classFee,
    required this.totalPrice,
  });

  factory FlightScheduleModel.fromJson(Map<String, dynamic> json) {
    return FlightScheduleModel(
      flightScheduleId: json['flightScheduleID'] as int,
      departureCity:    (json['departureCity']   as String? ?? '').trim(),
      arrivalCity:      (json['arrivalCity']      as String? ?? '').trim(),
      departureTime:    _trimTime(json['departureTime'] as String? ?? ''),
      arrivalTime:      _trimTime(json['arrivalTime']   as String? ?? ''),
      flightDate:       DateTime.parse(json['flightDate'] as String),
      basePrice:        (json['basePrice']  as num).toDouble(),
      classFee:         (json['classFee']   as num? ?? 0).toDouble(),
      totalPrice:       (json['totalPrice'] as num? ?? 0).toDouble(),
    );
  }

  /// Strips seconds from "HH:mm:ss" → "HH:mm"
  static String _trimTime(String t) {
    if (t.length >= 5) return t.substring(0, 5);
    return t;
  }

  /// Human-readable departure time (e.g. "10:00 AM")
  String get departureDisplay => _to12h(departureTime);
  String get arrivalDisplay   => _to12h(arrivalTime);

  static String _to12h(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length < 2) return hhmm;
    int hour = int.tryParse(parts[0]) ?? 0;
    final min = parts[1];
    final suffix = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '$hour:$min $suffix';
  }
}
