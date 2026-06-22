/// A multi-city itinerary: multiple flight segments forming one trip.
class MultiCityItinerary {
  final List<FlightScheduleModel> segments;
  final double totalPrice;

  const MultiCityItinerary({
    required this.segments,
    required this.totalPrice,
  });

  String get summary => segments
      .map((s) => '${s.departureCity} → ${s.arrivalCity}')
      .join('  •  ');

  String get routeShort =>
      '${segments.first.departureCity} → ${segments.last.arrivalCity}';
}

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
    String s(List<String> keys) {
      for (final k in keys) {
        if (json[k] != null) return (json[k] as String).trim();
      }
      return '';
    }
    num n(List<String> keys) {
      for (final k in keys) {
        if (json[k] != null) return json[k] as num;
      }
      return 0;
    }

    return FlightScheduleModel(
      flightScheduleId: ((json['flightScheduleId'] ?? json['flightScheduleID']) as num?)?.toInt() ?? 0,
      departureCity:    s(['departureCity', 'DepartureCity', 'from', 'From']),
      arrivalCity:      s(['arrivalCity',   'ArrivalCity',   'to',   'To']),
      departureTime:    _trimTime(s(['departureTime', 'DepartureTime'])),
      arrivalTime:      _trimTime(s(['arrivalTime',   'ArrivalTime'])),
      flightDate:       DateTime.parse((json['date'] ?? json['flightDate'] ?? json['FlightDate'] ?? '1970-01-01') as String),
      basePrice:        n(['basePrice',  'BasePrice']).toDouble(),
      classFee:         n(['classFee',   'ClassFee']).toDouble(),
      totalPrice:       n(['totalPrice', 'TotalPrice']).toDouble(),
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
