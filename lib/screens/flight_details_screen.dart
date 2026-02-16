import 'package:flutter/material.dart';
import '../widgets/info_row.dart';
import '../widgets/primary_button.dart';

class FlightDetailsScreen extends StatelessWidget {
  const FlightDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Receive flight data from previous screen (via arguments)
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Details'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Flight Summary Card
                  _buildFlightSummary(),
                  
                  const SizedBox(height: 8),
                  
                  // Route Timeline
                  _buildRouteTimeline(),
                  
                  const SizedBox(height: 8),
                  
                  // Fare Breakdown
                  _buildFareBreakdown(),
                  
                  const SizedBox(height: 8),
                  
                  // Baggage Allowance
                  _buildBaggageInfo(),
                  
                  const SizedBox(height: 8),
                  
                  // Policies
                  _buildPolicies(),
                  
                  const SizedBox(height: 80), // Space for bottom button
                ],
              ),
            ),
          ),
          
          // Bottom Confirm Button
          _buildBottomButton(context),
        ],
      ),
    );
  }

  // ==================== SECTION BUILDERS ====================

  Widget _buildFlightSummary() {
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
          // Airline Logo and Name
          Row(
            children: [
              // TODO: Replace with airline logo
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.flight, color: Colors.cyan),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Royal Jordanian',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Flight RJ 501 • Economy',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Route Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Departure
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '10:00 AM',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'AMM',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              
              // Duration
              Column(
                children: [
                  const Text(
                    '2h 30m',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(Icons.arrow_forward, color: Colors.cyan.shade700),
                  const SizedBox(height: 4),
                  const Text(
                    'Direct',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              
              // Arrival
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '12:30 PM',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'DXB',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteTimeline() {
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
          const Text(
            'Route Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Departure Details
          _buildTimelineItem(
            icon: Icons.flight_takeoff,
            time: '10:00 AM',
            location: 'Queen Alia International Airport (AMM)',
            subtitle: 'Amman, Jordan',
            isFirst: true,
          ),
          
          // Flight Duration Line
          Padding(
            padding: const EdgeInsets.only(left: 19),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.cyan,
                ),
                const Text(
                  '  Flight duration: 2h 30m',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  width: 2,
                  height: 40,
                  color: Colors.cyan,
                ),
              ],
            ),
          ),
          
          // Arrival Details
          _buildTimelineItem(
            icon: Icons.flight_land,
            time: '12:30 PM',
            location: 'Dubai International Airport (DXB)',
            subtitle: 'Dubai, UAE',
            isFirst: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required IconData icon,
    required String time,
    required String location,
    required String subtitle,
    required bool isFirst,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.cyan.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.cyan, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                location,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFareBreakdown() {
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
          const Text(
            'Fare Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // TODO: Replace with actual fare calculation
          _buildFareRow('Base Fare (1 Adult)', 'JOD 120.00'),
          const SizedBox(height: 8),
          _buildFareRow('Taxes & Fees', 'JOD 30.00'),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          _buildFareRow(
            'Total',
            'JOD 150.00',
            isBold: true,
            isLarge: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFareRow(String label, String amount, {bool isBold = false, bool isLarge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isLarge ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Colors.black : Colors.grey.shade700,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isLarge ? 18 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Colors.cyan : Colors.grey.shade700,
          ),
        ),
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
          const Text(
            'Baggage Allowance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildInfoRow(
            icon: Icons.work_outline,
            label: 'Carry-on',
            value: '1 bag (7 kg)',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.luggage,
            label: 'Checked Baggage',
            value: '1 bag (23 kg)',
          ),
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
          const Text(
            'Policies',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
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

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return InfoRow(icon: icon, label: label, value: value);
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: PrimaryButton(
          label: 'Confirm & Continue',
          icon: Icons.arrow_forward,
          onPressed: () {
            Navigator.pushNamed(context, '/passengers-form');
          },
        ),
      ),
    );
  }
}
