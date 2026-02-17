import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/user_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Notification toggles
  bool _flightUpdates    = true;
  bool _priceAlerts      = true;
  bool _bookingReminders = true;
  bool _promotions       = false;
  bool _smsAlerts        = false;

  // Display
  String _language       = 'English';
  String _currency       = 'JOD – Jordanian Dinar';
  bool   _darkMode       = false;

  // Privacy
  bool _shareData        = false;
  bool _locationServices = true;

  final List<String> _languages = [
    'English', 'Arabic', 'French', 'German', 'Spanish',
  ];
  final List<String> _currencies = [
    'JOD – Jordanian Dinar', 'USD – US Dollar',
    'EUR – Euro', 'GBP – British Pound', 'AED – UAE Dirham',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.surface,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // ── Notifications ─────────────────────────────
          const AppSectionLabel(label: 'Notifications'),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SettingsTile(
                icon: Icons.flight_takeoff,
                title: 'Flight Updates',
                subtitle: 'Gate changes, delays & cancellations',
                trailing: _toggle(_flightUpdates, (v) => setState(() => _flightUpdates = v)),
              ),
              SettingsTile(
                icon: Icons.trending_down,
                iconColor: AppColors.green,
                title: 'Price Alerts',
                subtitle: 'Get notified when prices drop',
                trailing: _toggle(_priceAlerts, (v) => setState(() => _priceAlerts = v)),
              ),
              SettingsTile(
                icon: Icons.notifications_active_outlined,
                iconColor: AppColors.orange,
                title: 'Booking Reminders',
                subtitle: '24h before departure',
                trailing: _toggle(_bookingReminders, (v) => setState(() => _bookingReminders = v)),
              ),
              SettingsTile(
                icon: Icons.local_offer_outlined,
                iconColor: AppColors.purple,
                title: 'Promotions & Offers',
                subtitle: 'Deals, discounts and seasonal offers',
                trailing: _toggle(_promotions, (v) => setState(() => _promotions = v)),
              ),
              SettingsTile(
                icon: Icons.sms_outlined,
                iconColor: AppColors.gold,
                title: 'SMS Alerts',
                subtitle: 'Receive alerts via text message',
                trailing: _toggle(_smsAlerts, (v) => setState(() => _smsAlerts = v)),
                showDivider: false,
              ),
            ]),
          ),

          // ── Display ───────────────────────────────────
          const AppSectionLabel(label: 'Display & Language'),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SettingsTile(
                icon: Icons.language,
                title: 'Language',
                subtitle: _language,
                onTap: () => _showPickerSheet(
                  title: 'Select Language',
                  options: _languages,
                  selected: _language,
                  onSelect: (v) => setState(() => _language = v),
                ),
              ),
              SettingsTile(
                icon: Icons.attach_money,
                iconColor: AppColors.green,
                title: 'Currency',
                subtitle: _currency,
                onTap: () => _showPickerSheet(
                  title: 'Select Currency',
                  options: _currencies,
                  selected: _currency,
                  onSelect: (v) => setState(() => _currency = v),
                ),
              ),
              SettingsTile(
                icon: Icons.dark_mode_outlined,
                iconColor: AppColors.purple,
                title: 'Dark Mode',
                subtitle: 'Switch to dark theme',
                trailing: _toggle(_darkMode, (v) => setState(() => _darkMode = v)),
                showDivider: false,
              ),
            ]),
          ),

          // ── Privacy ───────────────────────────────────
          const AppSectionLabel(label: 'Privacy & Security'),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SettingsTile(
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () => _showComingSoon(context, 'Change Password'),
              ),
              SettingsTile(
                icon: Icons.fingerprint,
                iconColor: AppColors.green,
                title: 'Biometric Login',
                subtitle: 'Use fingerprint or Face ID',
                onTap: () => _showComingSoon(context, 'Biometric Login'),
              ),
              SettingsTile(
                icon: Icons.share_outlined,
                iconColor: AppColors.orange,
                title: 'Share Usage Data',
                subtitle: 'Help us improve the app',
                trailing: _toggle(_shareData, (v) => setState(() => _shareData = v)),
              ),
              SettingsTile(
                icon: Icons.location_on_outlined,
                iconColor: AppColors.error,
                title: 'Location Services',
                subtitle: 'Used for nearby airports',
                trailing: _toggle(_locationServices, (v) => setState(() => _locationServices = v)),
                showDivider: false,
              ),
            ]),
          ),

          // ── Account ───────────────────────────────────
          const AppSectionLabel(label: 'Account'),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SettingsTile(
                icon: Icons.delete_outline,
                iconColor: AppColors.error,
                title: 'Delete Account',
                subtitle: 'Permanently remove your data',
                onTap: () => _showDeleteAccountDialog(context),
              ),
              SettingsTile(
                icon: Icons.info_outline,
                iconColor: AppColors.textSecondary,
                title: 'App Version',
                subtitle: 'SkyTrip v1.0.0',
                trailing: const SizedBox.shrink(),
                showDivider: false,
              ),
            ]),
          ),

          // Save button
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings saved'),
                    backgroundColor: AppColors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Save Settings'),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────

  Widget _toggle(bool value, ValueChanged<bool> onChanged) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.cyan,
    );
  }

  void _showPickerSheet({
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: AppRadius.full,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: AppTextStyles.titleMedium),
          ),
          const Divider(height: 1),
          ...options.map((opt) => ListTile(
            title: Text(opt),
            trailing: opt == selected
                ? const Icon(Icons.check, color: AppColors.cyan)
                : null,
            onTap: () {
              onSelect(opt);
              Navigator.pop(ctx);
            },
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature: Coming in Phase 6'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(children: [
          Icon(Icons.warning_rounded, color: AppColors.error),
          SizedBox(width: 8),
          Text('Delete Account'),
        ]),
        content: const Text(
          'This will permanently delete your account and all associated data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion: TODO in Phase 6'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
