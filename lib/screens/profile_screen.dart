import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return SingleChildScrollView(
      child: Column(children: [
        _buildHero(context, user),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            // Personal Information
            const AppSectionLabel(label: 'Personal Information'),
            AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                SettingsTile(
                  icon: Icons.person_outline,
                  title: 'Full Name',
                  subtitle: user.fullName,
                  onTap: () => _editField(context, 'Full Name', user.fullName, (v) {
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
                  onTap: () => _editField(context, 'Email', user.email,
                      (v) => user.updateProfile(email: v)),
                ),
                SettingsTile(
                  icon: Icons.phone_outlined,
                  iconColor: AppColors.green,
                  title: 'Phone',
                  subtitle: user.phone,
                  onTap: () => _editField(context, 'Phone', user.phone,
                      (v) => user.updateProfile(phone: v)),
                ),
                SettingsTile(
                  icon: Icons.public,
                  iconColor: AppColors.purple,
                  title: 'Nationality',
                  subtitle: user.nationality,
                  onTap: () => _showNationalityPicker(context, user),
                  showDivider: false,
                ),
              ]),
            ),

            // Travel Documents
            const AppSectionLabel(label: 'Travel Documents'),
            AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                SettingsTile(
                  icon: Icons.badge_outlined,
                  title: 'Passport Number',
                  subtitle: user.passportNumber,
                  onTap: () => _editField(context, 'Passport Number',
                      user.passportNumber,
                      (v) => user.updateProfile(passportNumber: v)),
                ),
                SettingsTile(
                  icon: Icons.airline_seat_recline_normal,
                  iconColor: AppColors.cyan,
                  title: 'Preferred Class',
                  subtitle: user.preferredClass,
                  onTap: () => _showClassPicker(context, user),
                  showDivider: false,
                ),
              ]),
            ),

            // Loyalty Program
            const AppSectionLabel(label: 'Frequent Flyer'),
            _buildLoyaltyCard(user),

            // Stats
            const AppSectionLabel(label: 'Travel Stats'),
            _buildStatsGrid(),

            const SizedBox(height: 24),
          ]),
        ),
      ]),
    );
  }

  // ── Hero Header ─────────────────────────────────────────
  Widget _buildHero(BuildContext context, UserProvider user) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
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
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Text(
              _initials(user.fullName),
              style: const TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 0, right: 0,
            child: GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Photo upload: Coming in Phase 6'),
                    behavior: SnackBarBehavior.floating),
              ),
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

  // ── Loyalty Card ────────────────────────────────────────
  Widget _buildLoyaltyCard(UserProvider user) {
    final tierColors = {
      'Silver': [const Color(0xFF78909C), const Color(0xFF546E7A)],
      'Gold':   [AppColors.gold, const Color(0xFFFF8F00)],
      'Platinum': [const Color(0xFF7C4DFF), const Color(0xFF5C35CC)],
    };
    final colors = tierColors[user.loyaltyTier] ??
        [AppColors.textSecondary, AppColors.textPrimary];

    return AppCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: AppRadius.full,
            ),
            child: Row(children: [
              const Icon(Icons.star, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text('${user.loyaltyTier} Member',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700)),
            ]),
          ),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('${_formatMiles(user.milesBalance)} miles',
                style: AppTextStyles.titleMedium.copyWith(color: colors[0])),
            Text('available balance', style: AppTextStyles.bodySmall),
          ]),
        ]),
        const SizedBox(height: 14),

        // Progress to next tier
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Progress to ${_nextTier(user.loyaltyTier)}',
              style: AppTextStyles.bodySmall),
          Text('${_formatMiles(user.milesBalance)} / ${_tierTarget(user.loyaltyTier)} miles',
              style: AppTextStyles.bodySmall),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: AppRadius.full,
          child: LinearProgressIndicator(
            value: user.milesBalance / _tierTargetNum(user.loyaltyTier),
            backgroundColor: AppColors.border,
            color: colors[0],
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 8),
        Text('Loyalty #: ${user.loyaltyNumber}',
            style: AppTextStyles.bodySmall),
      ]),
    );
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
  void _editField(BuildContext context, String label, String current,
      ValueChanged<String> onSave) {
    final ctrl = TextEditingController(text: current);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Edit $label'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: InputDecoration(labelText: label),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                onSave(ctrl.text.trim());
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('$label updated'),
                  backgroundColor: AppColors.green,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showNationalityPicker(BuildContext context, UserProvider user) {
    const nationalities = ['Jordanian', 'Emirati', 'Saudi', 'British', 'American', 'German', 'French'];
    showModalBottomSheet(
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

  void _showClassPicker(BuildContext context, UserProvider user) {
    const classes = ['Economy', 'Business', 'First Class'];
    showModalBottomSheet(
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

  String _formatMiles(int miles) {
    if (miles >= 1000) return '${(miles / 1000).toStringAsFixed(1)}K';
    return '$miles';
  }

  String _nextTier(String tier) {
    const next = {'Silver': 'Gold', 'Gold': 'Platinum', 'Platinum': 'Platinum'};
    return next[tier] ?? 'Gold';
  }

  String _tierTarget(String tier) {
    const targets = {'Silver': '25K', 'Gold': '50K', 'Platinum': '100K'};
    return targets[tier] ?? '25K';
  }

  int _tierTargetNum(String tier) {
    const targets = {'Silver': 25000, 'Gold': 50000, 'Platinum': 100000};
    return targets[tier] ?? 25000;
  }
}

class _Stat {
  final IconData icon;
  final String value, label;
  final Color color;
  const _Stat(this.icon, this.value, this.label, this.color);
}
