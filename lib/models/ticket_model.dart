enum TicketStatusType { upcoming, completed, cancelled }

class TicketModel {
  final String id;
  final String fromCode;
  final String fromCity;
  final String toCode;
  final String toCity;
  final String date;
  final String time;
  final String flightNumber;
  final String seatNumber;
  final TicketStatusType status;
  final double totalPaid;
  final String currency;

  const TicketModel({
    required this.id,
    required this.fromCode,
    required this.fromCity,
    required this.toCode,
    required this.toCity,
    required this.date,
    required this.time,
    required this.flightNumber,
    required this.seatNumber,
    required this.status,
    required this.totalPaid,
    required this.currency,
  });
}
