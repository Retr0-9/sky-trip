import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import '../providers/user_provider.dart';
import '../services/profile_service.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _localImage;
  bool _uploading = false;

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: Theme.of(ctx).colorScheme.outlineVariant,
                borderRadius: AppRadius.full,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Profile Photo', style: AppTextStyles.titleMedium),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.cyan),
              title: const Text('Take a Photo'),
              onTap: () { Navigator.pop(ctx); _pickImage(ImageSource.camera); },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: AppColors.cyan),
              title: const Text('Choose from Gallery'),
              onTap: () { Navigator.pop(ctx); _pickImage(ImageSource.gallery); },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      final status = await Permission.camera.request();
      if (!mounted) return;
      if (status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Camera permission permanently denied. Enable it in Settings.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Settings',
            textColor: Colors.white,
            onPressed: openAppSettings,
          ),
        ));
        return;
      }
      if (!status.isGranted) return;
    }

    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 512,
    );
    if (picked == null || !mounted) return;

    final file = File(picked.path);
    setState(() { _localImage = file; _uploading = true; });

    try {
      final token = context.read<UserProvider>().token;
      await ProfileService.uploadAvatar(image: file, token: token);
      if (!mounted) return;
      setState(() => _uploading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Profile photo updated'),
        backgroundColor: AppColors.green,
        behavior: SnackBarBehavior.floating,
      ));
    } on AuthException catch (e) {
      if (!mounted) return;
      setState(() => _uploading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ));
    } catch (_) {
      if (!mounted) return;
      setState(() => _uploading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Could not upload photo. Please try again.'),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Column(children: [
        _buildHero(user),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            // Personal Information
            AppSectionLabel(label: l10n.profilePersonalInfo),
            AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                SettingsTile(
                  icon: Icons.person_outline,
                  title: 'Full Name',
                  subtitle: user.fullName,
                  onTap: () => _editField('Full Name', user.fullName, (v) {
                    final parts = v.trim().split(' ');
                    user.updateProfile(
                      firstName: parts.first,
                      lastName: parts.length > 1 ? parts.sublist(1).join(' ') : '',
                    );
                  }),
                ),
                SettingsTile(
                  icon: Icons.email_outlined,
                  iconColor: AppColors.orange,
                  title: 'Email',
                  subtitle: user.email,
                  onTap: () => _editField('Email', user.email,
                      (v) => user.updateProfile(email: v)),
                ),
                SettingsTile(
                  icon: Icons.phone_outlined,
                  iconColor: AppColors.green,
                  title: 'Phone',
                  subtitle: user.phone,
                  onTap: () => _editField('Phone', user.phone,
                      (v) => user.updateProfile(phone: v)),
                ),
                SettingsTile(
                  icon: Icons.public,
                  iconColor: AppColors.purple,
                  title: 'Nationality',
                  subtitle: user.nationality,
                  onTap: () => _showNationalityPicker(user),
                  showDivider: false,
                ),
              ]),
            ),

            // Travel Documents
            AppSectionLabel(label: l10n.profileTravelDocs),
            AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                SettingsTile(
                  icon: Icons.badge_outlined,
                  title: 'Passport Number',
                  subtitle: user.passportNumber,
                  onTap: () => _editField('Passport Number',
                      user.passportNumber,
                      (v) => user.updateProfile(passportNumber: v)),
                ),
                SettingsTile(
                  icon: Icons.airline_seat_recline_normal,
                  iconColor: AppColors.cyan,
                  title: 'Preferred Class',
                  subtitle: user.preferredClass,
                  onTap: () => _showClassPicker(user),
                  showDivider: false,
                ),
              ]),
            ),

            // Stats
            AppSectionLabel(label: l10n.profileStats),
            _buildStatsGrid(),

            const SizedBox(height: 24),
          ]),
        ),
      ]),
    );
  }

  // ── Hero Header ─────────────────────────────────────────
  Widget _buildHero(UserProvider user) {
    ImageProvider? avatarImage;
    if (_localImage != null) {
      avatarImage = FileImage(_localImage!);
    } else if (user.profileImageUrl != null) {
      avatarImage = NetworkImage(user.profileImageUrl!);
    }

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.cyan, AppColors.cyanDark],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(children: [
        // Avatar
        Stack(children: [
          CircleAvatar(
            radius: 46,
            backgroundColor: Colors.white24,
            backgroundImage: avatarImage,
            child: avatarImage == null
                ? Text(
                    _initials(user.fullName),
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
                  )
                : _uploading
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : null,
          ),
          Positioned(
            bottom: 0, right: 0,
            child: GestureDetector(
              onTap: _showImageOptions,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.orange, shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
              ),
            ),
          ),
        ]),
        const SizedBox(height: 12),

        Text(user.fullName, style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
        const SizedBox(height: 2),
        Text(user.email, style: TextStyle(
            fontSize: 13, color: Colors.white.withOpacity(0.8))),
        const SizedBox(height: 16),

        // Quick stats row
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _heroStat('5', 'Flights'),
          _heroDivider(),
          _heroStat('${(user.milesBalance / 1000).toStringAsFixed(1)}K', 'Miles'),
          _heroDivider(),
          _heroStat(user.loyaltyTier, 'Tier'),
        ]),
      ]),
    );
  }

  Widget _heroStat(String value, String label) {
    return Column(children: [
      Text(value, style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
      const SizedBox(height: 2),
      Text(label, style: TextStyle(
          fontSize: 11, color: Colors.white.withOpacity(0.75))),
    ]);
  }

  Widget _heroDivider() {
    return Container(width: 1, height: 32,
        color: Colors.white.withOpacity(0.25));
  }

  // ── Stats Grid ──────────────────────────────────────────
  Widget _buildStatsGrid() {
    final stats = [
      _Stat(Icons.flight_takeoff, '5', 'Total Flights', AppColors.cyan),
      _Stat(Icons.public, '8', 'Countries', AppColors.purple),
      _Stat(Icons.star, '3', 'Reviews', AppColors.gold),
      _Stat(Icons.card_giftcard, '2', 'Rewards', AppColors.orange),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10, crossAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: stats.map((s) => AppCard(
        child: Row(children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: s.color.withOpacity(0.1), borderRadius: AppRadius.sm,
            ),
            child: Icon(s.icon, color: s.color, size: 22),
          ),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s.value, style: AppTextStyles.titleLarge.copyWith(color: s.color)),
            Text(s.label, style: AppTextStyles.bodySmall),
          ]),
        ]),
      )).toList(),
    );
  }

  // ── Edit Dialog ─────────────────────────────────────────
  void _editField(String label, String current, ValueChanged<String> onSave) {
    final ctrl = TextEditingController(text: current);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        // ── Dynamic: background follows theme surface ──
        backgroundColor: Theme.of(ctx).colorScheme.surface,  // was: implicit white
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(AppLocalizations.of(ctx)!.profileEditLabel(label)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(AppLocalizations.of(context)!.dialogCancel)),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                onSave(ctrl.text.trim());
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(AppLocalizations.of(context)!.profileLabelUpdated(label)),
                  backgroundColor: AppColors.green,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            child: Text(AppLocalizations.of(ctx)!.profileSave),
          ),
        ],
      ),
    );
  }

  void _showNationalityPicker(UserProvider user) {
    const nationalities = ['Jordanian', 'Emirati', 'Saudi', 'British', 'American', 'German', 'French'];
    showModalBottomSheet(
      context: context,
      // ── Dynamic: sheet background follows theme surface ──
      backgroundColor: Theme.of(context).colorScheme.surface,  // was: AppColors.surface
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              // ── Dynamic: drag handle follows theme outline ──
              color: Theme.of(ctx).colorScheme.outlineVariant,  // was: AppColors.border
              borderRadius: AppRadius.full,
            ),
          ),
          const Padding(padding: EdgeInsets.all(16),
              child: Text('Select Nationality', style: AppTextStyles.titleMedium)),
          const Divider(height: 1),
          ...nationalities.map((n) => ListTile(
            title: Text(n),
            trailing: n == user.nationality ? const Icon(Icons.check, color: AppColors.cyan) : null,
            onTap: () {
              user.updateProfile(nationality: n);
              Navigator.pop(ctx);
            },
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showClassPicker(UserProvider user) {
    const classes = ['Economy', 'Business', 'First Class'];
    showModalBottomSheet(
      context: context,
      // ── Dynamic: sheet background follows theme surface ──
      backgroundColor: Theme.of(context).colorScheme.surface,  // was: AppColors.surface
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
              // ── Dynamic: drag handle follows theme outline ──
              color: Theme.of(ctx).colorScheme.outlineVariant,  // was: AppColors.border
              borderRadius: AppRadius.full,
            ),
          ),
          const Padding(padding: EdgeInsets.all(16),
              child: Text('Preferred Class', style: AppTextStyles.titleMedium)),
          const Divider(height: 1),
          ...classes.map((c) => ListTile(
            leading: Icon(
              c == 'Economy' ? Icons.airline_seat_recline_normal
                  : c == 'Business' ? Icons.business_center : Icons.star,
              color: AppColors.cyan,
            ),
            title: Text(c),
            trailing: c == user.preferredClass ? const Icon(Icons.check, color: AppColors.cyan) : null,
            onTap: () {
              user.updateProfile(preferredClass: c);
              Navigator.pop(ctx);
            },
          )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ── Utilities ───────────────────────────────────────────
  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

}

class _Stat {
  final IconData icon;
  final String value, label;
  final Color color;
  const _Stat(this.icon, this.value, this.label, this.color);
}