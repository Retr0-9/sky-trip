import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/payment_service.dart';
import '../services/booking_service.dart';
import '../services/auth_service.dart';
import '../providers/user_provider.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  int? _ticketId;
  bool _loaded = false;

  // Polling state
  String _subtitle   = 'Your booking is being confirmed…';
  String _payStatus  = 'Checking…';
  String _bookId     = '—';
  String _bookRef    = '—';
  bool   _confirmed  = false;
  bool   _timedOut   = false;
  bool   _retrying   = false;
  String? _error;

  Timer? _pollTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _ticketId = args?['ticketId'] as int?;
    _loaded = true;
    if (_ticketId != null) _startPolling(_ticketId!);
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  // ── Ports the pollStatus() JS loop exactly ─────────────────────────────────
  void _startPolling(int ticketId) {
    setState(() {
      _subtitle  = 'Your booking is being confirmed…';
      _payStatus = 'Checking…';
      _error     = null;
      _timedOut  = false;
      _confirmed = false;
    });

    final token   = context.read<UserProvider>().token;
    final maxMs   = 25000; // 25 s — same as web
    final start   = DateTime.now().millisecondsSinceEpoch;

    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(milliseconds: 1500), (t) async {
      if (!mounted) { t.cancel(); return; }

      if (DateTime.now().millisecondsSinceEpoch - start > maxMs) {
        t.cancel();
        if (mounted) setState(() {
          _timedOut = true;
          _subtitle = 'Payment received. Confirmation may take a bit longer.';
        });
        return;
      }

      try {
        final status = await PaymentService.getPaymentStatus(
            ticketId: ticketId, token: token);

        if (!mounted) { t.cancel(); return; }

        // Attempt to get richer data from the detail endpoint
        try {
          final detail = await BookingService.fetchTicketDetail(
              ticketId: ticketId, token: token);
          if (mounted) setState(() {
            _bookId    = detail.bookId.toString();
            _payStatus = detail.paymentStatus ?? status;
            _bookRef   = detail.bookingReference ?? '—';
          });
        } catch (_) {
          if (mounted) setState(() => _payStatus = status);
        }

        if (status.toLowerCase() == 'paid') {
          t.cancel();
          _onConfirmed();
        }
      } on AuthException {
        t.cancel();
        if (mounted) {
          setState(() => _error = 'Session expired. Please log in again.');
          Future.delayed(const Duration(milliseconds: 700), () {
            if (mounted) Navigator.pushNamedAndRemoveUntil(context, '/auth', (_) => false);
          });
        }
      } catch (e) {
        if (mounted) setState(() => _error = 'Could not verify yet: $e');
      }
    });
  }

  void _onConfirmed() {
    if (!mounted) return;
    setState(() {
      _confirmed = true;
      _subtitle  = 'Booking confirmed ✓ Redirecting to your tickets…';
      _error     = null;
    });
    context.read<BookingProvider>().resetBooking();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    });
  }

  void _retry() {
    if (_ticketId == null) return;
    setState(() => _retrying = true);
    _startPolling(_ticketId!);
    setState(() => _retrying = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs    = theme.colorScheme;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [

                // ── Success icon ─────────────────────────────────────────
                Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withValues(alpha: 0.12),
                    border: Border.all(color: Colors.green.withValues(alpha: 0.4), width: 2),
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.green, size: 44),
                ),
                const SizedBox(height: 20),

                Text('Payment Successful',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(_subtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor)),
                const SizedBox(height: 24),

                // ── Booking details card ──────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: cs.outlineVariant),
                    boxShadow: AppShadows.card,
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    _detailRow('Ticket ID',   _ticketId?.toString() ?? '—'),
                    const Divider(height: 20),
                    _detailRow('Book ID',     _bookId),
                    const Divider(height: 20),
                    _detailRow('Payment',     _payStatus,
                        valueColor: _payStatus.toLowerCase() == 'paid'
                            ? Colors.green : theme.hintColor),
                    const Divider(height: 20),
                    _detailRow('Reference',   _bookRef),
                  ]),
                ),

                // ── Error ────────────────────────────────────────────────
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: AppColors.error)),
                ],

                const SizedBox(height: 28),

                // ── Buttons ───────────────────────────────────────────────
                if (_confirmed || _timedOut) ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, '/', (_) => false),
                      icon: const Icon(Icons.confirmation_number_outlined),
                      label: const Text('Go to My Tickets'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cyan,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
                if (_timedOut && !_confirmed) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _retrying ? null : _retry,
                      icon: _retrying
                          ? const SizedBox(width: 14, height: 14,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],

                // ── Polling indicator ─────────────────────────────────────
                if (!_confirmed && !_timedOut) ...[
                  const SizedBox(height: 16),
                  const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(width: 14, height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.cyan)),
                    SizedBox(width: 8),
                    Text('Confirming booking…',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ]),
                ],

              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? valueColor}) {
    final theme = Theme.of(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.hintColor)),
      Text(value,
          style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold, color: valueColor)),
    ]);
  }
}
