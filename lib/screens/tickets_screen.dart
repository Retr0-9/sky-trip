import 'package:flutter/material.dart';
import '../widgets/ticket_card.dart';
import '../widgets/section_header.dart';
import '../data/dummy_tickets.dart';
import '../models/ticket_model.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTicketList(DummyTickets.upcoming, isUpcoming: true),
              _buildTicketList(DummyTickets.past, isUpcoming: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.cyan,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.cyan,
        indicatorWeight: 3,
        tabs: [
          Tab(text: 'Upcoming (${DummyTickets.upcoming.length})'),
          Tab(text: 'Past (${DummyTickets.past.length})'),
        ],
      ),
    );
  }

  Widget _buildTicketList(List<TicketModel> tickets, {required bool isUpcoming}) {
    if (tickets.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isUpcoming ? Icons.flight_takeoff : Icons.history,
              size: 64,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              isUpcoming ? 'No upcoming flights' : 'No past flights',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionHeader(
          title: '${tickets.length} ${isUpcoming ? 'Upcoming' : 'Past'} Flight${tickets.length > 1 ? 's' : ''}',
          icon: isUpcoming ? Icons.flight_takeoff : Icons.history,
        ),
        const SizedBox(height: 12),
        ...tickets.map((ticket) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TicketCard(
            from: ticket.fromCode,
            fromCity: ticket.fromCity,
            to: ticket.toCode,
            toCity: ticket.toCity,
            date: ticket.date,
            time: ticket.time,
            flightNumber: ticket.flightNumber,
            seatNumber: ticket.seatNumber,
            status: _mapStatus(ticket.status),
            onTap: () {
              // TODO: Navigate to ticket detail screen in Phase 5
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Ticket ${ticket.id}: TODO detail view'),
                ),
              );
            },
          ),
        )),
      ],
    );
  }

  TicketStatus _mapStatus(TicketStatusType type) {
    switch (type) {
      case TicketStatusType.upcoming:
        return TicketStatus.upcoming;
      case TicketStatusType.completed:
        return TicketStatus.completed;
      case TicketStatusType.cancelled:
        return TicketStatus.cancelled;
    }
  }
}
