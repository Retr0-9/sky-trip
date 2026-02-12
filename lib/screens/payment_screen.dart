import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'card'; // card, paypal, apple_pay

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
          const Text(
            'Booking Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Flight Route
          Row(
            children: [
              const Icon(Icons.flight_takeoff, color: Colors.cyan, size: 20),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AMM → DXB',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Royal Jordanian • Flight RJ 501',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          
          // Date & Time
          _buildSummaryRow(Icons.calendar_today, 'Date', 'Mar 15, 2025'),
          const SizedBox(height: 8),
          _buildSummaryRow(Icons.access_time, 'Time', '10:00 AM - 12:30 PM'),
          const SizedBox(height: 8),
          
          // Passengers
          _buildSummaryRow(Icons.person, 'Passengers', '2 Adults, 1 Child'),
          const SizedBox(height: 8),
          
          // Class
          _buildSummaryRow(Icons.airline_seat_recline_normal, 'Class', 'Economy'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.cyan, size: 18),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.right,
          ),
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
          const Text(
            'Price Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          // Base Fare
          _buildPriceRow('Flight Fare (3 passengers)', 'JOD 450.00'),
          const SizedBox(height: 8),
          
          // Taxes
          _buildPriceRow('Taxes & Fees', 'JOD 90.00'),
          const SizedBox(height: 8),
          
          // Services
          const Text(
            'Optional Services:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          _buildPriceRow('  In-Flight Meals (2x)', 'JOD 30.00', isOptional: true),
          const SizedBox(height: 8),
          _buildPriceRow('  Seat Selection', 'JOD 10.00', isOptional: true),
          const SizedBox(height: 8),
          _buildPriceRow('  Special Assistance', 'JOD 25.00', isOptional: true),
          
          const Divider(height: 24),
          
          // Total
          _buildPriceRow(
            'Total Amount',
            'JOD 605.00',
            isBold: true,
            isLarge: true,
          ),
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
            child: const Text(
              'Pay JOD 605.00',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
