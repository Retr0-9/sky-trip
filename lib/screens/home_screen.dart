import 'package:flutter/material.dart';
import '../widgets/offer_card.dart';
import '../widgets/recent_search_card.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting Header
          _buildGreetingHeader(),

          // Body Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recent Searches Section
                SectionHeader(
                  title: 'Recent Searches',
                  icon: Icons.history,
                  onSeeAll: () {
                    // TODO: Navigate to full search history in Phase 4
                  },
                ),
                const SizedBox(height: 12),
                _buildRecentSearches(context),

                const SizedBox(height: 24),

                // Latest Offers Section
                SectionHeader(
                  title: 'Latest Offers',
                  icon: Icons.trending_up,
                  onSeeAll: () {
                    // TODO: Navigate to all offers in Phase 4
                  },
                ),
                const SizedBox(height: 12),
                _buildOffers(context),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==================== SECTION BUILDERS ====================

  Widget _buildGreetingHeader() {
    // TODO: Get actual time of day and user name in Phase 4
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.wb_sunny_outlined,
                color: Colors.orange,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Good Evening, User',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Ready for your next adventure?',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSearches(BuildContext context) {
    // TODO: Replace with actual search history from local storage in Phase 4
    return Column(
      children: [
        RecentSearchCard(
          from: 'AMM',
          to: 'DXB',
          passengers: 1,
          onTap: () {
            // TODO: Pre-fill booking form with this search in Phase 4
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Re-search: TODO in Phase 4')),
            );
          },
        ),
        const SizedBox(height: 10),
        RecentSearchCard(
          from: 'AMM',
          to: 'LHR',
          passengers: 2,
          onTap: () {
            // TODO: Pre-fill booking form with this search in Phase 4
          },
        ),
      ],
    );
  }

  Widget _buildOffers(BuildContext context) {
    // TODO: Replace with actual offers from API in Phase 4
    return Column(
      children: [
        OfferCard(
          title: 'Summer Sale',
          subtitle: 'Book flights to Europe',
          discount: '30% OFF',
          validUntil: 'Dec 31, 2025',
          color: Colors.orange.shade400,
          onTap: () {
            // TODO: Navigate to offer details or booking
          },
        ),
        const SizedBox(height: 12),
        OfferCard(
          title: 'Weekend Getaway',
          subtitle: 'Domestic flights',
          discount: '20% OFF',
          validUntil: 'Dec 20, 2025',
          color: Colors.lightBlue.shade300,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        OfferCard(
          title: 'Business Class Upgrade',
          subtitle: 'Selected routes',
          discount: '40% OFF',
          validUntil: 'Dec 15, 2025',
          color: Colors.brown.shade300,
          onTap: () {},
        ),
      ],
    );
  }
}
