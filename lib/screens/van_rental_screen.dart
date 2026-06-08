import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import 'package:skytrip/providers/user_provider.dart';
import 'package:skytrip/providers/vehicle_provider.dart';
import 'package:skytrip/models/vehicle.dart';
import 'package:skytrip/models/booked_vehicle_model.dart';
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

  int get _days => _returnDate.difference(_pickupDate).inDays;

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
  //  RESULTS LIST
  // ─────────────────────────────────────────────
  Widget _buildResults() {
    final vehicles = context.watch<VehicleProvider>().filteredVehicles;

    if (vehicles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.no_transfer,
                size: 64, color: Theme.of(context).dividerColor),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.vanNoVehicles,
                style: AppTextStyles.titleSmall),
          ],
        ),
      );
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!
                  .vanVehiclesAvailable(vehicles.length),
              style: AppTextStyles.titleSmall,
            ),
            Text(
              AppLocalizations.of(context)!.vanDays(_days),
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
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

  // ─────────────────────────────────────────────
  //  VEHICLE CARD
  // ─────────────────────────────────────────────
  Widget _buildVehicleCard(Vehicle v) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        borderRadius: AppRadius.md,
        onTap: () => _showVehicleDetail(v),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90, height: 76,
                decoration: BoxDecoration(
                  color: AppColors.cyanLight,
                  borderRadius: AppRadius.sm,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.directions_car,
                        color: AppColors.cyan, size: 36),
                    const SizedBox(height: 2),
                    Text(v.type,
                        style: const TextStyle(
                            fontSize: 10, color: AppColors.cyanDark)),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Expanded(
                        child: Text(v.name,
                            style: AppTextStyles.titleSmall,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Row(children: [
                        const Icon(Icons.star,
                            color: AppColors.gold, size: 14),
                        const SizedBox(width: 2),
                        Text('${v.rating}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12)),
                      ]),
                    ]),
                    const SizedBox(height: 6),
                    Row(children: [
                      _specChip(Icons.person, '${v.seats}'),
                      const SizedBox(width: 8),
                      _specChip(Icons.luggage, '${v.bags}'),
                    ]),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4, runSpacing: 4,
                      children: v.features.take(3).map((f) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor,
                              borderRadius: AppRadius.full,
                              border: Border.all(
                                  color:
                                      Theme.of(context).dividerColor),
                            ),
                            child: Text(f,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color,
                                )),
                          )).toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.vanPricePerDay(
                            context
                                .watch<UserProvider>()
                                .convertPrice(v.price)
                                .toStringAsFixed(2),
                            context.watch<UserProvider>().currency,
                          ),
                          style:
                              AppTextStyles.price.copyWith(fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () => _showVehicleDetail(v),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: Text(
                              AppLocalizations.of(context)!.vanRent),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specChip(IconData icon, String value) {
    return Row(children: [
      Icon(icon, size: 14, color: Theme.of(context).hintColor),
      const SizedBox(width: 3),
      Text(value, style: AppTextStyles.bodySmall),
    ]);
  }

  // ─────────────────────────────────────────────
  //  VEHICLE DETAIL SHEET
  // ─────────────────────────────────────────────
  void _showVehicleDetail(Vehicle v) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.92,
        expand: false,
        builder: (_, ctrl) => ListView(
          controller: ctrl,
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Container(
                width: 36, height: 4,
                decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: AppRadius.full),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 140,
              decoration: BoxDecoration(
                  color: AppColors.cyanLight,
                  borderRadius: AppRadius.md),
              child: const Center(
                child: Icon(Icons.directions_car,
                    size: 70, color: AppColors.cyan),
              ),
            ),
            const SizedBox(height: 16),
            Text(v.name, style: AppTextStyles.displayMedium),
            const SizedBox(height: 4),
            Row(children: [
              _typeBadge(v.type),
              const Spacer(),
              const Icon(Icons.star, color: AppColors.gold, size: 16),
              const SizedBox(width: 4),
              Text('${v.rating}',
                  style: const TextStyle(fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              _infoBox(Icons.person, '${v.seats} Seats'),
              const SizedBox(width: 10),
              _infoBox(Icons.luggage, '${v.bags} Bags'),
              const SizedBox(width: 10),
              _infoBox(Icons.ac_unit, 'A/C'),
            ]),
            const SizedBox(height: 16),
            Text(AppLocalizations.of(context)!.vanFeatures,
                style: AppTextStyles.titleSmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: v.features
                  .map((f) => Chip(
                      label: Text(f,
                          style: const TextStyle(fontSize: 12))))
                  .toList(),
            ),
            const SizedBox(height: 20),
            _detailRow(
              AppLocalizations.of(context)!.vanPickupLocation,
              '$_pickupLocation · ${_formatDate(_pickupDate)}',
            ),
            _detailRow(
              AppLocalizations.of(context)!.vanDropLocation,
              '$_dropLocation · ${_formatDate(_returnDate)}',
            ),
            _detailRow(
              AppLocalizations.of(context)!.vanDuration,
              AppLocalizations.of(context)!.vanDays(_days),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.dialogTotal,
                    style: AppTextStyles.titleMedium),
                Text(_calculateTotal(v.price, _days),
                    style: AppTextStyles.price),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                _showConfirmation(v);
              },
              child:
                  Text(AppLocalizations.of(ctx)!.vanConfirmRental),
            ),
          ],
        ),
      ),
    );
  }

  Widget _typeBadge(String type) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: AppColors.cyanLight, borderRadius: AppRadius.full),
      child: Text(type,
          style: const TextStyle(
              color: AppColors.cyanDark,
              fontSize: 12,
              fontWeight: FontWeight.w600)),
    );
  }

  Widget _infoBox(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: AppColors.cyanLight, borderRadius: AppRadius.sm),
        child: Column(children: [
          Icon(icon, color: AppColors.cyan, size: 20),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w500)),
        ]),
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
          Flexible(
              child: Text(value,
                  style: AppTextStyles.titleSmall,
                  textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  CONFIRMATION — ✅ يحفظ في Hive
  // ─────────────────────────────────────────────
  void _showConfirmation(Vehicle v) {
    final totalStr = _calculateTotal(v.price, _days);

    // ✅ إنشاء BookedVehicleModel وحفظه عبر الـ Provider في Hive
    final booking = BookedVehicleModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      vehicleName: v.name,
      vehicleType: v.type,
      seats: v.seats,
      bags: v.bags,
      rating: v.rating,
      price: v.price,
      features: List<String>.from(v.features),
      pickupLocation: _pickupLocation,
      dropLocation: _dropLocation,
      pickupDate: _formatDate(_pickupDate),
      returnDate: _formatDate(_returnDate),
      days: _days,
      totalPrice: v.price * _days,
    );
    context.read<VehicleProvider>().addBookedVehicle(booking );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: Row(children: [
          const Icon(Icons.check_circle,
              color: AppColors.success, size: 28),
          const SizedBox(width: 8),
          Text(AppLocalizations.of(ctx)!.vanRentalConfirmed),
        ]),
        content: Text(
          '${v.name}\n'
          '${_formatDate(_pickupDate)} – ${_formatDate(_returnDate)}\n'
          '${AppLocalizations.of(ctx)!.vanDays(_days)}\n'
          '$totalStr',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            child:
                Text(AppLocalizations.of(context)!.dialogDone),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  HELPERS
  // ─────────────────────────────────────────────
  String _formatDate(DateTime d) =>
      '${d.day}/${d.month}/${d.year}';

  String _calculateTotal(double price, int days) {
    final provider = context.read<UserProvider>();
    final total = provider.convertPrice(price * days);
    return '${provider.currency} ${total.toStringAsFixed(2)}';
  }

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