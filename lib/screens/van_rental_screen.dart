import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import 'package:skytrip/providers/vehicle_provider.dart';
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
  bool _searched         = false;

  static const _categories = ['All', 'Economy', 'SUV', 'Van', 'Luxury'];

  // ─────────────────────────────────────────────
  //  ROOT BUILD
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.vanTitle),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(children: [
          _buildSearchForm(context),
          if (_searched) _buildCategoryFilter(context),
          Expanded(
            child: _searched ? _buildResults() : _buildIllustration(context),
          ),
        ]),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  SEARCH FORM
  // ─────────────────────────────────────────────
  Widget _buildSearchForm(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.all(16),
      child: Column(children: [
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
                color: AppColors.cyanLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.swap_horiz,
                  color: AppColors.cyan, size: 18),
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
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text(AppLocalizations.of(context)!.vanErrorPickup),
                  behavior: SnackBarBehavior.floating,
                ));
                return;
              }
              setState(() => _searched = true);
            },
            icon: const Icon(Icons.directions_car, size: 20),
            label: Text(AppLocalizations.of(context)!.vanFind),
          ),
        ),
      ]),
    );
  }

  // ─────────────────────────────────────────────
  //  CATEGORY FILTER
  // ─────────────────────────────────────────────
  Widget _buildCategoryFilter(BuildContext context) {
    final selectedType = context.watch<VehicleProvider>().selectedType;

    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories.map((cat) {
            final selected = selectedType == cat;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(cat),
                selected: selected,
                onSelected: (_) =>
                    context.read<VehicleProvider>().setType(cat),
                selectedColor: AppColors.cyan,
                labelStyle: TextStyle(
                  color: selected
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.w500,
                ),
                showCheckmark: false,
                side: BorderSide(
                  color: selected
                      ? AppColors.cyan
                      : Theme.of(context).dividerColor,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  ILLUSTRATION
  // ─────────────────────────────────────────────
  Widget _buildIllustration(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_car,
              size: 80, color: Theme.of(context).dividerColor),
          const SizedBox(height: 16),
          Text(AppLocalizations.of(context)!.vanEmptyMessage,
              style: AppTextStyles.titleMedium),
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context)!.vanEmptySubtitle,
              style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  RESULTS — COMING SOON
  // ─────────────────────────────────────────────
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
              'Vehicle rental from $_pickupLocation is not available yet. '
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

  // ─────────────────────────────────────────────
  //  HELPERS
  // ─────────────────────────────────────────────
  String _formatDate(DateTime d) =>
      '${d.day}/${d.month}/${d.year}';

  Future<String?> _showLocationPicker(String title) async {
    const locations = [
      'Amman Airport',
      'Queen Alia Airport',
      'Amman Downtown',
      'Dubai Airport',
      'Dubai Marina',
      'London Heathrow',
    ];
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: AppRadius.full,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: AppTextStyles.titleMedium),
          ),
          const Divider(height: 1),
          ...locations.map((l) => ListTile(
                leading: const Icon(Icons.location_on_outlined,
                    color: AppColors.cyan),
                title: Text(l),
                onTap: () => Navigator.pop(ctx, l),
              )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _pickDate({required bool isPickup}) async {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;
    final picked = await showDatePicker(
      context: context,
      initialDate: isPickup ? _pickupDate : _returnDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: isDark
              ? const ColorScheme.dark(primary: AppColors.cyan)
              : const ColorScheme.light(primary: AppColors.cyan),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isPickup) {
          _pickupDate = picked;
          if (_returnDate.isBefore(_pickupDate)) {
            _returnDate =
                _pickupDate.add(const Duration(days: 1));
          }
        } else {
          _returnDate = picked;
        }
      });
    }
  }
}

// ══════════════════════════════════════════════════
//  LOCAL WIDGETS
// ══════════════════════════════════════════════════

class _LocationField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback? onTap;

  const _LocationField({
    required this.icon,
    required this.label,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: AppRadius.md,
          border:
              Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(children: [
          Icon(icon, color: AppColors.cyan, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodySmall),
                Text(
                  value ?? 'Select',
                  style: value != null
                      ? AppTextStyles.titleSmall
                      : TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 13),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label, value;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: AppRadius.md,
          border:
              Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(children: [
          const Icon(Icons.calendar_today_outlined,
              color: AppColors.cyan, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.bodySmall),
              Text(value, style: AppTextStyles.titleSmall),
            ],
          ),
        ]),
      ),
    );
  }
}