import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import 'package:skytrip/models/booked_vehicle_model.dart';
import '../widgets/ticket_card.dart';
import '../widgets/section_header.dart';
import '../data/dummy_tickets.dart';
import '../models/ticket_model.dart';
import '../models/hotel_booking_model.dart';
import '../providers/hotel_booking_provider.dart';
import '../providers/vehicle_provider.dart';

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  //  ROOT BUILD
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(context),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildFlightList(context, DummyTickets.upcoming),
              _buildHotelList(context),
              _buildVehicleList(context),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  TAB BAR
  // ─────────────────────────────────────────────
  Widget _buildTabBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: Theme.of(context).cardColor,
      child: TabBar(
        controller: _tabController,
        labelColor: colorScheme.primary,
        unselectedLabelColor: Theme.of(context).hintColor,
        indicatorColor: colorScheme.primary,
        indicatorWeight: 3,
        tabs: [
          Tab(icon: const Icon(Icons.flight),         text: l10n.ticketsUpcoming),
          Tab(icon: const Icon(Icons.hotel),          text: l10n.ticketsHotels),
          Tab(icon: const Icon(Icons.directions_car), text: l10n.ticketsVehicles),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  EMPTY STATE
  // ─────────────────────────────────────────────
  Widget _buildEmpty(BuildContext context, IconData icon, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Theme.of(context).dividerColor),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(color: Theme.of(context).hintColor, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  //  TAB 1 – FLIGHTS
  // ═══════════════════════════════════════════════
  Widget _buildFlightList(BuildContext context, List<TicketModel> tickets) {
    final l10n = AppLocalizations.of(context)!;

    if (tickets.isEmpty) {
      return _buildEmpty(context, Icons.flight_takeoff, l10n.ticketsNoUpcoming);
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionHeader(
          title:
              '${tickets.length} ${tickets.length > 1 ? l10n.ticketsFlightPlural : l10n.ticketsFlightSingular}',
          icon: Icons.flight,
        ),
        const SizedBox(height: 12),
        ...tickets.map(
          (ticket) => Padding(
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
              icon: Icons.flight,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.ticketDetail(ticket.id.toString())),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════
  //  TAB 2 – HOTELS
  // ═══════════════════════════════════════════════
  Widget _buildHotelList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hotels = context.watch<HotelBookingProvider>().allHotelBookings;

    if (hotels.isEmpty) {
      return _buildEmpty(context, Icons.hotel, l10n.ticketsNoHotelBookings);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: hotels.length,
      itemBuilder: (context, index) =>
          _buildHotelCard(context, hotels[index]),
    );
  }

  Widget _buildHotelCard(BuildContext context, HotelBookingModel hotel) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.hotel,
                    color: colorScheme.onPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel.hotelName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        hotel.location,
                        style: TextStyle(
                            color: Theme.of(context).hintColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Details ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildInfoItem(context, Icons.calendar_today,
                        l10n.ticketsCheckIn, hotel.checkInDate.toString()),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.calendar_today,
                        l10n.ticketsCheckOut, hotel.checkOutDate.toString()),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoItem(context, Icons.meeting_room_outlined,
                        l10n.hotelRooms, '${hotel.numberOfRooms}'),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.people,
                        l10n.ticketsGuests, '${hotel.numberOfGuests}'),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.king_bed_outlined,
                        l10n.hotelRoomType, hotel.roomType),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════
  //  TAB 3 – VEHICLES
  // ═══════════════════════════════════════════════
  Widget _buildVehicleList(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bookings = context.watch<VehicleProvider>().allVehicles;

    if (bookings.isEmpty) {
      return _buildEmpty(
          context, Icons.directions_car, l10n.ticketsNoVehicleBookings);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) =>
          _buildVehicleCard(context, bookings[index] as BookedVehicleModel),
    );
  }

  Widget _buildVehicleCard(BuildContext context, BookedVehicleModel booking) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondaryColor = colorScheme.secondary;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: secondaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    booking.vehicleType == 'Van'
                        ? Icons.airport_shuttle
                        : Icons.directions_car,
                    color: colorScheme.onSecondary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.vehicleName,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: secondaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              booking.vehicleType,
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.star,
                              color: Colors.amber, size: 16),
                          const SizedBox(width: 2),
                          Text(
                            '${booking.rating}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Details ──
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildInfoItem(context, Icons.my_location,
                        'Pick-up', booking.pickupLocation),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.location_on_outlined,
                        'Drop-off', booking.dropLocation),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoItem(context, Icons.calendar_today,
                        'From', booking.pickupDate),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.calendar_today,
                        'To', booking.returnDate),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoItem(context, Icons.event_seat,
                        'Seats', '${booking.seats}'),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.luggage,
                        'Bags', '${booking.bags}'),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.timer_outlined,
                        'Days', '${booking.days}'),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: booking.features.map((feature) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.grey.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        feature,
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).hintColor),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${booking.price.toStringAsFixed(0)}/day',
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor),
                    ),
                    Text(
                      'Total: \$${booking.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  SHARED HELPERS
  // ─────────────────────────────────────────────
  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Theme.of(context).hintColor),
          const SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 11, color: Theme.of(context).hintColor),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
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