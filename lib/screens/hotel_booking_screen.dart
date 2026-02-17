import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key});

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String _destination   = '';
  DateTime _checkIn     = DateTime.now().add(const Duration(days: 1));
  DateTime _checkOut    = DateTime.now().add(const Duration(days: 5));
  int _rooms            = 1;
  int _guests           = 2;
  bool _searched        = false;

  static const _dummyHotels = [
    _Hotel('Grand Hyatt Amman',      'Amman, Jordan',     'assets/hotel1.jpg', 4.8, 'JOD 120', 'Deluxe Room', ['pool','wifi','spa','parking']),
    _Hotel('Four Seasons Dubai',     'Dubai, UAE',         'assets/hotel2.jpg', 4.9, 'JOD 210', 'Superior Room', ['pool','wifi','gym','breakfast']),
    _Hotel('The Ritz-Carlton',       'Dubai, UAE',         'assets/hotel3.jpg', 4.7, 'JOD 185', 'Classic Room', ['pool','wifi','spa','beach']),
    _Hotel('Kempinski Hotel',        'Amman, Jordan',     'assets/hotel4.jpg', 4.6, 'JOD 95',  'Standard Room', ['wifi','gym','parking']),
    _Hotel('Marriott Amman',         'Amman, Jordan',     'assets/hotel5.jpg', 4.5, 'JOD 88',  'Superior Room', ['pool','wifi','breakfast']),
  ];

  int get _nights => _checkOut.difference(_checkIn).inDays;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Book a Hotel'),
        backgroundColor: AppColors.surface,
      ),
      body: Column(children: [
        // Search Form
        _buildSearchForm(),
        // Results
        Expanded(
          child: _searched
              ? _buildResults()
              : _buildIllustration(),
        ),
      ]),
    );
  }

  // ── Search Form ─────────────────────────────────────────
  Widget _buildSearchForm() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        // Destination
        _FormField(
          icon: Icons.location_on_outlined,
          hint: 'Destination city or hotel name',
          label: 'Where to?',
          value: _destination.isEmpty ? null : _destination,
          onTap: () async {
            final result = await _showDestinationPicker();
            if (result != null) setState(() => _destination = result);
          },
        ),
        const SizedBox(height: 10),

        // Dates
        Row(children: [
          Expanded(
            child: _FormField(
              icon: Icons.calendar_today_outlined,
              label: 'Check-in',
              value: _formatDate(_checkIn),
              onTap: () => _pickDate(isCheckIn: true),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _FormField(
              icon: Icons.calendar_today_outlined,
              label: 'Check-out',
              value: _formatDate(_checkOut),
              onTap: () => _pickDate(isCheckIn: false),
            ),
          ),
        ]),
        const SizedBox(height: 10),

        // Guests row
        Row(children: [
          Expanded(
            child: _CounterField(
              icon: Icons.meeting_room_outlined,
              label: 'Rooms',
              value: _rooms,
              onDecrement: () { if (_rooms > 1) setState(() => _rooms--); },
              onIncrement: () => setState(() => _rooms++),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _CounterField(
              icon: Icons.person_outline,
              label: 'Guests',
              value: _guests,
              onDecrement: () { if (_guests > 1) setState(() => _guests--); },
              onIncrement: () => setState(() => _guests++),
            ),
          ),
        ]),
        const SizedBox(height: 14),

        // Search button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              if (_destination.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a destination'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              setState(() => _searched = true);
            },
            icon: const Icon(Icons.search, size: 20),
            label: const Text('Search Hotels'),
          ),
        ),
      ]),
    );
  }

  // ── Illustration ────────────────────────────────────────
  Widget _buildIllustration() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hotel, size: 80, color: AppColors.border),
          const SizedBox(height: 16),
          Text('Find your perfect stay', style: AppTextStyles.titleMedium),
          const SizedBox(height: 8),
          Text('Enter a destination to search hotels',
              style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  // ── Results ─────────────────────────────────────────────
  Widget _buildResults() {
    return Column(children: [
      // Results header
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${_dummyHotels.length} hotels in $_destination',
                style: AppTextStyles.titleSmall),
            Text('$_nights night${_nights > 1 ? 's' : ''}',
                style: AppTextStyles.bodySmall),
          ],
        ),
      ),
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          itemCount: _dummyHotels.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) => _buildHotelCard(_dummyHotels[i]),
        ),
      ),
    ]);
  }

  Widget _buildHotelCard(_Hotel hotel) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: AppRadius.md,
        onTap: () => _showHotelDetail(hotel),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: AppColors.cyanLight,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.hotel, size: 48, color: AppColors.cyan),
                  const SizedBox(height: 4),
                  Text(hotel.name, style: const TextStyle(color: AppColors.cyan, fontSize: 11)),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(hotel.name,
                            style: AppTextStyles.titleSmall,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Row(children: [
                        const Icon(Icons.star, color: AppColors.gold, size: 16),
                        const SizedBox(width: 2),
                        Text('${hotel.rating}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 13)),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(children: [
                    const Icon(Icons.location_on_outlined,
                        color: AppColors.textSecondary, size: 14),
                    const SizedBox(width: 4),
                    Text(hotel.location, style: AppTextStyles.bodySmall),
                  ]),
                  const SizedBox(height: 10),

                  // Amenities
                  Wrap(
                    spacing: 6, runSpacing: 6,
                    children: hotel.amenities.map((a) => _amenityChip(a)).toList(),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('${hotel.price}/night',
                            style: AppTextStyles.price.copyWith(fontSize: 18)),
                        Text(hotel.roomType, style: AppTextStyles.bodySmall),
                      ]),
                      ElevatedButton(
                        onPressed: () => _showHotelDetail(hotel),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text('Book'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _amenityChip(String amenity) {
    final icons = {
      'pool': Icons.pool, 'wifi': Icons.wifi,
      'spa': Icons.spa, 'gym': Icons.fitness_center,
      'parking': Icons.local_parking, 'breakfast': Icons.free_breakfast,
      'beach': Icons.beach_access,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cyanLight, borderRadius: AppRadius.full,
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icons[amenity] ?? Icons.check, size: 12, color: AppColors.cyanDark),
        const SizedBox(width: 4),
        Text(amenity, style: const TextStyle(
            fontSize: 11, color: AppColors.cyanDark, fontWeight: FontWeight.w500)),
      ]),
    );
  }

  // ── Hotel Detail Sheet ──────────────────────────────────
  void _showHotelDetail(_Hotel hotel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (_, controller) => ListView(
          controller: controller,
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Container(
                width: 36, height: 4,
                decoration: BoxDecoration(
                    color: AppColors.border, borderRadius: AppRadius.full),
              ),
            ),
            const SizedBox(height: 16),
            Text(hotel.name, style: AppTextStyles.displayMedium),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.location_on_outlined,
                  color: AppColors.textSecondary, size: 16),
              const SizedBox(width: 4),
              Text(hotel.location, style: AppTextStyles.bodySmall),
              const Spacer(),
              const Icon(Icons.star, color: AppColors.gold, size: 16),
              const SizedBox(width: 4),
              Text('${hotel.rating}',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 20),
            _detailRow('Check-in', _formatDate(_checkIn)),
            _detailRow('Check-out', _formatDate(_checkOut)),
            _detailRow('Duration', '$_nights night${_nights > 1 ? 's' : ''}'),
            _detailRow('Rooms', '$_rooms room${_rooms > 1 ? 's' : ''}'),
            _detailRow('Guests', '$_guests guest${_guests > 1 ? 's' : ''}'),
            _detailRow('Room Type', hotel.roomType),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total', style: AppTextStyles.titleMedium),
                Text(
                  '${hotel.price.replaceAll('/night', '')} × $_nights nights',
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(_calculateTotal(hotel.price, _nights),
                style: AppTextStyles.price),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                _showBookingConfirmed(hotel);
              },
              child: const Text('Confirm Booking'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Text(value, style: AppTextStyles.titleSmall),
        ],
      ),
    );
  }

  void _showBookingConfirmed(_Hotel hotel) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(children: [
          Icon(Icons.check_circle, color: AppColors.success, size: 28),
          SizedBox(width: 8),
          Text('Hotel Booked!'),
        ]),
        content: Text(
            '${hotel.name}\n${_formatDate(_checkIn)} – ${_formatDate(_checkOut)}\n$_nights nights'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  // ── Helpers ─────────────────────────────────────────────
  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  String _calculateTotal(String priceStr, int nights) {
    final num = int.tryParse(
            priceStr.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return 'JOD ${num * nights}';
  }

  Future<String?> _showDestinationPicker() async {
    const destinations = ['Amman', 'Dubai', 'London', 'Cairo', 'Istanbul', 'Paris'];
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
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Select Destination', style: AppTextStyles.titleMedium),
          ),
          const Divider(height: 1),
          ...destinations.map((d) => ListTile(
            leading: const Icon(Icons.location_on_outlined, color: AppColors.cyan),
            title: Text(d),
            onTap: () => Navigator.pop(ctx, d),
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _pickDate({required bool isCheckIn}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isCheckIn ? _checkIn : _checkOut,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.cyan),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkIn = picked;
          if (_checkOut.isBefore(_checkIn)) {
            _checkOut = _checkIn.add(const Duration(days: 1));
          }
        } else {
          _checkOut = picked;
        }
      });
    }
  }
}

// ── Data & helper widgets ───────────────────────────────────

class _Hotel {
  final String name, location, image, price, roomType;
  final double rating;
  final List<String> amenities;

  const _Hotel(this.name, this.location, this.image, this.rating,
      this.price, this.roomType, this.amenities);
}

class _FormField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;
  final String? value;
  final VoidCallback? onTap;

  const _FormField({
    required this.icon,
    required this.label,
    this.hint = '',
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppRadius.md,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(children: [
          Icon(icon, color: AppColors.cyan, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodySmall),
                const SizedBox(height: 2),
                Text(
                  value ?? hint,
                  style: value != null
                      ? AppTextStyles.titleSmall
                      : const TextStyle(color: AppColors.textHint, fontSize: 14),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textHint, size: 18),
        ]),
      ),
    );
  }
}

class _CounterField extends StatelessWidget {
  final IconData icon;
  final String label;
  final int value;
  final VoidCallback onDecrement, onIncrement;

  const _CounterField({
    required this.icon,
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.md,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(children: [
        Icon(icon, color: AppColors.cyan, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: AppTextStyles.bodySmall),
            Text('$value', style: AppTextStyles.titleSmall),
          ]),
        ),
        _stepBtn(Icons.remove, onDecrement),
        const SizedBox(width: 4),
        _stepBtn(Icons.add, onIncrement),
      ]),
    );
  }

  Widget _stepBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 26, height: 26,
        decoration: BoxDecoration(
          color: AppColors.cyanLight, borderRadius: AppRadius.sm,
        ),
        child: Icon(icon, size: 16, color: AppColors.cyanDark),
      ),
    );
  }
}
