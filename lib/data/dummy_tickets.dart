import '../models/ticket_model.dart';

class DummyTickets {
  static const List<TicketModel> tickets = [
    // Upcoming
    TicketModel(
      id: 'tkt001',
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'DXB',
      toCity: 'Dubai',
      date: 'Mar 15',
      time: '10:00 AM',
      flightNumber: 'RJ 501',
      seatNumber: '14A',
      status: TicketStatusType.upcoming,
      totalPaid: 150.0,
      currency: 'JOD',
    ),
    TicketModel(
      id: 'tkt002',
      fromCode: 'DXB',
      fromCity: 'Dubai',
      toCode: 'AMM',
      toCity: 'Amman',
      date: 'Mar 22',
      time: '02:30 PM',
      flightNumber: 'RJ 502',
      seatNumber: '22C',
      status: TicketStatusType.upcoming,
      totalPaid: 155.0,
      currency: 'JOD',
    ),

    // Completed
    TicketModel(
      id: 'tkt003',
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'LHR',
      toCity: 'London',
      date: 'Jan 10',
      time: '08:00 AM',
      flightNumber: 'RJ 111',
      seatNumber: '5B',
      status: TicketStatusType.completed,
      totalPaid: 320.0,
      currency: 'JOD',
    ),
    TicketModel(
      id: 'tkt004',
      fromCode: 'LHR',
      fromCity: 'London',
      toCode: 'AMM',
      toCity: 'Amman',
      date: 'Jan 20',
      time: '11:00 AM',
      flightNumber: 'RJ 112',
      seatNumber: '5B',
      status: TicketStatusType.completed,
      totalPaid: 310.0,
      currency: 'JOD',
    ),

    // Cancelled
    TicketModel(
      id: 'tkt005',
      fromCode: 'AMM',
      fromCity: 'Amman',
      toCode: 'CAI',
      toCity: 'Cairo',
      date: 'Dec 05',
      time: '03:00 PM',
      flightNumber: 'RJ 201',
      seatNumber: '18F',
      status: TicketStatusType.cancelled,
      totalPaid: 85.0,
      currency: 'JOD',
    ),
  ];

  static List<TicketModel> get upcoming =>
      tickets.where((t) => t.status == TicketStatusType.upcoming).toList();

  static List<TicketModel> get past =>
      tickets.where((t) => t.status != TicketStatusType.upcoming).toList();
}
