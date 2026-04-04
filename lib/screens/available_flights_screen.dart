import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/booking_search_model.dart';
import '../models/flight_schedule_model.dart';
import '../providers/booking_provider.dart';

class AvailableFlightsScreen extends StatefulWidget {
  const AvailableFlightsScreen({super.key});

  @override
  State<AvailableFlightsScreen> createState() => _AvailableFlightsScreenState();
}

class _AvailableFlightsScreenState extends State<AvailableFlightsScreen> {
  late BookingSearchModel _search;
  late List<FlightScheduleModel> _flights;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _search  = (args?['search']  as BookingSearchModel?) ?? _fallbackSearch();
    _flights = (args?['flights'] as List<FlightScheduleModel>?) ?? [];
    _loaded  = true;
  }

  BookingSearchModel _fallbackSearch() => BookingSearchModel(
    fromCode: '', fromCity: '', toCode: '', toCity: '',
    departureDate: DateTime.now(), tripType: 'one_way',
    adults: 1, youth: 0, children: 0, infants: 0, travelClass: 'Economy',
  );

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: const Text('Available Flights'), elevation: 0),
        body: Column(children: [
          _buildSummaryBar(),
          Expanded(child: _flights.isEmpty ? _buildEmpty() : _buildList()),
        ]),
      ),
    );
  }

  Widget _buildSummaryBar() {
    final d = _search.departureDate;
    final dateStr = '${d.day}/${d.month}/${d.year}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.cyanLight,
      child: Row(children: [
        Expanded(
          child: Row(children: [
            Text(_search.fromCity.isNotEmpty ? _search.fromCity : _search.fromCode,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.arrow_forward, size: 16),
            ),
            Text(_search.toCity.isNotEmpty ? _search.toCity : _search.toCode,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          ]),
        ),
        _chip(dateStr),
        const SizedBox(width: 8),
        _chip('${_search.totalPassengers} pax'),
      ]),
    );
  }

  Widget _chip(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(8)),
    child: Text(label, style: const TextStyle(fontSize: 12)),
  );

  Widget _buildEmpty() => Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.flight_takeoff, size: 64, color: Colors.grey.shade300),
      const SizedBox(height: 16),
      Text('No flights found for this route',
          style: TextStyle(color: Colors.grey.shade500, fontSize: 16)),
      const SizedBox(height: 8),
      Text('Try different dates or cities',
          style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
    ]),
  );

  Widget _buildList() => ListView.builder(
    padding: const EdgeInsets.all(16),
    itemCount: _flights.length,
    itemBuilder: (_, i) => _FlightScheduleCard(
      schedule: _flights[i],
      passengerCount: _search.totalPassengers,
      onTap: () {
        context.read<BookingProvider>().selectSchedule(_flights[i]);
        Navigator.pushNamed(context, '/flight-details',
            arguments: {'schedule': _flights[i], 'search': _search});
      },
    ),
  );
}

// ── Flight card for API schedule ─────────────────────────────────────────────

class _FlightScheduleCard extends StatelessWidget {
  final FlightScheduleModel schedule;
  final int passengerCount;
  final VoidCallback onTap;

  const _FlightScheduleCard({
    required this.schedule,
    required this.passengerCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = schedule.totalPrice * passengerCount;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: AppShadows.card,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Header row
          Row(children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.cyanLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.flight, color: AppColors.cyan, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${schedule.departureCity} → ${schedule.arrivalCity}',
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ]),
          const SizedBox(height: 16),

          // Times row
          Row(children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(schedule.departureDisplay,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(schedule.departureCity,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ]),
            ),
            Column(children: [
              Icon(Icons.flight_takeoff, color: AppColors.cyan, size: 20),
              const SizedBox(height: 4),
              Text(_flightDate(schedule.flightDate),
                  style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ]),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(schedule.arrivalDisplay,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(schedule.arrivalCity,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ]),
            ),
          ]),

          const Divider(height: 20),

          // Price row
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('JOD ${schedule.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.cyan)),
              Text('per person', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
            ]),
            if (passengerCount > 1)
              Text('Total: JOD ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500)),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textHint),
          ]),
        ]),
      ),
    );
  }

  String _flightDate(DateTime d) {
    const months = ['','Jan','Feb','Mar','Apr','May','Jun',
                    'Jul','Aug','Sep','Oct','Nov','Dec'];
    return '${months[d.month]} ${d.day}';
  }
}
