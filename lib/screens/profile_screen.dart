import 'package:flutter/material.dart';
import '../widgets/info_row.dart';
import '../widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Profile Header
          _buildProfileHeader(),

          const SizedBox(height: 8),

          // Personal Info Section
          _buildSection(
            title: 'Personal Information',
            icon: Icons.person_outline,
            children: [
              InfoRow(
                icon: Icons.person,
                label: 'Full Name',
                value: 'John Doe',
                onTap: () {
                  // TODO: Navigate to edit profile
                },
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: 'john.doe@email.com',
                onTap: () {},
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: '+962 79 123 4567',
                onTap: () {},
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.cake_outlined,
                label: 'Date of Birth',
                value: 'Jan 15, 1990',
                onTap: () {},
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.public,
                label: 'Nationality',
                value: 'Jordanian',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Travel Documents Section
          _buildSection(
            title: 'Travel Documents',
            icon: Icons.badge_outlined,
            children: [
              InfoRow(
                icon: Icons.badge,
                label: 'Passport Number',
                value: 'A12345678',
                onTap: () {},
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.calendar_today,
                label: 'Passport Expiry',
                value: 'Dec 31, 2028',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Preferences Section
          _buildSection(
            title: 'Preferences',
            icon: Icons.tune,
            children: [
              InfoRow(
                icon: Icons.airline_seat_recline_normal,
                label: 'Preferred Class',
                value: 'Economy',
                onTap: () {},
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.restaurant_outlined,
                label: 'Meal Preference',
                value: 'Standard',
                onTap: () {},
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.language,
                label: 'Language',
                value: 'English',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Frequent Flyer Section
          _buildSection(
            title: 'Frequent Flyer',
            icon: Icons.card_membership,
            children: [
              InfoRow(
                icon: Icons.confirmation_number_outlined,
                label: 'Loyalty Number',
                value: 'RJ-9876543',
                onTap: () {},
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.star_outline,
                label: 'Tier Status',
                value: 'Silver',
                onTap: () {},
              ),
              const Divider(height: 24),
              InfoRow(
                icon: Icons.airplane_ticket_outlined,
                label: 'Miles Balance',
                value: '12,450 miles',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ==================== SECTION BUILDERS ====================

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
      ),
      child: Column(
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 48,
                backgroundColor: Colors.cyan.shade100,
                child: const Icon(Icons.person, size: 48, color: Colors.cyan),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.cyan,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          // Email
          Text(
            'john.doe@email.com',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 16),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('5', 'Flights'),
              Container(width: 1, height: 32, color: Colors.grey.shade300),
              _buildStatItem('12,450', 'Miles'),
              Container(width: 1, height: 32, color: Colors.grey.shade300),
              _buildStatItem('Silver', 'Tier'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
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

