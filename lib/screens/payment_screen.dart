import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/flight_schedule_model.dart';
import '../models/booking_search_model.dart';
import '../providers/booking_provider.dart';
import '../providers/user_provider.dart';
import '../services/payment_service.dart';
import '../services/booking_service.dart';
import '../services/auth_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  FlightScheduleModel? _schedule;
  BookingSearchModel?  _search;
  bool _loaded = false;

  bool _launching  = false;
  bool _polling    = false;
  bool _confirmed  = false;
  String _status   = '';   // 'waiting' | 'paid' | 'failed'
  Timer? _pollTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _schedule = args?['schedule'] as FlightScheduleModel?;
    _search   = args?['search']   as BookingSearchModel?;
    _loaded = true;
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _startPayment() async {
    final booking  = context.read<BookingProvider>();
    final token    = context.read<UserProvider>().token;
    final ticketId = booking.ticketId;

    if (ticketId == null) {
      _snack('Ticket ID missing — please restart booking.', isError: true);
      return;
    }

    setState(() => _launching = true);

    try {
      final url = await PaymentService.createCheckoutSession(
          ticketId: ticketId, token: token);

      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        _snack('Could not open payment page.', isError: true);
        setState(() => _launching = false);
        return;
      }

      setState(() { _launching = false; _status = 'waiting'; _polling = true; });
      _startPolling(ticketId, token);
    } on AuthException catch (e) {
      _snack(e.message, isError: true);
      setState(() => _launching = false);
    } catch (_) {
      _snack('Could not create payment session. Please try again.', isError: true);
      setState(() => _launching = false);
    }
  }

  void _startPolling(int ticketId, String token) {
    int tries = 0;
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      tries++;
      try {
        final status = await PaymentService.getPaymentStatus(
            ticketId: ticketId, token: token);
        if (!mounted) { timer.cancel(); return; }
        if (status.toLowerCase() == 'paid') {
          timer.cancel();
          await _onPaymentConfirmed();
        } else if (tries >= 40) {
          // ~2 min timeout
          timer.cancel();
          if (mounted) setState(() { _polling = false; _status = 'timeout'; });
        }
      } catch (_) {
        // Keep polling on transient errors
      }
    });
  }

  Future<void> _onPaymentConfirmed() async {
    final booking = context.read<BookingProvider>();
    final token   = context.read<UserProvider>().token;
    final bookId  = booking.bookId;

    try {
      if (bookId != null) {
        await BookingService.confirmBooking(bookId: bookId, token: token);
      }
    } catch (_) {
      // Confirm failure is non-fatal — payment already went through
    }

    if (!mounted) return;
    setState(() { _polling = false; _status = 'paid'; _confirmed = true; });
    booking.resetBooking();
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 28),
          const SizedBox(width: 8),
          Text(l10n.paymentSuccessTitle),
        ]),
        content: Text(l10n.paymentSuccessMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.popUntil(context, (r) => r.isFirst);
            },
            child: Text(l10n.paymentSuccessGoHome),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.popUntil(context, (r) => r.isFirst);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyan),
            child: Text(l10n.paymentSuccessViewTickets, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
    final l10n = AppLocalizations.of(context)!;
    final booking    = context.watch<BookingProvider>();
    final user       = context.watch<UserProvider>();
    final passengers = _search?.totalPassengers ?? booking.passengerCount;
    final schedule   = _schedule ?? booking.selectedSchedule;
    final price      = schedule?.totalPrice ?? 0.0;
    final convertedPrice = user.convertPrice(price);
    final baseFare   = convertedPrice * passengers;
    final taxes      = baseFare * 0.15;
    final servicesFee = user.convertPrice(_servicesTotal(booking));
    final total      = baseFare + taxes + servicesFee;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text(l10n.paymentTitle), elevation: 0),
        body: Column(children: [
          Expanded(child: SingleChildScrollView(child: Column(children: [
            _buildSummaryCard(schedule, booking, passengers),
            const SizedBox(height: 8),
            _buildPriceCard(passengers, convertedPrice, baseFare, taxes, servicesFee, total, booking, user.currency),
            const SizedBox(height: 8),
            _buildStripeInfo(),
            const SizedBox(height: 80),
          ]))),
          _buildBottomBar(total),
        ]),
      ),
    );
  }

  double _servicesTotal(BookingProvider booking) {
    double t = 0;
    for (final entry in booking.selectedServices.entries) {
      final svc = booking.availableServices
          .where((s) => s.serviceId == entry.key)
          .firstOrNull;
      if (svc != null) t += svc.fees * entry.value;
    }
    return t;
  }

  Widget _buildSummaryCard(
      FlightScheduleModel? s, BookingProvider booking, int passengers) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cyanLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cyan.withValues(alpha: 0.3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Booking Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        _summaryRow(Icons.flight_takeoff,
            '${s?.departureCity ?? '--'} → ${s?.arrivalCity ?? '--'}',
            '${s?.departureDisplay ?? '--'} → ${s?.arrivalDisplay ?? '--'}'),
        const SizedBox(height: 10),
        _summaryRow(Icons.calendar_today, 'Date',
            s != null ? _fmtDate(s.flightDate) : '--'),
        const SizedBox(height: 10),
        _summaryRow(Icons.people, 'Passengers', '$passengers pax'),
        const SizedBox(height: 10),
        _summaryRow(Icons.star_border,
            'Class', booking.search?.travelClass ?? 'Economy'),
        if (booking.selectedServices.isNotEmpty) ...[
          const SizedBox(height: 10),
          _summaryRow(Icons.room_service, 'Services',
              '${booking.selectedServices.values.fold(0, (a, b) => a + b)} item(s) added'),
        ],
      ]),
    );
  }

  Widget _summaryRow(IconData icon, String label, String value) =>
      Row(children: [
        Icon(icon, color: AppColors.cyan, size: 18),
        const SizedBox(width: 10),
        Text('$label: ',
            style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        Expanded(child: Text(value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            textAlign: TextAlign.right)),
      ]);

  Widget _buildPriceCard(int passengers, double price, double baseFare,
      double taxes, double servicesFee, double total, BookingProvider booking, String currency) {
    // ── Dynamic: card background and border adapt to theme ──
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
        const Text('Price Breakdown',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 14),
        _priceRow('Base Fare ($passengers pax × $currency ${price.toStringAsFixed(2)})',
            '$currency ${baseFare.toStringAsFixed(2)}'),
        const SizedBox(height: 8),
        _priceRow('Taxes & Fees (15%)', '$currency ${taxes.toStringAsFixed(2)}'),
        if (servicesFee > 0) ...[
          const SizedBox(height: 8),
          _priceRow('Optional Services', '$currency ${servicesFee.toStringAsFixed(2)}'),
        ],
        const Divider(height: 24),
        _priceRow('Grand Total', '$currency ${total.toStringAsFixed(2)}',
            isBold: true, isLarge: true),
      ]),
    );
  }

  Widget _priceRow(String label, String amount,
      {bool isBold = false, bool isLarge = false}) {
    // ── Dynamic: bold text color adapts to theme ──
    final colorScheme = Theme.of(context).colorScheme;

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(child: Text(label,
          style: TextStyle(
              fontSize: isLarge ? 16 : 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold
                  ? colorScheme.onSurface          // was: Colors.black
                  : AppColors.textSecondary))),
      Text(amount, style: TextStyle(
          fontSize: isLarge ? 18 : 13,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
          color: isBold ? AppColors.cyan : AppColors.textSecondary)),
    ]);
  }

  Widget _buildStripeInfo() {
    // ── Dynamic: card background and border adapt to theme ──
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
        const Text('Secure Payment',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF635BFF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text('stripe',
                style: TextStyle(
                    color: Color(0xFF635BFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Text(
              'You will be redirected to Stripe\'s secure checkout page to complete your payment.',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary))),
        ]),
        if (_status == 'waiting') ...[
          const SizedBox(height: 14),
          const Row(children: [
            SizedBox(width: 18, height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.cyan)),
            SizedBox(width: 10),
            Expanded(child: Text('Waiting for payment confirmation…',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary))),
          ]),
        ],
        if (_status == 'timeout') ...[
          const SizedBox(height: 14),
          const Text('Payment confirmation timed out. If you completed payment, '
              'please check your tickets.',
              style: TextStyle(fontSize: 12, color: AppColors.error)),
        ],
      ]),
    );
  }

  Widget _buildBottomBar(double total) {
    // ── Dynamic: bottom bar background and shadow adapt to theme ──
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,                              // was: Colors.white
        boxShadow: [BoxShadow(
            color: colorScheme.shadow.withOpacity(0.12),        // was: Colors.grey.shade200
            blurRadius: 8,
            offset: const Offset(0, -2))],
      ),
      child: SafeArea(child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (_launching || _polling || _confirmed) ? null : _startPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF635BFF),
            foregroundColor: Colors.white,
            disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12), // was: Colors.grey.shade300
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: _launching
              ? const SizedBox(height: 20, width: 20,
                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
              : _polling
                  ? const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(width: 18, height: 18,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                      SizedBox(width: 10),
                      Text('Awaiting Payment…',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ])
                  : Text('Pay JOD ${total.toStringAsFixed(2)} with Stripe',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ),
      )),
    );
  }

  String _fmtDate(DateTime d) {
    const m = ['','Jan','Feb','Mar','Apr','May','Jun',
                'Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${m[d.month]} ${d.day}, ${d.year}';
  }
}