import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/info_row.dart';
import '../widgets/primary_button.dart';
import '../models/flight_schedule_model.dart';
import '../models/booking_search_model.dart';
import '../providers/booking_provider.dart';
import '../providers/user_provider.dart';
import '../services/auth_service.dart';
import '../services/booking_service.dart';

class FlightDetailsScreen extends StatefulWidget {
  const FlightDetailsScreen({super.key});

  @override
  State<FlightDetailsScreen> createState() => _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  FlightScheduleModel? _schedule;
  BookingSearchModel?  _search;
  MultiCityItinerary?  _itinerary;
  bool _confirming = false;
  bool _loaded     = false;

  bool get _isMultiCity => _itinerary != null && _itinerary!.segments.length > 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _schedule  = args?['schedule']  as FlightScheduleModel?;
    _search    = args?['search']    as BookingSearchModel?;
    _itinerary = args?['itinerary'] as MultiCityItinerary?;
    _loaded    = true;
  }

  double get _totalBasePrice {
    if (_isMultiCity) return _itinerary!.totalPrice;
    return _schedule?.basePrice ?? 0.0;
  }

  Future<void> _confirm() async {
    if (_schedule == null) return;
    setState(() => _confirming = true);

    final user    = context.read<UserProvider>();
    final booking = context.read<BookingProvider>();
    final token   = user.token;

    try {
      final bookId = await BookingService.createBookingTrip(
        clientId:   user.clientId,
        tripTypeId: booking.tripTypeId ?? 1,
        token:      token,
      );
      booking.setBookId(bookId);

      final passengers = _search?.totalPassengers ?? 1;
      final ticketId = await BookingService.createInfoTicket(
        bookId:           bookId,
        passengerClassId: booking.selectedClassId ?? 1,
        ticketPrice:      _totalBasePrice * passengers,
        passengersCount:  passengers,
        token:            token,
      );
      booking.setTicketId(ticketId);

      if (_isMultiCity) {
        for (int i = 0; i < _itinerary!.segments.length; i++) {
          final seg = _itinerary!.segments[i];
          await BookingService.createTicketFlight(
            ticketId:         ticketId,
            flightScheduleId: seg.flightScheduleId,
            flightType:       'Leg',
            token:            token,
          );
        }
      } else {
        await BookingService.createTicketFlight(
          ticketId:         ticketId,
          flightScheduleId: _schedule!.flightScheduleId,
          flightType:       'Outbound',
          token:            token,
        );
      }

      if (!mounted) return;
      Navigator.pushNamed(context, '/passengers-form',
          arguments: {'schedule': _schedule, 'search': _search, if (_itinerary != null) 'itinerary': _itinerary});
    } on AuthException catch (e) {
      _snack(e.message, isError: true);
    } catch (_) {
      _snack(AppLocalizations.of(context)!.flightDetailsErrorCreating, isError: true);
    } finally {
      if (mounted) setState(() => _confirming = false);
    }
  }

  void _snack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? AppColors.error : AppColors.cyan,
      behavior: SnackBarBehavior.floating,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final s = _schedule;
    final passengers = _search?.totalPassengers ?? 1;
    final user = context.watch<UserProvider>();

    final price = _totalBasePrice;
    final convertedPrice = user.convertPrice(price);
    final baseFare  = convertedPrice * passengers;
    final taxes     = baseFare * 0.15;
    final total     = baseFare + taxes;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.flightDetailsTitle), elevation: 0),
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                if (_isMultiCity)
                  _buildMultiCitySummary()
                else
                  _buildFlightSummary(
                    s?.departureCity ?? '—', s?.arrivalCity ?? '—',
                    s?.departureDisplay ?? '—', s?.arrivalDisplay ?? '—', s),
                const SizedBox(height: 8),
                _buildFareBreakdown(passengers, convertedPrice, baseFare, taxes, total, user.currency),
                const SizedBox(height: 8),
                _buildBaggageInfo(),
                const SizedBox(height: 8),
                _buildPolicies(),
                const SizedBox(height: 80),
              ]),
            ),
          ),
          _buildBottomBar(),
        ]),
      ),
    );
  }

  Widget _buildMultiCitySummary() {
    final colorScheme = Theme.of(context).colorScheme;
    final travelClass = context.watch<BookingProvider>().search?.travelClass ?? 'Economy';
    final segments = _itinerary!.segments;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cyanLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cyan.withValues(alpha: 0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.connecting_airports, color: AppColors.cyan),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Multi-City Trip',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('${segments.length} legs · $travelClass',
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            ]),
          ),
        ]),
        const SizedBox(height: 16),
        ...segments.asMap().entries.map((entry) {
          final i = entry.key;
          final seg = entry.value;
          return Column(children: [
            if (i > 0) Divider(height: 20, color: AppColors.cyan.withValues(alpha: 0.3)),
            Row(children: [
              Container(
                width: 28, height: 28,
                decoration: BoxDecoration(
                  color: AppColors.cyan.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('${i + 1}',
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.cyanDark)),
                ),
              ),
              const SizedBox(width: 10),
              Text('Leg ${i + 1}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.cyanDark)),
              const SizedBox(width: 8),
              Text(_fmtDate(seg.flightDate),
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ]),
            const SizedBox(height: 12),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(seg.departureDisplay,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(seg.departureCity,
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ]),
              const Icon(Icons.arrow_forward, color: AppColors.cyan, size: 20),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(seg.arrivalDisplay,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(seg.arrivalCity,
                    style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
              ]),
            ]),
          ]);
        }),
      ]),
    );
  }

  Widget _buildFlightSummary(String depCity, String arrCity,
      String depTime, String arrTime, FlightScheduleModel? s) {
    // ── Dynamic: airline icon background ──
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cyanLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cyan.withValues(alpha: 0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: colorScheme.surface,                    
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.flight, color: AppColors.cyan),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('$depCity → $arrCity',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              if (s != null)
                Text(
                  '${_fmtDate(s.flightDate)} · ${context.watch<BookingProvider>().search?.travelClass ?? 'Economy'}',
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
            ]),
          ),
        ]),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(depTime,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(depCity,
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          ]),
          const Icon(Icons.arrow_forward, color: AppColors.cyan),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(arrTime,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(arrCity,
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
          ]),
        ]),
      ]),
    );
  }

  Widget _buildFareBreakdown(
      int passengers, double price, double baseFare, double taxes, double total, String currency) {
    // ── Dynamic: card background and border ──
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,                          // was: Colors.white
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant), // was: Colors.grey.shade200
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(AppLocalizations.of(context)!.flightDetailsFareBreakdown,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _fareRow(
          AppLocalizations.of(context)!.flightDetailsBaseFareDetail(
            passengers,
            currency,
            price.toStringAsFixed(2),
          ),
          '$currency ${baseFare.toStringAsFixed(2)}',
        ),
        const SizedBox(height: 8),
        _fareRow(AppLocalizations.of(context)!.flightDetailsTaxes,
            '$currency ${taxes.toStringAsFixed(2)}'),
        const Divider(height: 24),
        _fareRow(AppLocalizations.of(context)!.flightDetailsTotal,
            '$currency ${total.toStringAsFixed(2)}',
            isBold: true, isLarge: true),
      ]),
    );
  }

  Widget _fareRow(String label, String amount,
      {bool isBold = false, bool isLarge = false}) {
    // ── Dynamic: bold text color ──
    final colorScheme = Theme.of(context).colorScheme;

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: Text(label,
            style: TextStyle(
                fontSize: isLarge ? 16 : 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isBold
                    ? colorScheme.onSurface                  // was: Colors.black
                    : AppColors.textSecondary)),
      ),
      Text(amount,
          style: TextStyle(
              fontSize: isLarge ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isBold ? AppColors.cyan : AppColors.textSecondary)),
    ]);
  }

  Widget _buildBaggageInfo() {
    // ── Dynamic: card background and border ──
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,                          // was: Colors.white
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant), // was: Colors.grey.shade200
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(AppLocalizations.of(context)!.flightDetailsBaggage,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        InfoRow(icon: Icons.work_outline,
            label: AppLocalizations.of(context)!.flightDetailsBaggageCarry,
            value: AppLocalizations.of(context)!.flightDetailsBaggageEconomy),
        const SizedBox(height: 12),
        InfoRow(icon: Icons.luggage,
            label: AppLocalizations.of(context)!.flightDetailsBaggageChecked,
            value: AppLocalizations.of(context)!.flightDetailsBaggageBusiness),
      ]),
    );
  }

  Widget _buildPolicies() {
    // ── Dynamic: card background and border ──
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,                          // was: Colors.white
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant), // was: Colors.grey.shade200
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(AppLocalizations.of(context)!.flightDetailsPolicies,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        InfoRow(icon: Icons.cancel_outlined,
            label: AppLocalizations.of(context)!.flightDetailsCancellation,
            value: AppLocalizations.of(context)!.flightDetailsRefundableWithFee),
        const SizedBox(height: 12),
        InfoRow(icon: Icons.swap_horiz,
            label: AppLocalizations.of(context)!.flightDetailsDateChange,
            value: AppLocalizations.of(context)!.flightDetailsAllowedWithFee),
      ]),
    );
  }

  Widget _buildBottomBar() {
    // ── Dynamic: bottom bar background and shadow ──
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,                          // was: Colors.white
        boxShadow: [BoxShadow(
            color: colorScheme.shadow.withOpacity(0.12),    // was: Colors.grey.shade200
            blurRadius: 8,
            offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        child: PrimaryButton(
          label: _confirming
              ? AppLocalizations.of(context)!.flightDetailsBookingCreating
              : AppLocalizations.of(context)!.flightDetailsConfirm,
          icon: _confirming ? null : Icons.arrow_forward,
          onPressed: _confirming ? null : _confirm,
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) {
    const m = ['','Jan','Feb','Mar','Apr','May','Jun',
                'Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${m[d.month]} ${d.day}, ${d.year}';
  }
}