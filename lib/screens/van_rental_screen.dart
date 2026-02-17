import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class VanRentalScreen extends StatefulWidget {
  const VanRentalScreen({super.key});

  @override
  State<VanRentalScreen> createState() => _VanRentalScreenState();
}

class _VanRentalScreenState extends State<VanRentalScreen> {
  String _pickupLocation = '';
  String _dropLocation   = '';
  DateTime _pickupDate   = DateTime.now().add(const Duration(days: 1));
  DateTime _returnDate   = DateTime.now().add(const Duration(days: 4));
  String _vehicleType    = 'All';
  bool _searched         = false;

  static const _categories = ['All', 'Economy', 'SUV', 'Van', 'Luxury'];

  static const _dummyVehicles = [
    _Vehicle('Toyota Corolla', 'Economy', 4, 2, 'JOD 25', 'assets/car1.jpg', 4.5, ['AC', 'GPS', 'Bluetooth']),
    _Vehicle('Toyota Hiace Van', 'Van', 12, 5, 'JOD 55', 'assets/car2.jpg', 4.7, ['AC', 'GPS', 'Large Boot']),
    _Vehicle('Nissan Patrol', 'SUV', 7, 4, 'JOD 65', 'assets/car3.jpg', 4.8, ['AC', 'GPS', '4WD', 'Sunroof']),
    _Vehicle('Mercedes S-Class', 'Luxury', 4, 2, 'JOD 120', 'assets/car4.jpg', 4.9, ['AC', 'GPS', 'Leather', 'Premium Sound']),
    _Vehicle('Hyundai Tucson', 'SUV', 5, 3, 'JOD 45', 'assets/car5.jpg', 4.6, ['AC', 'GPS', 'Bluetooth']),
    _Vehicle('Kia Carnival', 'Van', 8, 4, 'JOD 60', 'assets/car6.jpg', 4.4, ['AC', 'GPS', 'USB Charging']),
  ];

  List<_Vehicle> get _filteredVehicles => _vehicleType == 'All'
      ? _dummyVehicles
      : _dummyVehicles.where((v) => v.type == _vehicleType).toList();

  int get _days => _returnDate.difference(_pickupDate).inDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(title: const Text('Van Rental'), backgroundColor: AppColors.surface),
      body: Column(children: [
        _buildSearchForm(),
        if (_searched) _buildCategoryFilter(),
        Expanded(child: _searched ? _buildResults() : _buildIllustration()),
      ]),
    );
  }

  // ── Search Form ─────────────────────────────────────────
  Widget _buildSearchForm() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        // Pickup/Drop row
        Row(children: [
          Expanded(
            child: _LocationField(
              icon: Icons.my_location,
              label: 'Pick-up',
              value: _pickupLocation.isEmpty ? null : _pickupLocation,
              onTap: () async {
                final r = await _showLocationPicker('Pick-up Location');
                if (r != null) setState(() => _pickupLocation = r);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: AppColors.cyanLight, shape: BoxShape.circle,
              ),
              child: const Icon(Icons.swap_horiz, color: AppColors.cyan, size: 18),
            ),
          ),
          Expanded(
            child: _LocationField(
              icon: Icons.location_on_outlined,
              label: 'Drop-off',
              value: _dropLocation.isEmpty ? null : _dropLocation,
              onTap: () async {
                final r = await _showLocationPicker('Drop-off Location');
                if (r != null) setState(() => _dropLocation = r);
              },
            ),
          ),
        ]),
        const SizedBox(height: 10),

        // Dates
        Row(children: [
          Expanded(
            child: _DateField(
              label: 'Pick-up Date',
              value: _formatDate(_pickupDate),
              onTap: () => _pickDate(isPickup: true),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _DateField(
              label: 'Return Date',
              value: _formatDate(_returnDate),
              onTap: () => _pickDate(isPickup: false),
            ),
          ),
        ]),
        const SizedBox(height: 14),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              if (_pickupLocation.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Please select a pick-up location'),
                  behavior: SnackBarBehavior.floating,
                ));
                return;
              }
              setState(() => _searched = true);
            },
            icon: const Icon(Icons.directions_car, size: 20),
            label: const Text('Find Vehicles'),
          ),
        ),
      ]),
    );
  }

  // ── Category Filter ─────────────────────────────────────
  Widget _buildCategoryFilter() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories.map((cat) {
            final selected = _vehicleType == cat;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(cat),
                selected: selected,
                onSelected: (_) => setState(() => _vehicleType = cat),
                selectedColor: AppColors.cyan,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                showCheckmark: false,
                side: BorderSide(color: selected ? AppColors.cyan : AppColors.border),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ── Illustration ────────────────────────────────────────
  Widget _buildIllustration() {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.directions_car, size: 80, color: AppColors.border),
        const SizedBox(height: 16),
        Text('Find the perfect ride', style: AppTextStyles.titleMedium),
        const SizedBox(height: 8),
        Text('Select locations to browse available vehicles',
            style: AppTextStyles.bodySmall),
      ]),
    );
  }

  // ── Results ─────────────────────────────────────────────
  Widget _buildResults() {
    final vehicles = _filteredVehicles;

    if (vehicles.isEmpty) {
      return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.no_transfer, size: 64, color: AppColors.border),
          const SizedBox(height: 16),
          Text('No vehicles in this category', style: AppTextStyles.titleSmall),
        ]),
      );
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('${vehicles.length} vehicle${vehicles.length > 1 ? 's' : ''} available',
              style: AppTextStyles.titleSmall),
          Text('$_days day${_days > 1 ? 's' : ''}', style: AppTextStyles.bodySmall),
        ]),
      ),
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          itemCount: vehicles.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => _buildVehicleCard(vehicles[i]),
        ),
      ),
    ]);
  }

  Widget _buildVehicleCard(_Vehicle v) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: AppRadius.md,
        onTap: () => _showVehicleDetail(v),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Vehicle icon placeholder
            Container(
              width: 90, height: 76,
              decoration: BoxDecoration(
                color: AppColors.cyanLight, borderRadius: AppRadius.sm,
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.directions_car, color: AppColors.cyan, size: 36),
                const SizedBox(height: 2),
                Text(v.type,
                    style: const TextStyle(fontSize: 10, color: AppColors.cyanDark)),
              ]),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Text(v.name, style: AppTextStyles.titleSmall,
                      overflow: TextOverflow.ellipsis)),
                  Row(children: [
                    const Icon(Icons.star, color: AppColors.gold, size: 14),
                    const SizedBox(width: 2),
                    Text('${v.rating}', style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 12)),
                  ]),
                ]),
                const SizedBox(height: 6),

                // Specs
                Row(children: [
                  _specChip(Icons.person, '${v.seats}'),
                  const SizedBox(width: 8),
                  _specChip(Icons.luggage, '${v.bags}'),
                ]),
                const SizedBox(height: 8),

                // Feature chips
                Wrap(
                  spacing: 4, runSpacing: 4,
                  children: v.features.take(3).map((f) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.bg, borderRadius: AppRadius.full,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(f, style: const TextStyle(fontSize: 10)),
                  )).toList(),
                ),

                const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('${v.price}/day', style: AppTextStyles.price.copyWith(fontSize: 16)),
                  ElevatedButton(
                    onPressed: () => _showVehicleDetail(v),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    child: const Text('Rent'),
                  ),
                ]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _specChip(IconData icon, String value) {
    return Row(children: [
      Icon(icon, size: 14, color: AppColors.textSecondary),
      const SizedBox(width: 3),
      Text(value, style: AppTextStyles.bodySmall),
    ]);
  }

  // ── Vehicle Detail ──────────────────────────────────────
  void _showVehicleDetail(_Vehicle v) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.92,
        expand: false,
        builder: (_, ctrl) => ListView(
          controller: ctrl,
          padding: const EdgeInsets.all(20),
          children: [
            Center(child: Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                  color: AppColors.border, borderRadius: AppRadius.full),
            )),
            const SizedBox(height: 16),

            // Hero image
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.cyanLight, borderRadius: AppRadius.md,
              ),
              child: const Center(child: Icon(Icons.directions_car, size: 70, color: AppColors.cyan)),
            ),
            const SizedBox(height: 16),

            Text(v.name, style: AppTextStyles.displayMedium),
            const SizedBox(height: 4),
            Row(children: [
              _typeBadge(v.type),
              const Spacer(),
              const Icon(Icons.star, color: AppColors.gold, size: 16),
              const SizedBox(width: 4),
              Text('${v.rating}', style: const TextStyle(fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 16),

            // Specs
            Row(children: [
              _infoBox(Icons.person, '${v.seats} Seats'),
              const SizedBox(width: 10),
              _infoBox(Icons.luggage, '${v.bags} Bags'),
              const SizedBox(width: 10),
              _infoBox(Icons.ac_unit, 'A/C'),
            ]),
            const SizedBox(height: 16),

            // Features
            Text('Features', style: AppTextStyles.titleSmall),
            const SizedBox(height: 8),
            Wrap(spacing: 8, runSpacing: 8, children: v.features.map((f) => Chip(
              label: Text(f, style: const TextStyle(fontSize: 12)),
            )).toList()),
            const SizedBox(height: 20),

            // Booking details
            _detailRow('Pick-up', '$_pickupLocation · ${_formatDate(_pickupDate)}'),
            _detailRow('Drop-off', '$_dropLocation · ${_formatDate(_returnDate)}'),
            _detailRow('Duration', '$_days day${_days > 1 ? 's' : ''}'),
            const Divider(height: 24),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Total', style: AppTextStyles.titleMedium),
              Text(_calculateTotal(v.price, _days), style: AppTextStyles.price),
            ]),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                _showConfirmation(v);
              },
              child: const Text('Confirm Rental'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _typeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cyanLight, borderRadius: AppRadius.full,
      ),
      child: Text(type, style: const TextStyle(
          color: AppColors.cyanDark, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }

  Widget _infoBox(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.cyanLight, borderRadius: AppRadius.sm,
        ),
        child: Column(children: [
          Icon(icon, color: AppColors.cyan, size: 20),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: AppTextStyles.bodySmall),
        Flexible(child: Text(value, style: AppTextStyles.titleSmall,
            textAlign: TextAlign.end)),
      ]),
    );
  }

  void _showConfirmation(_Vehicle v) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(children: [
          Icon(Icons.check_circle, color: AppColors.success, size: 28),
          SizedBox(width: 8),
          Text('Rental Confirmed!'),
        ]),
        content: Text('${v.name}\n${_formatDate(_pickupDate)} – ${_formatDate(_returnDate)}\n$_days days'),
        actions: [
          ElevatedButton(onPressed: () => Navigator.pop(ctx), child: const Text('Done')),
        ],
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────
  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  String _calculateTotal(String priceStr, int days) {
    final num = int.tryParse(priceStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return 'JOD ${num * days}';
  }

  Future<String?> _showLocationPicker(String title) async {
    const locations = ['Amman Airport', 'Queen Alia Airport', 'Amman Downtown',
        'Dubai Airport', 'Dubai Marina', 'London Heathrow'];
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(width: 36, height: 4,
              decoration: BoxDecoration(color: AppColors.border, borderRadius: AppRadius.full)),
          Padding(padding: const EdgeInsets.all(16),
              child: Text(title, style: AppTextStyles.titleMedium)),
          const Divider(height: 1),
          ...locations.map((l) => ListTile(
            leading: const Icon(Icons.location_on_outlined, color: AppColors.cyan),
            title: Text(l),
            onTap: () => Navigator.pop(ctx, l),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _pickDate({required bool isPickup}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isPickup ? _pickupDate : _returnDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.cyan)),
        child: child!,
      ),
    );
    if (picked != null) setState(() {
      if (isPickup) {
        _pickupDate = picked;
        if (_returnDate.isBefore(_pickupDate)) {
          _returnDate = _pickupDate.add(const Duration(days: 1));
        }
      } else {
        _returnDate = picked;
      }
    });
  }
}

// ── Data models ─────────────────────────────────────────────

class _Vehicle {
  final String name, type, image, price;
  final int seats, bags;
  final double rating;
  final List<String> features;

  const _Vehicle(this.name, this.type, this.seats, this.bags,
      this.price, this.image, this.rating, this.features);
}

class _LocationField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback? onTap;
  const _LocationField({required this.icon, required this.label, this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface, borderRadius: AppRadius.md,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(children: [
          Icon(icon, color: AppColors.cyan, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: AppTextStyles.bodySmall),
            Text(value ?? 'Select',
                style: value != null
                    ? AppTextStyles.titleSmall
                    : const TextStyle(color: AppColors.textHint, fontSize: 13)),
          ])),
        ]),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label, value;
  final VoidCallback onTap;
  const _DateField({required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface, borderRadius: AppRadius.md,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(children: [
          const Icon(Icons.calendar_today_outlined, color: AppColors.cyan, size: 18),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: AppTextStyles.bodySmall),
            Text(value, style: AppTextStyles.titleSmall),
          ]),
        ]),
      ),
    );
  }
}
