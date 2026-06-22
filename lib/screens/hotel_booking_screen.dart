import 'package:flutter/material.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.hotelTitle),
        backgroundColor: AppColors.surface,
      ),
      body: Column(children: [
        _buildSearchForm(),
        Expanded(
          child: _searched
              ? _buildResults()
              : _buildIllustration(),
        ),
      ]),
    );
  }

  Widget _buildSearchForm() {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        _FormField(
          icon: Icons.location_on_outlined,
          hint: AppLocalizations.of(context)!.hotelDestination,
          label: AppLocalizations.of(context)!.hotelWhere,
          value: _destination.isEmpty ? null : _destination,
          onTap: () async {
            final result = await _showDestinationPicker();
            if (result != null) setState(() => _destination = result);
          },
        ),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
            child: _FormField(
              icon: Icons.calendar_today_outlined,
              label: AppLocalizations.of(context)!.hotelCheckIn,
              value: _formatDate(_checkIn),
              onTap: () => _pickDate(isCheckIn: true),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _FormField(
              icon: Icons.calendar_today_outlined,
              label: AppLocalizations.of(context)!.hotelCheckOut,
              value: _formatDate(_checkOut),
              onTap: () => _pickDate(isCheckIn: false),
            ),
          ),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
            child: _CounterField(
              icon: Icons.meeting_room_outlined,
              label: AppLocalizations.of(context)!.hotelRooms,
              value: _rooms,
              onDecrement: () { if (_rooms > 1) setState(() => _rooms--); },
              onIncrement: () => setState(() => _rooms++),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _CounterField(
              icon: Icons.person_outline,
              label: AppLocalizations.of(context)!.hotelGuests,
              value: _guests,
              onDecrement: () { if (_guests > 1) setState(() => _guests--); },
              onIncrement: () => setState(() => _guests++),
            ),
          ),
        ]),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              if (_destination.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.hotelErrorDestination),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              setState(() => _searched = true);
            },
            icon: const Icon(Icons.search, size: 20),
            label: Text(AppLocalizations.of(context)!.hotelSearch),
          ),
        ),
      ]),
    );
  }

  Widget _buildIllustration() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hotel, size: 80, color: AppColors.border),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.hotelEmptyMessage, style: AppTextStyles.titleMedium),
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context)!.hotelEmptySubtitle,
              style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  Widget _buildResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: AppColors.cyan.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.construction_outlined,
                  size: 44, color: AppColors.cyan),
            ),
            const SizedBox(height: 24),
            const Text('Coming Soon',
                style: AppTextStyles.displayMedium),
            const SizedBox(height: 10),
            Text(
              'Hotel booking for $_destination is not available yet. '
              'We\'re working hard to bring this feature to you.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(height: 1.5),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => setState(() => _searched = false),
              icon: const Icon(Icons.arrow_back, size: 18),
              label: const Text('Back to Search'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.cyan,
                side: const BorderSide(color: AppColors.cyan),
                shape: const RoundedRectangleBorder(borderRadius: AppRadius.md),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';

  Future<String?> _showDestinationPicker() async {
    const destinations = ['Amman', 'Dubai', 'London', 'Cairo', 'Istanbul', 'Paris'];
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: cs.outlineVariant,                 
                borderRadius: AppRadius.full,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(AppLocalizations.of(ctx)!.hotelSelectDestination, style: AppTextStyles.titleMedium),
            ),
            const Divider(height: 1),
            ...destinations.map((d) => ListTile(
              leading: const Icon(Icons.location_on_outlined, color: AppColors.cyan),
              title: Text(d),
              onTap: () => Navigator.pop(ctx, d),
            )),
            const SizedBox(height: 16),
          ],
        );
      },
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

// ── Data & helper widgets ────────────────────────────────────

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
                      : TextStyle(color: AppColors.textHint, fontSize: 14),
                ),
              ],
            ),
          ),
           Icon(Icons.chevron_right, color: AppColors.textHint, size: 18),
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
