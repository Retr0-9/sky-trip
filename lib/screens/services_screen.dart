import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  // TODO: Track selected services (will be managed in state in Phase 4)
  int _mealCount = 0;
  bool _wheelchairSelected = false;
  bool _specialAssistanceSelected = false;
  bool _seatSelectionSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Optional Services'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Optional Services',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Enhance your travel experience',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // In-Flight Meal
                _buildServiceCard(
                  icon: Icons.restaurant,
                  title: 'In-Flight Meal',
                  description: 'Choose from our selection of meals',
                  price: '\$15',
                  hasCounter: true,
                  count: _mealCount,
                  onIncrement: () {
                    setState(() {
                      _mealCount++;
                    });
                  },
                  onDecrement: () {
                    if (_mealCount > 0) {
                      setState(() {
                        _mealCount--;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                
                // Seat Selection
                _buildServiceCard(
                  icon: Icons.airline_seat_recline_normal,
                  title: 'Seat Selection',
                  description: 'Choose your preferred seat',
                  price: '\$10',
                  hasToggle: true,
                  isSelected: _seatSelectionSelected,
                  onToggle: () {
                    setState(() {
                      _seatSelectionSelected = !_seatSelectionSelected;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Wheelchair Assistance
                _buildServiceCard(
                  icon: Icons.accessible,
                  title: 'Wheelchair Assistance',
                  description: 'Airport wheelchair service',
                  price: 'Free',
                  hasToggle: true,
                  isSelected: _wheelchairSelected,
                  onToggle: () {
                    setState(() {
                      _wheelchairSelected = !_wheelchairSelected;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Special Assistance
                _buildServiceCard(
                  icon: Icons.support_agent,
                  title: 'Special Assistance',
                  description: 'Personal assistance throughout journey',
                  price: '\$25',
                  hasToggle: true,
                  isSelected: _specialAssistanceSelected,
                  onToggle: () {
                    setState(() {
                      _specialAssistanceSelected = !_specialAssistanceSelected;
                    });
                  },
                ),
                
                const SizedBox(height: 80), // Space for bottom button
              ],
            ),
          ),
          
          // Bottom Button
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required String price,
    bool hasCounter = false,
    bool hasToggle = false,
    int count = 0,
    bool isSelected = false,
    VoidCallback? onIncrement,
    VoidCallback? onDecrement,
    VoidCallback? onToggle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.cyan.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.cyan, size: 28),
          ),
          const SizedBox(width: 16),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14,
                    color: price == 'Free' ? Colors.green : Colors.cyan,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          // Action (Counter or Toggle)
          if (hasCounter) ...[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onDecrement,
                    icon: const Icon(Icons.remove, size: 18),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onIncrement,
                    icon: const Icon(Icons.add, size: 18),
                    padding: const EdgeInsets.all(8),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ],
          
          if (hasToggle) ...[
            TextButton(
              onPressed: onToggle,
              style: TextButton.styleFrom(
                foregroundColor: isSelected ? Colors.red : Colors.cyan,
              ),
              child: Text(
                isSelected ? 'Remove' : 'Add',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ],
      ),
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
              // Check if seat selection is enabled
              if (_seatSelectionSelected) {
                // Go to seat map
                Navigator.pushNamed(context, '/seat-map');
              } else {
                // Skip seat map, go directly to payment
                Navigator.pushNamed(context, '/payment');
              }
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
              _seatSelectionSelected ? 'Continue to Seat Selection' : 'Continue to Payment',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
