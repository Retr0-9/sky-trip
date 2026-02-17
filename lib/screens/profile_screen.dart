import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/info_row.dart';
import '../widgets/section_header.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileHeader(user),
          const SizedBox(height: 8),
          _buildSection(
            title: 'Personal Information',
            icon: Icons.person_outline,
            children: [
              InfoRow(icon: Icons.person, label: 'Full Name', value: user.fullName, onTap: () {}),
              const Divider(height: 24),
              InfoRow(icon: Icons.email_outlined, label: 'Email', value: user.email, onTap: () {}),
              const Divider(height: 24),
              InfoRow(icon: Icons.phone_outlined, label: 'Phone', value: user.phone, onTap: () {}),
              const Divider(height: 24),
              InfoRow(icon: Icons.public, label: 'Nationality', value: user.nationality, onTap: () {}),
            ],
          ),
          const SizedBox(height: 8),
          _buildSection(
            title: 'Travel Documents',
            icon: Icons.badge_outlined,
            children: [
              InfoRow(icon: Icons.badge, label: 'Passport Number', value: user.passportNumber, onTap: () {}),
            ],
          ),
          const SizedBox(height: 8),
          _buildSection(
            title: 'Preferences',
            icon: Icons.tune,
            children: [
              InfoRow(icon: Icons.airline_seat_recline_normal, label: 'Preferred Class', value: user.preferredClass, onTap: () {}),
              const Divider(height: 24),
              InfoRow(icon: Icons.language, label: 'Language', value: 'English', onTap: () {}),
            ],
          ),
          const SizedBox(height: 8),
          _buildSection(
            title: 'Frequent Flyer',
            icon: Icons.card_membership,
            children: [
              InfoRow(icon: Icons.confirmation_number_outlined, label: 'Loyalty Number', value: user.loyaltyNumber, onTap: () {}),
              const Divider(height: 24),
              InfoRow(icon: Icons.star_outline, label: 'Tier Status', value: user.loyaltyTier, onTap: () {}),
              const Divider(height: 24),
              InfoRow(icon: Icons.airplane_ticket_outlined, label: 'Miles Balance',
                  value: '${user.milesBalance.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')} miles',
                  onTap: () {}),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(UserProvider user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: Colors.cyan.shade50,
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.cyan.shade100,
                child: const Icon(Icons.person, size: 48, color: Colors.cyan),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: Colors.cyan, shape: BoxShape.circle),
                  child: const Icon(Icons.edit, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(user.fullName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(user.email,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _statItem('5', 'Flights'),
              Container(width: 1, height: 32, color: Colors.grey.shade300),
              _statItem('${user.milesBalance ~/ 1000}K', 'Miles'),
              Container(width: 1, height: 32, color: Colors.grey.shade300),
              _statItem(user.loyaltyTier, 'Tier'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyan)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title, icon: icon),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}
