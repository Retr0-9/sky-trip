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

class _PaymentScreenState extends State<PaymentScreen>
    with WidgetsBindingObserver {
  FlightScheduleModel? _schedule;
  BookingSearchModel?  _search;
  bool _loaded = false;

  bool _launching  = false;
  bool _polling    = false;
  bool _confirmed  = false;
  String _status   = '';   // 'waiting' | 'paid' | 'failed'
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

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
    WidgetsBinding.instance.removeObserver(this);
    _pollTimer?.cancel();
    super.dispose();
  }

  // Fires when user closes the Chrome Custom Tab and returns to the app.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_confirmed) {
      _checkPaymentNow();
    }
  }

  bool _checking = false;

  Future<void> _checkPaymentNow() async {
    if (_checking || _confirmed) return;
    final booking  = context.read<BookingProvider>();
    final ticketId = booking.ticketId;
    if (ticketId == null) {
      _snack('Session expired — please restart booking.', isError: true);
      return;
    }
    setState(() => _checking = true);
    final token = context.read<UserProvider>().token;
    try {
      final status = await PaymentService.getPaymentStatus(
          ticketId: ticketId, token: token);
      if (!mounted) return;
      if (status.toLowerCase() == 'paid') {
        _pollTimer?.cancel();
        await _onPaymentConfirmed();
      } else {
        // Show what the server actually returned so we can diagnose
        _snack('Status: $status — payment not confirmed yet.', isError: true);
      }
    } on AuthException catch (e) {
      if (mounted) _snack(e.message, isError: true);
    } catch (e) {
      if (mounted) _snack('Check failed: $e', isError: true);
    } finally {
      if (mounted) setState(() => _checking = false);
    }
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
      if (!await launchUrl(uri, mode: LaunchMode.inAppBrowserView)) {
        _snack('Could not open payment page.', isError: true);
        setState(() => _launching = false);
        return;
      }

      // Polling starts immediately — detects payment even while Stripe tab is open.
      // When user closes the tab (back button), the success dialog will appear.
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
        } else if (tries >= 200) {
          // ~10 min timeout
          timer.cancel();
          if (mounted) setState(() { _polling = false; _status = 'timeout'; });
        }
      } catch (_) {
        // Keep polling on transient errors
      }
    });
  }

  Future<void> _onPaymentConfirmed() async {
    final booking  = context.read<BookingProvider>();
    final token    = context.read<UserProvider>().token;
    final bookId   = booking.bookId;
    final ticketId = booking.ticketId;

    try {
      if (bookId != null) {
        await BookingService.confirmBooking(bookId: bookId, token: token);
      }
    } catch (_) {
      // Non-fatal — payment already went through
    }

    if (!mounted) return;
    setState(() { _polling = false; _status = 'paid'; _confirmed = true; });
    // Don't reset booking here — PaymentSuccessScreen needs ticketId
    Navigator.pushReplacementNamed(
      context,
      '/payment-success',
      arguments: {'ticketId': ticketId},
    );
    booking.resetBooking();
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
    final price      = schedule?.basePrice ?? 0.0;
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.cyan.withValues(alpha: 0.25)),
            ),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                SizedBox(width: 14, height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.cyan)),
                SizedBox(width: 8),
                Text('Waiting for payment…',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                        color: AppColors.cyan)),
              ]),
              SizedBox(height: 8),
              Text('1. Complete payment on the Stripe page.',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              SizedBox(height: 4),
              Text('2. Tap  ✕  (top-left) to close the browser and return here.',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              SizedBox(height: 4),
              Text('3. Your booking will be confirmed automatically.',
                  style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ]),
          ),
        ],
        if (_status == 'waiting' || _status == 'timeout') ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _checking ? null : _checkPaymentNow,
              icon: _checking
                  ? const SizedBox(width: 14, height: 14,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.cyan))
                  : const Icon(Icons.refresh, size: 16, color: AppColors.cyan),
              label: Text(
                _checking ? 'Checking…' : 'I already paid — check now',
                style: const TextStyle(color: AppColors.cyan, fontSize: 13),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.cyan),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
        if (_status == 'timeout') ...[
          const SizedBox(height: 8),
          const Text('Confirmation timed out. Tap the button above to recheck.',
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