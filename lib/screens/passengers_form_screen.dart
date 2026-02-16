import 'package:flutter/material.dart';
import '../models/flight_model.dart';
import '../models/booking_search_model.dart';

class PassengersFormScreen extends StatefulWidget {
  const PassengersFormScreen({super.key});

  @override
  State<PassengersFormScreen> createState() => _PassengersFormScreenState();
}

class _PassengersFormScreenState extends State<PassengersFormScreen> {
  FlightModel? _flight;
  BookingSearchModel? _search;
  bool _argumentsLoaded = false;

  int _currentPassengerIndex = 0;
  String _selectedDocumentType = 'passport';

  int get _adults => _search?.adults ?? 1;
  int get _youth => _search?.youth ?? 0;
  int get _children => _search?.children ?? 0;
  int get _infants => _search?.infants ?? 0;
  int get _totalPassengers => _search?.totalPassengers ?? 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_argumentsLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      _flight = args?['flight'] as FlightModel?;
      _search = args?['search'] as BookingSearchModel?;
      _argumentsLoaded = true;
    }
  }

  String get _currentPassengerType {
    if (_currentPassengerIndex < _adults) return 'Adult';
    if (_currentPassengerIndex < _adults + _youth) return 'Youth';
    if (_currentPassengerIndex < _adults + _youth + _children) return 'Child';
    return 'Infant';
  }

  String get _passengerLabel {
    if (_currentPassengerIndex < _adults)
      return 'Adult ${_currentPassengerIndex + 1}';
    if (_currentPassengerIndex < _adults + _youth)
      return 'Youth ${_currentPassengerIndex - _adults + 1}';
    if (_currentPassengerIndex < _adults + _youth + _children)
      return 'Child ${_currentPassengerIndex - _adults - _youth + 1}';
    return 'Infant ${_currentPassengerIndex - _adults - _youth - _children + 1}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Information'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Indicator
          _buildProgressHeader(),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Passenger Type Label
                  _buildPassengerTypeLabel(),
                  const SizedBox(height: 24),
                  
                  // Form Fields
                  _buildFormFields(),
                  const SizedBox(height: 24),
                  
                  // Navigation Buttons (if multiple passengers)
                  if (_totalPassengers > 1) _buildPassengerNavigation(),
                ],
              ),
            ),
          ),
          
          // Bottom Continue Button
          _buildBottomButton(),
        ],
      ),
    );
  }

  // ==================== SECTION BUILDERS ====================

  Widget _buildProgressHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.cyan.shade50,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Passenger ${_currentPassengerIndex + 1} of $_totalPassengers',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${((_currentPassengerIndex + 1) / _totalPassengers * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (_currentPassengerIndex + 1) / _totalPassengers,
            backgroundColor: Colors.grey.shade300,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyan),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerTypeLabel() {
    IconData icon;
    Color color;
    String ageRange;
    
    switch (_currentPassengerType) {
      case 'Adult':
        icon = Icons.person;
        color = Colors.cyan;
        ageRange = '12+ years';
        break;
      case 'Youth':
        icon = Icons.person_outline;
        color = Colors.blue;
        ageRange = '12-16 years';
        break;
      case 'Child':
        icon = Icons.child_care;
        color = Colors.orange;
        ageRange = '2-12 years';
        break;
      case 'Infant':
        icon = Icons.baby_changing_station;
        color = Colors.purple;
        ageRange = '0-2 years (1 per adult)';
        break;
      default:
        icon = Icons.person;
        color = Colors.cyan;
        ageRange = '';
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _passengerLabel,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ageRange,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First Name + Last Name (Row)
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('First Name *'),
                  const SizedBox(height: 8),
                  _buildTextField(hint: '', icon: Icons.person_outline),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('Last Name *'),
                  const SizedBox(height: 8),
                  _buildTextField(hint: '', icon: Icons.person_outline),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Email
        _buildSectionLabel('Email *'),
        const SizedBox(height: 8),
        _buildTextField(hint: '', icon: Icons.email_outlined),
        const SizedBox(height: 16),
        
        // Phone
        _buildSectionLabel('Phone *'),
        const SizedBox(height: 8),
        _buildTextField(hint: '', icon: Icons.phone_outlined),
        const SizedBox(height: 16),
        
        // Date of Birth + Gender (Row)
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('Date of Birth *'),
                  const SizedBox(height: 8),
                  _buildDateField(hint: 'mm/dd/yyyy'),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('Gender *'),
                  const SizedBox(height: 8),
                  _buildDropdownField(hint: 'Select Gender', icon: Icons.person_outline),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Issued Country
        _buildSectionLabel('Issued Country *'),
        const SizedBox(height: 8),
        _buildDropdownField(hint: 'Select Country', icon: Icons.public),
        const SizedBox(height: 16),
        
        // Document Type
        _buildSectionLabel('Document Type *'),
        const SizedBox(height: 8),
        _buildDocumentTypeSelector(),
        const SizedBox(height: 16),
        
        // Upload Document
        _buildSectionLabel('Upload Document * (PDF or Photo)'),
        const SizedBox(height: 8),
        _buildUploadButtons(),
      ],
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({required String hint, required IconData icon}) {
    // TODO: Replace with actual TextFormField in Phase 3
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyan.shade300, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hint,
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({required String hint}) {
    // TODO: Replace with actual date picker in Phase 3
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today_outlined, color: Colors.cyan.shade300, size: 20),
          const SizedBox(width: 12),
          Text(
            hint,
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({required String hint, required IconData icon}) {
    // TODO: Replace with actual dropdown in Phase 3
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyan.shade300, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hint,
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
          Icon(Icons.arrow_drop_down, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _buildDocumentTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedDocumentType = 'passport';
              });
            },
            child: Row(
              children: [
                Radio<String>(
                  value: 'passport',
                  groupValue: _selectedDocumentType,
                  onChanged: (value) {
                    setState(() {
                      _selectedDocumentType = value!;
                    });
                  },
                  activeColor: Colors.cyan,
                ),
                const Text('Passport'),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedDocumentType = 'id';
              });
            },
            child: Row(
              children: [
                Radio<String>(
                  value: 'id',
                  groupValue: _selectedDocumentType,
                  onChanged: (value) {
                    setState(() {
                      _selectedDocumentType = value!;
                    });
                  },
                  activeColor: Colors.cyan,
                ),
                const Text('ID'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadButtons() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              // TODO: Implement PDF picker in Phase 4
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Upload PDF: TODO in Phase 4')),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
              ),
              child: Column(
                children: [
                  Icon(Icons.upload_file, color: Colors.cyan.shade300, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    'Upload PDF',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // TODO: Implement camera in Phase 4
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Take Photo: TODO in Phase 4')),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, style: BorderStyle.solid),
              ),
              child: Column(
                children: [
                  Icon(Icons.camera_alt_outlined, color: Colors.cyan.shade300, size: 32),
                  const SizedBox(height: 8),
                  Text(
                    'Take Photo',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPassengerNavigation() {
    return Row(
      children: [
        // Previous Button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _currentPassengerIndex > 0
                ? () {
                    setState(() {
                      _currentPassengerIndex--;
                    });
                  }
                : null,
            icon: const Icon(Icons.arrow_back, size: 18),
            label: const Text('Previous'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(width: 16),
        
        // Next Button
        Expanded(
          child: ElevatedButton(
            onPressed: _currentPassengerIndex < _totalPassengers - 1
                ? () {
                    setState(() {
                      _currentPassengerIndex++;
                    });
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Next'),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    // Only show Continue button if on last passenger or single passenger
    final isLastPassenger = _currentPassengerIndex == _totalPassengers - 1;
    
    if (!isLastPassenger) {
      return const SizedBox.shrink(); // Hide if not last passenger
    }
    
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
              // TODO: Validate all passenger forms in Phase 5
              Navigator.pushNamed(
                context,
                '/services',
                arguments: {'flight': _flight, 'search': _search},
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
              'Continue to Services',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
