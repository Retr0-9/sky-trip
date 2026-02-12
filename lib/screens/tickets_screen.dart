import 'package:flutter/material.dart';
import '../widgets/ticket_card.dart';
import '../widgets/section_header.dart';

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
        // Tab Bar
        _buildTabBar(),

        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [_buildUpcomingTickets(), _buildPastTickets()],
          ),
        ),
      ],
    );
  }

  // ==================== SECTION BUILDERS ====================

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.cyan,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.cyan,
        indicatorWeight: 3,
        tabs: const [
          Tab(text: 'Upcoming'),
          Tab(text: 'Past'),
        ],
      ),
    );
  }

  Widget _buildUpcomingTickets() {
    // TODO: Replace with real ticket data from API in Phase 4
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionHeader(title: '2 Upcoming Flights', icon: Icons.flight_takeoff),
        const SizedBox(height: 12),

        TicketCard(
          from: 'AMM',
          fromCity: 'Amman',
          to: 'DXB',
          toCity: 'Dubai',
          date: 'Mar 15',
          time: '10:00 AM',
          flightNumber: 'RJ 501',
          seatNumber: '14A',
          status: TicketStatus.upcoming,
          onTap: () {
            // TODO: Navigate to ticket details
          },
        ),
        const SizedBox(height: 16),

        TicketCard(
          from: 'DXB',
          fromCity: 'Dubai',
          to: 'AMM',
          toCity: 'Amman',
          date: 'Mar 22',
          time: '02:30 PM',
          flightNumber: 'RJ 502',
          seatNumber: '22C',
          status: TicketStatus.upcoming,
          onTap: () {
            // TODO: Navigate to ticket details
          },
        ),
      ],
    );
  }

  Widget _buildPastTickets() {
    // TODO: Replace with real ticket data from API in Phase 4
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionHeader(title: '3 Past Flights', icon: Icons.history),
        const SizedBox(height: 12),

        TicketCard(
          from: 'AMM',
          fromCity: 'Amman',
          to: 'LHR',
          toCity: 'London',
          date: 'Jan 10',
          time: '08:00 AM',
          flightNumber: 'RJ 111',
          seatNumber: '5B',
          status: TicketStatus.completed,
          onTap: () {},
        ),
        const SizedBox(height: 16),

        TicketCard(
          from: 'LHR',
          fromCity: 'London',
          to: 'AMM',
          toCity: 'Amman',
          date: 'Jan 20',
          time: '11:00 AM',
          flightNumber: 'RJ 112',
          seatNumber: '5B',
          status: TicketStatus.completed,
          onTap: () {},
        ),
        const SizedBox(height: 16),

        TicketCard(
          from: 'AMM',
          fromCity: 'Amman',
          to: 'CAI',
          toCity: 'Cairo',
          date: 'Dec 05',
          time: '03:00 PM',
          flightNumber: 'RJ 201',
          seatNumber: '18F',
          status: TicketStatus.cancelled,
          onTap: () {},
        ),
      ],
    );
  }
}
