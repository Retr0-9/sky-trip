import 'ticket_model.dart';

class ApiTicketModel {
  final int ticketId;
  final int bookId;
  final double ticketPrice;
  final int passengersCount;
  final String? departureCity;
  final String? arrivalCity;
  final DateTime? flightDate;
  final String? departureTime;
  final String? arrivalTime;
  final String? flightNumber;
  final String? seatNumber;
  final String? bookingStatus;
  final String? paymentStatus;
  final double? amount;
  final String? currency;
  final DateTime? bookingDate;
  final bool isActive;

  const ApiTicketModel({
    required this.ticketId,
    required this.bookId,
    required this.ticketPrice,
    required this.passengersCount,
    this.departureCity,
    this.arrivalCity,
    this.flightDate,
    this.departureTime,
    this.arrivalTime,
    this.flightNumber,
    this.seatNumber,
    this.bookingStatus,
    this.paymentStatus,
    this.amount,
    this.currency,
    this.bookingDate,
    required this.isActive,
  });

  factory ApiTicketModel.fromJson(Map<String, dynamic> json) {
    return ApiTicketModel(
      ticketId:        ((json['ticketID']       ?? json['ticketId'])       as num? ?? 0).toInt(),
      bookId:          ((json['bookID']          ?? json['bookId'])         as num? ?? 0).toInt(),
      ticketPrice:     (json['ticketPrice']      as num? ?? 0).toDouble(),
      passengersCount: (json['passengersCount']  as num? ?? 1).toInt(),
      departureCity:   json['departureCity']     as String?,
      arrivalCity:     json['arrivalCity']       as String?,
      flightDate:      json['flightDate'] != null
          ? DateTime.tryParse(json['flightDate'] as String)
          : null,
      departureTime:   json['departureTime']     as String?,
      arrivalTime:     json['arrivalTime']       as String?,
      flightNumber:    json['flightNumber']      as String?,
      seatNumber:      json['seatNumber']        as String?,
      bookingStatus:   json['bookingStatus']     as String?,
      paymentStatus:   json['paymentStatus']     as String?,
      amount:          (json['amount']           as num?)?.toDouble(),
      currency:        json['currency']          as String?,
      bookingDate:     json['bookingDate'] != null
          ? DateTime.tryParse(json['bookingDate'] as String)
          : null,
      isActive:        json['isActive']          as bool? ?? true,
    );
  }

  TicketModel toTicketModel() {
    return TicketModel(
      id:           ticketId.toString(),
      fromCode:     _cityCode(departureCity),
      fromCity:     departureCity ?? '--',
      toCode:       _cityCode(arrivalCity),
      toCity:       arrivalCity ?? '--',
      date:         flightDate != null ? _fmtDate(flightDate!) : '--',
      time:         departureTime != null ? _fmt12h(departureTime!) : '--',
      flightNumber: flightNumber ?? 'N/A',
      seatNumber:   seatNumber ?? '--',
      status:       _mapStatus(),
      totalPaid:    ticketPrice,
      currency:     'JOD',
    );
  }

  TicketStatusType _mapStatus() {
    switch (bookingStatus?.toLowerCase()) {
      case 'cancelled':  return TicketStatusType.cancelled;
      case 'completed':  return TicketStatusType.completed;
      default:           return TicketStatusType.upcoming;
    }
  }

  static String _cityCode(String? city) {
    if (city == null || city.isEmpty) return '---';
    final trimmed = city.trim();
    return trimmed.substring(0, trimmed.length >= 3 ? 3 : trimmed.length).toUpperCase();
  }

  static String _fmtDate(DateTime d) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[d.month]} ${d.day}';
  }

  static String _fmt12h(String hhmm) {
    final parts = hhmm.split(':');
    if (parts.length < 2) return hhmm;
    int hour = int.tryParse(parts[0]) ?? 0;
    final min = parts[1].padLeft(2, '0');
    final suffix = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12;
    return '$hour:$min $suffix';
  }
}

// ── Detail models for GET /api/tickets/my/{id} ───────────────────────────────

class ApiTicketDetailFlight {
  final int flightScheduleId;
  final String departureCity;
  final String arrivalCity;
  final String? departureDateTime;
  final String? arrivalDateTime;
  final String? flightType;

  const ApiTicketDetailFlight({
    required this.flightScheduleId,
    required this.departureCity,
    required this.arrivalCity,
    this.departureDateTime,
    this.arrivalDateTime,
    this.flightType,
  });

  factory ApiTicketDetailFlight.fromJson(Map<String, dynamic> j) {
    String s(List<String> keys) {
      for (final k in keys) { if (j[k] != null) return (j[k] as String).trim(); }
      return '';
    }
    return ApiTicketDetailFlight(
      flightScheduleId: ((j['flightScheduleID'] ?? j['flightScheduleId']) as num? ?? 0).toInt(),
      departureCity:    s(['departureCity', 'DepartureCity']),
      arrivalCity:      s(['arrivalCity',   'ArrivalCity']),
      departureDateTime: j['departureDateTime'] as String?,
      arrivalDateTime:   j['arrivalDateTime']   as String?,
      flightType:        j['flightType']         as String?,
    );
  }
}

class ApiTicketDetailPassenger {
  final int passengerId;
  final String firstName;
  final String lastName;
  final String? gender;
  final String? documentationType;

  const ApiTicketDetailPassenger({
    required this.passengerId,
    required this.firstName,
    required this.lastName,
    this.gender,
    this.documentationType,
  });

  factory ApiTicketDetailPassenger.fromJson(Map<String, dynamic> j) =>
      ApiTicketDetailPassenger(
        passengerId:       ((j['passengerId'] ?? j['PassengerId']) as num? ?? 0).toInt(),
        firstName:         (j['firstName']  ?? j['FirstName']  ?? '') as String,
        lastName:          (j['lastName']   ?? j['LastName']   ?? '') as String,
        gender:            (j['gender']     ?? j['Gender'])           as String?,
        documentationType: (j['documentationType'] ?? j['DocumentationType']) as String?,
      );
}

class ApiTicketDetailService {
  final String serviceName;
  final int quantity;
  final double serviceFee;

  const ApiTicketDetailService({
    required this.serviceName,
    required this.quantity,
    required this.serviceFee,
  });

  factory ApiTicketDetailService.fromJson(Map<String, dynamic> j) =>
      ApiTicketDetailService(
        serviceName: (j['serviceName'] ?? j['ServiceName'] ?? '') as String,
        quantity:    (j['quantity']    ?? j['Quantity']    ?? 1)  as int,
        serviceFee:  ((j['serviceFee'] ?? j['ServiceFee']  ?? 0)  as num).toDouble(),
      );
}

class ApiTicketDetailModel {
  final int ticketId;
  final int bookId;
  final String? bookingStatus;
  final String? paymentStatus;
  final String? bookingReference;
  final double ticketPrice;
  final int passengersCount;
  final List<ApiTicketDetailFlight> flights;
  final List<ApiTicketDetailPassenger> passengers;
  final List<ApiTicketDetailService> services;

  const ApiTicketDetailModel({
    required this.ticketId,
    required this.bookId,
    this.bookingStatus,
    this.paymentStatus,
    this.bookingReference,
    required this.ticketPrice,
    required this.passengersCount,
    required this.flights,
    required this.passengers,
    required this.services,
  });

  factory ApiTicketDetailModel.fromJson(Map<String, dynamic> json) {
    final summary = json['summary'] as Map<String, dynamic>? ?? json;
    List<T> parseList<T>(String key, T Function(Map<String, dynamic>) fn) {
      final raw = json[key];
      if (raw is! List) return [];
      return raw.map((e) => fn(e as Map<String, dynamic>)).toList();
    }

    return ApiTicketDetailModel(
      ticketId:         ((summary['ticketID']    ?? summary['ticketId'])    as num? ?? 0).toInt(),
      bookId:           ((summary['bookID']       ?? summary['bookId'])      as num? ?? 0).toInt(),
      bookingStatus:    summary['bookingStatus']  as String?,
      paymentStatus:    summary['paymentStatus']  as String?,
      bookingReference: summary['bookingReference'] as String?,
      ticketPrice:      (summary['ticketPrice']   as num? ?? 0).toDouble(),
      passengersCount:  (summary['passengersCount'] as num? ?? 1).toInt(),
      flights:    parseList('flights',    ApiTicketDetailFlight.fromJson),
      passengers: parseList('passengers', ApiTicketDetailPassenger.fromJson),
      services:   parseList('services',  ApiTicketDetailService.fromJson),
    );
  }
}
