import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import 'package:skytrip/models/booked_vehicle_model.dart';
import '../models/hotel_booking_model.dart';
import '../providers/hotel_booking_provider.dart';
import '../providers/user_provider.dart';
import '../providers/vehicle_provider.dart';
import '../services/booking_service.dart';
import '../services/auth_service.dart';
import '../models/api_ticket_model.dart';
import '../theme/app_theme.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<ApiTicketModel>? _flightTickets;
  bool _loadingTickets = false;
  String? _ticketsError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchFlightTickets();
  }

  Future<void> _fetchFlightTickets() async {
    final user = context.read<UserProvider>();
    setState(() { _loadingTickets = true; _ticketsError = null; });
    try {
      final apiTickets = await BookingService.fetchPaidTickets(token: user.token);
      if (!mounted) return;
      setState(() {
        _flightTickets = apiTickets;
        _loadingTickets = false;
      });
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() { _ticketsError = e.message; _loadingTickets = false; });
    } catch (_) {
      if (!mounted) return;
      setState(() { _ticketsError = 'Could not load tickets. Pull down to retry.'; _loadingTickets = false; });
    }
  }

  void _showTicketDetail(BuildContext context, ApiTicketModel ticket) {
    final token = context.read<UserProvider>().token;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => _TicketDetailSheet(ticketId: ticket.ticketId, token: token),
    );
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
              _buildFlightTab(context),
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
          Tab(icon: const Icon(Icons.flight), text: l10n.ticketsUpcoming),
          Tab(icon: const Icon(Icons.hotel), text: l10n.ticketsHotels),
          Tab(
              icon: const Icon(Icons.directions_car),
              text: l10n.ticketsVehicles),
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
  Widget _buildFlightTab(BuildContext context) {
    if (_loadingTickets) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_ticketsError != null) {
      return RefreshIndicator(
        onRefresh: _fetchFlightTickets,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            Icon(Icons.cloud_off, size: 56, color: Theme.of(context).hintColor),
            const SizedBox(height: 16),
            Text(
              _ticketsError!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _fetchFlightTickets,
      child: _buildFlightList(context, _flightTickets ?? []),
    );
  }

  String _group(ApiTicketModel t) {
    final s = (t.bookingStatus ?? '').toLowerCase();
    if (s == 'completed') return 'completed';
    if (s == 'cancelled' || s == 'canceled') return 'cancelled';
    if (s == 'confirmed' || s.contains('confirm')) return 'confirmed';
    return 'upcoming';
  }

  Widget _buildFlightList(BuildContext context, List<ApiTicketModel> tickets) {
    final l10n = AppLocalizations.of(context)!;
    if (tickets.isEmpty) {
      return _buildEmpty(context, Icons.flight_takeoff, l10n.ticketsNoUpcoming);
    }

    final confirmed = tickets.where((t) => _group(t) == 'confirmed').toList();
    final upcoming  = tickets.where((t) => _group(t) == 'upcoming').toList();
    final completed = tickets.where((t) => _group(t) == 'completed').toList();
    final cancelled = tickets.where((t) => _group(t) == 'cancelled').toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        if (confirmed.isNotEmpty) ...[
          _sectionHeader(context, 'Confirmed', Icons.check_circle, Colors.green, confirmed.length),
          const SizedBox(height: 10),
          ...confirmed.map((t) => _bookingCard(context, t)),
          const SizedBox(height: 16),
        ],
        if (upcoming.isNotEmpty) ...[
          _sectionHeader(context, 'Pending', Icons.hourglass_bottom, Colors.orange, upcoming.length),
          const SizedBox(height: 10),
          ...upcoming.map((t) => _bookingCard(context, t)),
          const SizedBox(height: 16),
        ],
        if (completed.isNotEmpty) ...[
          _sectionHeader(context, 'Completed', Icons.check_circle_outline, Colors.green, completed.length),
          const SizedBox(height: 10),
          ...completed.map((t) => _bookingCard(context, t)),
          const SizedBox(height: 16),
        ],
        if (cancelled.isNotEmpty) ...[
          _sectionHeader(context, 'Cancelled', Icons.cancel_outlined, Colors.red, cancelled.length),
          const SizedBox(height: 10),
          ...cancelled.map((t) => _bookingCard(context, t)),
        ],
      ],
    );
  }

  Widget _sectionHeader(BuildContext context, String title, IconData icon, Color color, int count) {
    final theme = Theme.of(context);
    return Row(children: [
      Icon(icon, size: 18, color: color),
      const SizedBox(width: 8),
      Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: color)),
      const SizedBox(width: 6),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text('$count', style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
      ),
    ]);
  }

  Widget _bookingCard(BuildContext context, ApiTicketModel t) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final group  = _group(t);
    final statusColor = group == 'confirmed' ? Colors.green
        : group == 'completed' ? Colors.green
        : group == 'cancelled' ? Colors.red
        : Colors.orange;
    final ps = t.paymentStatus ?? '';

    // Format booking date
    String dateStr = '--';
    if (t.bookingDate != null) {
      const m = ['','Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      final d = t.bookingDate!;
      dateStr = '${m[d.month]} ${d.day}, ${d.year}';
    }

    return GestureDetector(
      onTap: () => _showTicketDetail(context, t),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDark ? theme.cardColor : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: statusColor.withValues(alpha: 0.3)),
          boxShadow: [BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.shade200,
            blurRadius: 8, offset: const Offset(0, 3),
          )],
        ),
        child: Column(children: [
          // ── Cyan header bar ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(children: [
              Icon(Icons.confirmation_number_outlined, color: statusColor, size: 18),
              const SizedBox(width: 8),
              Text('Booking #${t.ticketId}',
                  style: TextStyle(fontWeight: FontWeight.bold, color: statusColor, fontSize: 14)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  t.bookingStatus ?? 'Pending',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: statusColor),
                ),
              ),
            ]),
          ),
          // ── Details ──
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              _cardInfo(context, Icons.people_outline, 'Passengers', '${t.passengersCount}'),
              const SizedBox(width: 16),
              _cardInfo(context, Icons.calendar_today_outlined, 'Booked', dateStr),
              const SizedBox(width: 16),
              _cardInfo(context, Icons.payment_outlined, 'Payment', ps.isEmpty ? '--' : ps),
              const Spacer(),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('JOD ${t.ticketPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.cyan)),
                const Text('total', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
              ]),
            ]),
          ),
          // ── Tap hint ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: theme.dividerColor.withValues(alpha: 0.08),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(14)),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('Tap to view details', style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 14, color: AppColors.textSecondary),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _cardInfo(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(icon, size: 12, color: theme.hintColor),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: theme.hintColor)),
      ]),
      const SizedBox(height: 2),
      Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    ]);
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
      itemBuilder: (context, index) => _buildHotelCard(context, hotels[index]),
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
                        style: TextStyle(color: Theme.of(context).hintColor),
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
                    _buildInfoItem(context, Icons.people, l10n.ticketsGuests,
                        '${hotel.numberOfGuests}'),
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
          _buildVehicleCard(context, bookings[index]),
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
                          const Icon(Icons.star, color: Colors.amber, size: 16),
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
                    _buildInfoItem(context, Icons.my_location, 'Pick-up',
                        booking.pickupLocation),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.location_on_outlined,
                        'Drop-off', booking.dropLocation),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoItem(context, Icons.calendar_today, 'From',
                        booking.pickupDate),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.calendar_today, 'To',
                        booking.returnDate),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoItem(
                        context, Icons.event_seat, 'Seats', '${booking.seats}'),
                    const SizedBox(width: 16),
                    _buildInfoItem(
                        context, Icons.luggage, 'Bags', '${booking.bags}'),
                    const SizedBox(width: 16),
                    _buildInfoItem(context, Icons.timer_outlined, 'Days',
                        '${booking.days}'),
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
                            fontSize: 12, color: Theme.of(context).hintColor),
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
                          fontSize: 14, color: Theme.of(context).hintColor),
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

}

// ── Ticket detail bottom sheet ────────────────────────────────────────────────

class _TicketDetailSheet extends StatefulWidget {
  final int ticketId;
  final String token;

  const _TicketDetailSheet({
    required this.ticketId,
    required this.token,
  });

  @override
  State<_TicketDetailSheet> createState() => _TicketDetailSheetState();
}

class _TicketDetailSheetState extends State<_TicketDetailSheet> {
  ApiTicketDetailModel? _detail;
  bool _loading = true;
  bool _cancelling = false;
  String? _error;

  bool get _isCancelled =>
      (_detail?.bookingStatus ?? '').toLowerCase().contains('cancel');

  bool get _isConfirmed =>
      (_detail?.bookingStatus ?? '').toLowerCase().contains('confirm');

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _confirmCancel() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 24),
          SizedBox(width: 8),
          Text('Cancel Ticket'),
        ]),
        content: const Text(
          'Are you sure you want to cancel this ticket? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('No, Keep It'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() => _cancelling = true);
    try {
      await BookingService.cancelTicket(
        ticketId: widget.ticketId,
        token: widget.token,
      );
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Ticket cancelled successfully.'),
        backgroundColor: AppColors.cyan,
        behavior: SnackBarBehavior.floating,
      ));
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not cancel ticket. Please try again.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ));
      }
    } finally {
      if (mounted) setState(() => _cancelling = false);
    }
  }

  Future<void> _load() async {
    try {
      final d = await BookingService.fetchTicketDetail(
          ticketId: widget.ticketId, token: widget.token);
      if (mounted) setState(() { _detail = d; _loading = false; });
    } catch (_) {
      if (mounted) setState(() { _error = 'Could not load details.'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      maxChildSize: 0.92,
      builder: (_, ctrl) => Column(children: [
        const SizedBox(height: 12),
        Container(width: 40, height: 4,
            decoration: BoxDecoration(color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            const Icon(Icons.confirmation_number_outlined, color: AppColors.cyan),
            const SizedBox(width: 8),
            Text('Booking #${widget.ticketId}',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ]),
        ),
        const SizedBox(height: 4),
        if (_loading)
          const Expanded(child: Center(child: CircularProgressIndicator(color: AppColors.cyan)))
        else if (_error != null)
          Expanded(child: Center(child: Text(_error!, style: const TextStyle(color: AppColors.error))))
        else
          Expanded(child: ListView(controller: ctrl, padding: const EdgeInsets.all(20), children: [
            _statusRow(cs),
            const SizedBox(height: 16),
            if (_detail != null && _detail!.flights.isNotEmpty) ...[
              _sectionTitle('Flights', Icons.flight),
              const SizedBox(height: 8),
              ..._detail!.flights.map(_flightTile),
              const SizedBox(height: 16),
            ],
            if (_detail != null && _detail!.passengers.isNotEmpty) ...[
              _sectionTitle('Passengers', Icons.people_outline),
              const SizedBox(height: 8),
              ..._detail!.passengers.map(_passengerTile),
              const SizedBox(height: 16),
            ],
            if (_detail != null && _detail!.services.isNotEmpty) ...[
              _sectionTitle('Services', Icons.room_service_outlined),
              const SizedBox(height: 8),
              ..._detail!.services.map(_serviceTile),
              const SizedBox(height: 16),
            ],
            _priceRow(context),
            if ((_detail?.bookingStatus ?? '').toLowerCase() == 'confirmed') ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      '/boarding-pass',
                      arguments: _detail,
                    );
                  },
                  icon: const Icon(Icons.airplane_ticket_outlined),
                  label: const Text('Show Boarding Pass'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyan,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
            if (!_isCancelled && !_isConfirmed) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _cancelling ? null : _confirmCancel,
                  icon: _cancelling
                      ? const SizedBox(width: 16, height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.error))
                      : const Icon(Icons.cancel_outlined, size: 18),
                  label: Text(_cancelling ? 'Cancelling...' : 'Cancel Ticket'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ])),
      ]),
    );
  }

  Widget _statusRow(ColorScheme cs) {
    final booking = (_detail?.bookingStatus ?? '').toLowerCase();
    final payment = (_detail?.paymentStatus ?? '').toLowerCase();
    final isConfirmed = booking == 'confirmed' || booking.contains('confirm');
    final isPaid = payment == 'paid';

    final badges = <Widget>[];

    // Booking status badge
    final bookingColor = isConfirmed ? Colors.green : Colors.orange;
    final bookingLabel = isConfirmed ? 'Confirmed' : (_detail?.bookingStatus ?? 'Pending');
    badges.add(_statusBadge(
      icon: isConfirmed ? Icons.check_circle : Icons.hourglass_bottom,
      label: bookingLabel,
      color: bookingColor,
    ));

    // Payment status badge
    final payColor = isPaid ? Colors.green : Colors.orange;
    final payLabel = isPaid ? 'Paid' : (_detail?.paymentStatus ?? 'Pending');
    badges.add(_statusBadge(
      icon: isPaid ? Icons.payment : Icons.hourglass_bottom,
      label: payLabel,
      color: payColor,
    ));

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...badges,
        if ((_detail?.bookingReference ?? '').isNotEmpty)
          Text('Ref: ${_detail!.bookingReference}',
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _statusBadge({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      ]),
    );
  }

  Widget _sectionTitle(String title, IconData icon) => Row(children: [
    Icon(icon, size: 16, color: AppColors.cyan),
    const SizedBox(width: 6),
    Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
  ]);

  Widget _flightTile(ApiTicketDetailFlight f) {
    final dep = f.departureDateTime != null
        ? _fmtDt(f.departureDateTime!) : '--:--';
    final arr = f.arrivalDateTime != null
        ? _fmtDt(f.arrivalDateTime!) : '--:--';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cyanLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${f.departureCity} → ${f.arrivalCity}',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          Text('$dep → $arr',
              style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
        if (f.flightType != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(f.flightType!,
                style: const TextStyle(fontSize: 11, color: AppColors.cyanDark,
                    fontWeight: FontWeight.w600)),
          ),
      ]),
    );
  }

  Widget _passengerTile(ApiTicketDetailPassenger p) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(children: [
      const Icon(Icons.person_outline, size: 16, color: AppColors.cyan),
      const SizedBox(width: 8),
      Expanded(child: Text('${p.firstName} ${p.lastName}',
          style: const TextStyle(fontSize: 13))),
      if (p.gender != null)
        Text(p.gender!, style: const TextStyle(fontSize: 12,
            color: AppColors.textSecondary)),
    ]),
  );

  Widget _serviceTile(ApiTicketDetailService s) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(children: [
      const Icon(Icons.check_circle_outline, size: 16, color: AppColors.cyan),
      const SizedBox(width: 8),
      Expanded(child: Text(s.serviceName,
          style: const TextStyle(fontSize: 13))),
      Text('×${s.quantity}',
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      const SizedBox(width: 8),
      Text('JOD ${(s.serviceFee * s.quantity).toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
    ]),
  );

  Widget _priceRow(BuildContext context) {
    final price = _detail?.ticketPrice ?? 0.0;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text('Total Paid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      Text('JOD ${price.toStringAsFixed(2)}',
          style: const TextStyle(fontWeight: FontWeight.bold,
              fontSize: 18, color: AppColors.cyan)),
    ]);
  }

  String _fmtDt(String iso) {
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m = dt.minute.toString().padLeft(2, '0');
    final s = dt.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $s';
  }
}
