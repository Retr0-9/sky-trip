import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/service_model.dart';
import '../models/flight_schedule_model.dart';
import '../models/booking_search_model.dart';
import '../providers/booking_provider.dart';
import '../providers/user_provider.dart';
import '../services/extras_service.dart';
import '../services/auth_service.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  FlightScheduleModel? _schedule;
  BookingSearchModel?  _search;
  bool _loaded = false;

  List<ServiceModel> _services = [];
  final Map<int, int> _quantities = {};
  bool _loadingServices = true;
  String? _loadError;
  bool _confirming = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _schedule = args?['schedule'] as FlightScheduleModel?;
    _search   = args?['search']   as BookingSearchModel?;
    _loaded = true;
    _fetchServices();
  }

  Future<void> _fetchServices() async {
    setState(() { _loadingServices = true; _loadError = null; });
    try {
      final token = context.read<UserProvider>().token;
      final services = await ExtrasService.getAllServices(token);
      if (!mounted) return;
      setState(() { _services = services; _loadingServices = false; });
      context.read<BookingProvider>().setAvailableServices(services);
    } on AuthException catch (e) {
      if (mounted) setState(() { _loadError = e.message; _loadingServices = false; });
    } catch (_) {
      if (mounted) setState(() { _loadError = 'Could not load services.'; _loadingServices = false; });
    }
  }

  Future<void> _confirm() async {
    setState(() => _confirming = true);
    final booking = context.read<BookingProvider>();
    final token   = context.read<UserProvider>().token;
    final ticketId = booking.ticketId;

    if (ticketId == null) {
      _snack('Ticket ID missing — please restart booking.', isError: true);
      setState(() => _confirming = false);
      return;
    }

    try {
      for (final entry in _quantities.entries) {
        if (entry.value > 0) {
          await ExtrasService.addService(
            ticketId: ticketId,
            serviceId: entry.key,
            quantity: entry.value,
            token: token,
          );
          booking.setServiceQuantity(entry.key, entry.value);
        }
      }
      if (!mounted) return;
      Navigator.pushNamed(context, '/payment',
          arguments: {'schedule': _schedule, 'search': _search});
    } on AuthException catch (e) {
      _snack(e.message, isError: true);
    } catch (_) {
      _snack('Could not save services. Please try again.', isError: true);
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

  int _qty(int serviceId) => _quantities[serviceId] ?? 0;

  void _setQty(int serviceId, int qty) =>
      setState(() => _quantities[serviceId] = qty.clamp(0, 10));

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Optional Services'), elevation: 0),
        body: Column(children: [
          _buildHeader(),
          Expanded(child: _buildBody()),
          _buildBottomBar(),
        ]),
      ),
    );
  }

  Widget _buildHeader() => Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
    color: AppColors.cyanLight,
    child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Enhance Your Journey',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      SizedBox(height: 2),
      Text('Add extra services to make your trip more comfortable',
          style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
    ]),
  );

  Widget _buildBody() {
    if (_loadingServices) {
      return const Center(child: CircularProgressIndicator(color: AppColors.cyan));
    }
    if (_loadError != null) {
      return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(_loadError!, style: const TextStyle(color: AppColors.error)),
        const SizedBox(height: 12),
        TextButton(onPressed: _fetchServices, child: const Text('Retry')),
      ]));
    }
    if (_services.isEmpty) {
      return const Center(child: Text('No services available.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _services.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _ServiceCard(
        service: _services[i],
        quantity: _qty(_services[i].serviceId),
        onIncrement: () => _setQty(_services[i].serviceId, _qty(_services[i].serviceId) + 1),
        onDecrement: () => _setQty(_services[i].serviceId, _qty(_services[i].serviceId) - 1),
      ),
    );
  }

  Widget _buildBottomBar() {
    final hasSelections = _quantities.values.any((q) => q > 0);
    final total = _services.fold<double>(0.0, (sum, s) {
      final q = _qty(s.serviceId);
      return sum + (s.fees * q);
    });

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
            color: Colors.grey.shade200, blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
        if (hasSelections) ...[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Services total:',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            Text('JOD ${total.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.cyan)),
          ]),
          const SizedBox(height: 10),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _confirming ? null : _confirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cyan,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _confirming
                ? const SizedBox(height: 20, width: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                : const Text('Continue to Payment',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ])),
    );
  }
}

// ── Service card ──────────────────────────────────────────────────────────────

class _ServiceCard extends StatelessWidget {
  final ServiceModel service;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _ServiceCard({
    required this.service,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final isFree = service.fees == 0;
    final isSelected = quantity > 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.cyan : Colors.grey.shade200,
          width: isSelected ? 1.5 : 1,
        ),
        boxShadow: AppShadows.card,
      ),
      child: Row(children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.cyan.withValues(alpha: 0.12) : AppColors.cyanLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(_serviceIcon(service.name),
              color: isSelected ? AppColors.cyan : AppColors.textSecondary, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(service.name,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 3),
          Text(
            isFree ? 'Free' : 'JOD ${service.fees.toStringAsFixed(2)} per person',
            style: TextStyle(
                fontSize: 12,
                color: isFree ? Colors.green.shade600 : AppColors.textSecondary,
                fontWeight: FontWeight.w500),
          ),
        ])),
        const SizedBox(width: 10),
        _buildCounter(),
      ]),
    );
  }

  Widget _buildCounter() => Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      InkWell(
        onTap: quantity > 0 ? onDecrement : null,
        borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(Icons.remove, size: 16,
              color: quantity > 0 ? AppColors.textPrimary : Colors.grey.shade300),
        ),
      ),
      Container(
        constraints: const BoxConstraints(minWidth: 32),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text('$quantity',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
      InkWell(
        onTap: onIncrement,
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.add, size: 16, color: AppColors.textPrimary),
        ),
      ),
    ]),
  );

  IconData _serviceIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('meal') || n.contains('food')) return Icons.restaurant;
    if (n.contains('seat')) return Icons.airline_seat_recline_normal;
    if (n.contains('wheelchair') || n.contains('wheel')) return Icons.accessible;
    if (n.contains('assist') || n.contains('special')) return Icons.support_agent;
    if (n.contains('baggage') || n.contains('bag') || n.contains('luggage')) return Icons.luggage;
    if (n.contains('lounge')) return Icons.weekend;
    if (n.contains('wifi') || n.contains('internet')) return Icons.wifi;
    if (n.contains('priority') || n.contains('fast')) return Icons.speed;
    return Icons.star_outline;
  }
}
