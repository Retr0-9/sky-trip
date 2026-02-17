import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'card';

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Payment'), elevation: 0),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildBookingSummary(booking),
                  const SizedBox(height: 8),
                  _buildPriceBreakdown(booking),
                  const SizedBox(height: 8),
                  _buildPaymentMethods(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          _buildBottomButton(booking),
        ],
      ),
    );
  }

  Widget _buildBookingSummary(BookingProvider booking) {
    final flight = booking.selectedFlight;
    final search = booking.search;
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
          Row(children: [
            const Icon(Icons.flight_takeoff, color: Colors.cyan, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${flight?.fromCode ?? '--'} → ${flight?.toCode ?? '--'}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text('${flight?.airline ?? '--'} • ${flight?.flightNumber ?? '--'}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ]),
          const Divider(height: 24),
          _summaryRow(Icons.calendar_today, 'Date',
              search != null ? '${search.departureDate.day}/${search.departureDate.month}/${search.departureDate.year}' : '--'),
          const SizedBox(height: 8),
          _summaryRow(Icons.access_time, 'Time',
              '${flight?.departureTime ?? '--'} - ${flight?.arrivalTime ?? '--'}'),
          const SizedBox(height: 8),
          _summaryRow(Icons.person, 'Passengers',
              '${booking.passengerCount} passenger${booking.passengerCount != 1 ? 's' : ''}'),
          const SizedBox(height: 8),
          _summaryRow(Icons.airline_seat_recline_normal, 'Class', flight?.travelClass ?? 'Economy'),
          if (booking.selectedSeat != null) ...[
            const SizedBox(height: 8),
            _summaryRow(Icons.event_seat, 'Seat', booking.selectedSeat!),
          ],
        ],
      ),
    );
  }

  Widget _summaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyan, size: 18),
        const SizedBox(width: 12),
        Text('$label: ', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)),
        Expanded(
          child: Text(value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              textAlign: TextAlign.right),
        ),
      ],
    );
  }

  Widget _buildPriceBreakdown(BookingProvider booking) {
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
          _priceRow(
              'Flight Fare (${booking.passengerCount} pax × ${booking.currency} ${booking.flightPrice.toStringAsFixed(0)})',
              '${booking.currency} ${booking.baseFare.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _priceRow('Taxes & Fees (15%)', '${booking.currency} ${booking.taxes.toStringAsFixed(2)}'),
          if (booking.mealCount > 0 || booking.seatSelectionSelected ||
              booking.specialAssistanceSelected || booking.wheelchairSelected) ...[
            const SizedBox(height: 12),
            Text('Optional Services:',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey.shade600)),
            const SizedBox(height: 8),
          ],
          if (booking.mealCount > 0) ...[
            _priceRow('  Meals (${booking.mealCount}× \$15)',
                '${booking.currency} ${booking.mealsTotal.toStringAsFixed(2)}', isOptional: true),
            const SizedBox(height: 6),
          ],
          if (booking.seatSelectionSelected) ...[
            _priceRow('  Seat Selection',
                '${booking.currency} ${booking.seatTotal.toStringAsFixed(2)}', isOptional: true),
            const SizedBox(height: 6),
          ],
          if (booking.specialAssistanceSelected) ...[
            _priceRow('  Special Assistance',
                '${booking.currency} ${booking.specialTotal.toStringAsFixed(2)}', isOptional: true),
            const SizedBox(height: 6),
          ],
          if (booking.wheelchairSelected) ...[
            _priceRow('  Wheelchair Assistance', 'Free', isOptional: true),
            const SizedBox(height: 6),
          ],
          const Divider(height: 24),
          _priceRow('Total Amount',
              '${booking.currency} ${booking.grandTotal.toStringAsFixed(2)}',
              isBold: true, isLarge: true),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String amount,
      {bool isBold = false, bool isLarge = false, bool isOptional = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(label,
              style: TextStyle(
                fontSize: isLarge ? 16 : 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isOptional ? Colors.grey.shade600 : Colors.black87,
              )),
        ),
        Text(amount,
            style: TextStyle(
              fontSize: isLarge ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: isBold ? Colors.cyan : Colors.grey.shade700,
            )),
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
          const Text('Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _paymentOption('card', Icons.credit_card, 'Credit / Debit Card'),
          const SizedBox(height: 12),
          _paymentOption('paypal', Icons.payment, 'PayPal'),
          const SizedBox(height: 12),
          _paymentOption('apple_pay', Icons.apple, 'Apple Pay'),
          if (_selectedPaymentMethod == 'card') ...[
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            _buildCardForm(),
          ],
        ],
      ),
    );
  }

  Widget _paymentOption(String value, IconData icon, String label) {
    final isSelected = _selectedPaymentMethod == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedPaymentMethod = value),
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
            Icon(icon, color: isSelected ? Colors.cyan : Colors.grey.shade600),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.cyan.shade700 : Colors.black87,
                  )),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: Colors.cyan),
          ],
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Card Details',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _cardField('Card Number', '1234 5678 9012 3456'),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _cardField('Expiry', 'MM/YY')),
          const SizedBox(width: 12),
          Expanded(child: _cardField('CVV', '•••')),
        ]),
        const SizedBox(height: 12),
        _cardField('Cardholder Name', 'John Doe'),
      ],
    );
  }

  Widget _cardField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(hint, style: TextStyle(color: Colors.grey.shade500)),
        ),
      ],
    );
  }

  Widget _buildBottomButton(BookingProvider booking) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _confirmPayment(booking),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Pay ${booking.currency} ${booking.grandTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  void _confirmPayment(BookingProvider booking) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('Booking Confirmed!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${booking.selectedFlight?.fromCode ?? ''} → ${booking.selectedFlight?.toCode ?? ''}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Total paid: ${booking.currency} ${booking.grandTotal.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              booking.resetBooking();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Home'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              booking.resetBooking();
              Navigator.popUntil(context, (route) => route.isFirst);
              // TODO: Switch to Tickets tab in Phase 7
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            child: const Text('View Ticket', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
