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
  final String? status;
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
    this.status,
    required this.isActive,
  });

  factory ApiTicketModel.fromJson(Map<String, dynamic> json) {
    return ApiTicketModel(
      ticketId:        (json['ticketID']        ?? json['ticketId']        ?? 0) as int,
      bookId:          (json['bookID']           ?? json['bookId']           ?? 0) as int,
      ticketPrice:     (json['ticketPrice']      as num? ?? 0).toDouble(),
      passengersCount: (json['passengersCount']  as int? ?? 1),
      departureCity:   json['departureCity']     as String?,
      arrivalCity:     json['arrivalCity']       as String?,
      flightDate:      json['flightDate'] != null
          ? DateTime.tryParse(json['flightDate'] as String)
          : null,
      departureTime:   json['departureTime']     as String?,
      arrivalTime:     json['arrivalTime']       as String?,
      flightNumber:    json['flightNumber']      as String?,
      seatNumber:      json['seatNumber']        as String?,
      status:          json['status']            as String?,
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
    switch (status?.toLowerCase()) {
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
