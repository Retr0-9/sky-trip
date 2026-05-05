import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
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

  // Display settings (with codes for backend)
  late String _languageCode;
  late String _currencyCode;
  bool _shareData        = false;

  // Language and Currency mappings
  final Map<String, String> _languageCodes = {
    'English': 'en',
    'Arabic': 'ar',
    'French': 'fr',
    'German': 'de',
    'Spanish': 'es',
  };

  final Map<String, String> _currencyCodes = {
    'JOD – Jordanian Dinar': 'JOD',
    'USD – US Dollar': 'USD',
    'EUR – Euro': 'EUR',
    'GBP – British Pound': 'GBP',
    'AED – UAE Dirham': 'AED',
  };

  // Reverse mappings for display
  late Map<String, String> _codeToLanguage;
  late Map<String, String> _codeToCurrency;

  final List<String> _languages = [
    'English', 'Arabic', 'French', 'German', 'Spanish',
  ];
  
  final List<String> _currencies = [
    'JOD – Jordanian Dinar', 'USD – US Dollar',
    'EUR – Euro', 'GBP – British Pound', 'AED – UAE Dirham',
  ];

  @override
  void initState() {
    super.initState();
    _initializeReverseMappings();
    _loadCurrentSettings();
  }

  void _initializeReverseMappings() {
    _codeToLanguage = _languageCodes.map((k, v) => MapEntry(v, k));
    _codeToCurrency = _currencyCodes.map((k, v) => MapEntry(v, k));
  }

  void _loadCurrentSettings() {
    final userProvider = context.read<UserProvider>();
    
    _languageCode = userProvider.locale.languageCode;
    _currencyCode = userProvider.currency;
    
    // Set default selected items for display
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final isDark = context.watch<UserProvider>().themeMode == ThemeMode.dark;
    final l10n = AppLocalizations.of(context)!;

    String languageDisplay = _codeToLanguage[_languageCode] ?? 'English';
    String currencyDisplay = _codeToCurrency[_currencyCode] ?? 'JOD – Jordanian Dinar';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          // ── Notifications ─────────────────────────────
          AppSectionLabel(label: l10n.settingsNotifications),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SettingsTile(
                icon: Icons.flight_takeoff,
                title: l10n.settingsFlightUpdates,
                subtitle: l10n.settingsFlightUpdatesDesc,
                trailing: _toggle(_flightUpdates, (v) => setState(() => _flightUpdates = v)),
              ),
              SettingsTile(
                icon: Icons.trending_down,
                iconColor: AppColors.green,
                title: l10n.settingsPriceAlerts,
                subtitle: l10n.settingsPriceAlertsDesc,
                trailing: _toggle(_priceAlerts, (v) => setState(() => _priceAlerts = v)),
              ),
              SettingsTile(
                icon: Icons.notifications_active_outlined,
                iconColor: AppColors.orange,
                title: l10n.settingsBookingReminders,
                subtitle: l10n.settingsBookingRemindersDesc,
                trailing: _toggle(_bookingReminders, (v) => setState(() => _bookingReminders = v)),
              ),
              SettingsTile(
                icon: Icons.local_offer_outlined,
                iconColor: AppColors.purple,
                title: l10n.settingsPromotions,
                subtitle: l10n.settingsPromotionsDesc,
                trailing: _toggle(_promotions, (v) => setState(() => _promotions = v)),
              ),
              SettingsTile(
                icon: Icons.sms_outlined,
                iconColor: AppColors.gold,
                title: l10n.settingsSmsAlerts,
                subtitle: l10n.settingsSmsAlertsDesc,
                trailing: _toggle(_smsAlerts, (v) => setState(() => _smsAlerts = v)),
                showDivider: false,
              ),
            ]),
          ),

          // ── Display ───────────────────────────────────
          AppSectionLabel(label: l10n.settingsDisplay),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SettingsTile(
                icon: Icons.language,
                title: l10n.settingsLanguage,
                subtitle: languageDisplay,
                onTap: () => _showLanguagePicker(context),
              ),
              SettingsTile(
                icon: Icons.attach_money,
                iconColor: AppColors.green,
                title: l10n.settingsCurrency,
                subtitle: currencyDisplay,
                onTap: () => _showCurrencyPicker(context),
              ),
              SettingsTile(
                icon: Icons.dark_mode_outlined,
                iconColor: AppColors.purple,
                title: l10n.settingsDarkMode,
                subtitle: l10n.settingsDarkModeDesc,
                trailing: Switch(
                  value: isDark,
                  onChanged: (v) => context.read<UserProvider>().toggleTheme(v),
                  activeColor: AppColors.cyan,
                ),
                showDivider: false,
              ),
            ]),
          ),

          // ── Privacy ───────────────────────────────────
          AppSectionLabel(label: l10n.settingsPrivacy),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SettingsTile(
                icon: Icons.lock_outline,
                title: l10n.settingsChangePassword,
                onTap: () => _showComingSoon(context, l10n.settingsChangePassword),
              ),
              SettingsTile(
                icon: Icons.fingerprint,
                iconColor: AppColors.green,
                title: l10n.settingsBiometric,
                subtitle: l10n.settingsBiometricDesc,
                onTap: () => _showComingSoon(context, l10n.settingsBiometric),
              ),
              SettingsTile(
                icon: Icons.share_outlined,
                iconColor: AppColors.orange,
                title: l10n.settingsShareData,
                subtitle: l10n.settingsShareDataDesc,
                trailing: _toggle(_shareData, (v) => setState(() => _shareData = v)),
                showDivider: false,
              ),
            ]),
          ),

          // ── Account ───────────────────────────────────
          AppSectionLabel(label: l10n.settingsAccount),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              SettingsTile(
                icon: Icons.delete_outline,
                iconColor: AppColors.error,
                title: l10n.settingsDeleteAccount,
                subtitle: l10n.settingsDeleteAccountDesc,
                onTap: () => _showDeleteAccountDialog(context),
              ),
              SettingsTile(
                icon: Icons.info_outline,
                iconColor: theme.iconTheme.color,
                title: l10n.settingsAppVersion,
                subtitle: l10n.appVersion,
                trailing: const SizedBox.shrink(),
                showDivider: false,
              ),
            ]),
          ),

          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ElevatedButton(
              onPressed: () => _saveAllSettings(context),
              child: Text(AppLocalizations.of(context)!.settingsSave),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveAllSettings(BuildContext context) async {
    final userProvider = context.read<UserProvider>();
    
    try {
      // Save language
      await userProvider.changeLanguage(_languageCode);
      
      // Save currency
      await userProvider.setCurrency(_currencyCode);
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.settingsSaved),
          backgroundColor: AppColors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.settingsErrorSaving(e.toString())),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showPickerSheet({
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelect,
  }) {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              color: theme.dividerColor,
              borderRadius: AppRadius.full,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: theme.textTheme.titleMedium),
          ),
          const Divider(height: 1),
          ...options.map((opt) => ListTile(
            title: Text(opt, style: theme.textTheme.bodyMedium),
            trailing: opt == selected
                ? Icon(Icons.check, color: AppColors.cyan)
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

  void _showLanguagePicker(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selected = _codeToLanguage[_languageCode] ?? 'English';
    _showPickerSheet(
      title: l10n.settingsSelectLanguage,
      options: _languages,
      selected: selected,
      onSelect: (value) {
        setState(() => _languageCode = _languageCodes[value] ?? 'en');
      },
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selected = _codeToCurrency[_currencyCode] ?? 'JOD – Jordanian Dinar';
    _showPickerSheet(
      title: l10n.settingsSelectCurrency,
      options: _currencies,
      selected: selected,
      onSelect: (value) {
        setState(() => _currencyCode = _currencyCodes[value] ?? 'JOD');
      },
    );
  }

  Widget _toggle(bool value, ValueChanged<bool> onChanged) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.cyan,
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.settingsFeatureComing(feature)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: theme.cardColor,
        title: Row(children: [
          const Icon(Icons.warning_rounded, color: AppColors.error),
          const SizedBox(width: 8),
          Text(l10n.settingsDeleteAccount, style: theme.textTheme.titleMedium),
        ]),
        content: Text(
          l10n.settingsDeleteAccountDesc,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.dialogCancel, style: theme.textTheme.labelLarge),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.settingsAccountDeletion),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(l10n.dialogDeleteAccount, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}