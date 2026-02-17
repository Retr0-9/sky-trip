import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/info_row.dart';
import '../widgets/primary_button.dart';
import '../models/flight_model.dart';
import '../models/booking_search_model.dart';

class FlightDetailsScreen extends StatelessWidget {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Receive flight + search data from AvailableFlightsScreen
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final FlightModel? flight = args?['flight'] as FlightModel?;
    final BookingSearchModel? search = args?['search'] as BookingSearchModel?;

    // Fallback dummy data if no args
    final airline = flight?.airline ?? 'Royal Jordanian';
    final flightNumber = flight?.flightNumber ?? 'RJ 501';
    final fromCode = flight?.fromCode ?? 'AMM';
    final toCode = flight?.toCode ?? 'DXB';
    final fromCity = flight?.fromCity ?? 'Amman';
    final toCity = flight?.toCity ?? 'Dubai';
    final departureTime = flight?.departureTime ?? '10:00 AM';
    final arrivalTime = flight?.arrivalTime ?? '12:30 PM';
    final duration = flight?.duration ?? '2h 30m';
    final stops = flight?.stops ?? 'Direct';
    final price = flight?.price ?? 150.0;
    final currency = flight?.currency ?? 'JOD';
    final travelClass = flight?.travelClass ?? 'Economy';
    final passengers = search?.totalPassengers ?? 1;
    final baseFare = price * passengers;
    final taxes = baseFare * 0.15;
    final total = baseFare + taxes;

    return GradientBackground(child: Scaffold(backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Flight Details'), elevation: 0),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildFlightSummary(
                    airline, flightNumber, fromCode, toCode,
                    departureTime, arrivalTime, duration, stops, travelClass,
                  ),
                  const SizedBox(height: 8),
                  _buildRouteTimeline(
                    fromCode, fromCity, toCode, toCity,
                    departureTime, arrivalTime, duration,
                  ),
                  const SizedBox(height: 8),
                  _buildFareBreakdown(
                    passengers, price, baseFare, taxes, total, currency,
                  ),
                  const SizedBox(height: 8),
                  _buildBaggageInfo(),
                  const SizedBox(height: 8),
                  _buildPolicies(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          _buildBottomButton(context, flight, search),
        ],
      ),
    )
    );
  }

  Widget _buildFlightSummary(
    String airline, String flightNumber, String fromCode, String toCode,
    String departureTime, String arrivalTime, String duration,
    String stops, String travelClass,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.cyan.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.flight, color: Colors.cyan),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(airline,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('$flightNumber • $travelClass',
                        style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(departureTime,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(fromCode, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ]),
              Column(children: [
                Text(duration, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 4),
                Icon(Icons.arrow_forward, color: Colors.cyan.shade700),
                const SizedBox(height: 4),
                Text(stops,
                    style: TextStyle(
                      fontSize: 10,
                      color: stops == 'Direct' ? Colors.green : Colors.orange,
                    )),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(arrivalTime,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(toCode, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteTimeline(
    String fromCode, String fromCity, String toCode, String toCity,
    String departureTime, String arrivalTime, String duration,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Route Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTimelineItem(Icons.flight_takeoff, departureTime,
              '$fromCity ($fromCode) Airport'),
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 2, height: 30, color: Colors.cyan),
              Text('  Duration: $duration',
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Container(width: 2, height: 30, color: Colors.cyan),
            ]),
          ),
          _buildTimelineItem(Icons.flight_land, arrivalTime,
              '$toCity ($toCode) Airport'),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(IconData icon, String time, String location) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: Colors.cyan.shade100, shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.cyan, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(time,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(location, style: const TextStyle(fontSize: 13)),
          ]),
        ),
      ],
    );
  }

  Widget _buildFareBreakdown(
    int passengers, double price, double baseFare,
    double taxes, double total, String currency,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Fare Breakdown',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _fareRow('Base Fare ($passengers pax × $currency ${price.toStringAsFixed(0)})',
              '$currency ${baseFare.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _fareRow('Taxes & Fees (15%)',
              '$currency ${taxes.toStringAsFixed(2)}'),
          const Divider(height: 24),
          _fareRow('Total', '$currency ${total.toStringAsFixed(2)}',
              isBold: true, isLarge: true),
        ],
      ),
    );
  }

  Widget _fareRow(String label, String amount,
      {bool isBold = false, bool isLarge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontSize: isLarge ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.black : Colors.grey.shade700,
            )),
        Text(amount,
            style: TextStyle(
              fontSize: isLarge ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isBold ? Colors.cyan : Colors.grey.shade700,
            )),
      ],
    );
  }

  Widget _buildBaggageInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Baggage Allowance',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          InfoRow(icon: Icons.work_outline, label: 'Carry-on', value: '1 bag (7 kg)'),
          const SizedBox(height: 12),
          InfoRow(icon: Icons.luggage, label: 'Checked Baggage', value: '1 bag (23 kg)'),
        ],
      ),
    );
  }

  Widget _buildPolicies() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Policies',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          InfoRow(
            icon: Icons.cancel_outlined,
            label: 'Cancellation',
            value: 'Refundable with fee',
          ),
          const SizedBox(height: 12),
          InfoRow(
            icon: Icons.swap_horiz,
            label: 'Date Change',
            value: 'Allowed with fee',
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton(
    BuildContext context,
    FlightModel? flight,
    BookingSearchModel? search,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, -2),
        )],
      ),
      child: SafeArea(
        child: PrimaryButton(
          label: 'Confirm & Continue',
          icon: Icons.arrow_forward,
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/passengers-form',
              arguments: {'flight': flight, 'search': search},
            );
          },
        ),
      ),
    );
  }
}
