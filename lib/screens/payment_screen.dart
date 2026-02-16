import 'package:flutter/material.dart';
import '../models/flight_model.dart';
import '../models/booking_search_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  FlightModel? _flight;
  BookingSearchModel? _search;
  Map? _services;
  bool _argumentsLoaded = false;
  String _selectedPaymentMethod = 'card';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argumentsLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      _flight = args?['flight'] as FlightModel?;
      _search = args?['search'] as BookingSearchModel?;
      _services = args?['services'] as Map?;
      _argumentsLoaded = true;
    }
  }

  // Price calculations
  double get _flightPrice => _flight?.price ?? 150.0;
  String get _currency => _flight?.currency ?? 'JOD';
  int get _passengers => _search?.totalPassengers ?? 1;
  double get _baseFare => _flightPrice * _passengers;
  double get _taxes => _baseFare * 0.15;
  int get _mealCount => (_services?['meals'] as int?) ?? 0;
  bool get _hasSeat => (_services?['seatSelection'] as bool?) ?? false;
  bool get _hasSpecial => (_services?['specialAssistance'] as bool?) ?? false;
  double get _mealsTotal => _mealCount * 15.0;
  double get _seatTotal => _hasSeat ? 10.0 : 0.0;
  double get _specialTotal => _hasSpecial ? 25.0 : 0.0;
  double get _grandTotal => _baseFare + _taxes + _mealsTotal + _seatTotal + _specialTotal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Booking Summary
                  _buildBookingSummary(),
                  
                  const SizedBox(height: 8),
                  
                  // Price Breakdown
                  _buildPriceBreakdown(),
                  
                  const SizedBox(height: 8),
                  
                  // Payment Methods
                  _buildPaymentMethods(),
                  
                  const SizedBox(height: 80), // Space for bottom button
                ],
              ),
            ),
          ),
          
          // Bottom Pay Button
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
    final fromCode = _flight?.fromCode ?? 'AMM';
    final toCode = _flight?.toCode ?? 'DXB';
    final airline = _flight?.airline ?? 'Royal Jordanian';
    final flightNumber = _flight?.flightNumber ?? 'RJ 501';
    final travelClass = _flight?.travelClass ?? 'Economy';

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
          const Text('Booking Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.flight_takeoff, color: Colors.cyan, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('$fromCode → $toCode',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text('$airline • $flightNumber',
                        style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          _buildSummaryRow(Icons.calendar_today, 'Date',
              '${_search?.departureDate.day ?? '--'}/${_search?.departureDate.month ?? '--'}/${_search?.departureDate.year ?? '--'}'),
          const SizedBox(height: 8),
          _buildSummaryRow(Icons.access_time, 'Time',
              '${_flight?.departureTime ?? '--'} - ${_flight?.arrivalTime ?? '--'}'),
          const SizedBox(height: 8),
          _buildSummaryRow(Icons.person, 'Passengers',
              '$_passengers passenger${_passengers > 1 ? 's' : ''}'),
          const SizedBox(height: 8),
          _buildSummaryRow(Icons.airline_seat_recline_normal, 'Class', travelClass),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyan, size: 18),
        const SizedBox(width: 12),
        Text('$label: ',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.right),
        ),
      ],
    );
  }

  Widget _buildPriceBreakdown() {
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
          const Text('Price Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildPriceRow(
              'Flight Fare ($_passengers pax × $_currency ${_flightPrice.toStringAsFixed(0)})',
              '$_currency ${_baseFare.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildPriceRow('Taxes & Fees (15%)',
              '$_currency ${_taxes.toStringAsFixed(2)}'),
          if (_mealCount > 0 || _hasSeat || _hasSpecial) ...[
            const SizedBox(height: 8),
            const Text('Optional Services:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
          ],
          if (_mealCount > 0) ...[
            const SizedBox(height: 8),
            _buildPriceRow('  In-Flight Meals (${_mealCount}x × \$15)',
                '$_currency ${_mealsTotal.toStringAsFixed(2)}',
                isOptional: true),
          ],
          if (_hasSeat) ...[
            const SizedBox(height: 8),
            _buildPriceRow('  Seat Selection',
                '$_currency ${_seatTotal.toStringAsFixed(2)}',
                isOptional: true),
          ],
          if (_hasSpecial) ...[
            const SizedBox(height: 8),
            _buildPriceRow('  Special Assistance',
                '$_currency ${_specialTotal.toStringAsFixed(2)}',
                isOptional: true),
          ],
          const Divider(height: 24),
          _buildPriceRow('Total Amount',
              '$_currency ${_grandTotal.toStringAsFixed(2)}',
              isBold: true, isLarge: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String amount, {
    bool isBold = false,
    bool isLarge = false,
    bool isOptional = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isLarge ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isOptional ? Colors.grey.shade600 : Colors.black87,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isLarge ? 18 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: isBold ? Colors.cyan : Colors.grey.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
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
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Credit/Debit Card
          _buildPaymentOption(
            'card',
            Icons.credit_card,
            'Credit / Debit Card',
          ),
          const SizedBox(height: 12),
          
          // PayPal
          _buildPaymentOption(
            'paypal',
            Icons.payment,
            'PayPal',
          ),
          const SizedBox(height: 12),
          
          // Apple Pay
          _buildPaymentOption(
            'apple_pay',
            Icons.apple,
            'Apple Pay',
          ),
          
          // Card Details (if card selected)
          if (_selectedPaymentMethod == 'card') ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _buildCardDetailsForm(),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String value, IconData icon, String label) {
    final isSelected = _selectedPaymentMethod == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyan.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.cyan : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.cyan : Colors.grey.shade600,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.cyan.shade700 : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.cyan),
          ],
        ),
      ),
    );
  }

  Widget _buildCardDetailsForm() {
    // TODO: Replace with actual form fields in Phase 3
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Card Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        
        _buildTextField('Card Number', '1234 5678 9012 3456'),
        const SizedBox(height: 12),
        
        Row(
          children: [
            Expanded(child: _buildTextField('Expiry', 'MM/YY')),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField('CVV', '123')),
          ],
        ),
        const SizedBox(height: 12),
        
        _buildTextField('Cardholder Name', 'John Doe'),
      ],
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            hint,
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
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
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Process payment
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Payment Successful'),
                  content: const Text('Your booking has been confirmed!'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Go back to home
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: const Text('Go to Home'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Go to tickets
                        Navigator.popUntil(context, (route) => route.isFirst);
                        // TODO: Navigate to tickets tab
                      },
                      child: const Text('View Ticket'),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Pay $_currency ${_grandTotal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
