import 'package:flutter/material.dart';
import '../widgets/offer_card.dart';
import '../widgets/recent_search_card.dart';
import '../widgets/section_header.dart';
import '../data/dummy_offers.dart';
import '../data/dummy_recent_searches.dart';
import '../models/booking_search_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  IconData _getGreetingIcon() {
    final hour = DateTime.now().hour;
    if (hour < 12) return Icons.wb_sunny;
    if (hour < 17) return Icons.wb_sunny_outlined;
    return Icons.nights_stay_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGreetingHeader(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  title: 'Recent Searches',
                  icon: Icons.history,
                  onSeeAll: () {},
                ),
                const SizedBox(height: 12),
                _buildRecentSearches(context),
                const SizedBox(height: 24),
                SectionHeader(
                  title: 'Latest Offers',
                  icon: Icons.trending_up,
                  onSeeAll: () {},
                ),
                const SizedBox(height: 12),
                _buildOffers(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_getGreetingIcon(), color: Colors.orange, size: 20),
              const SizedBox(width: 8),
              Text(
                '${_getGreeting()}, User', // TODO: Replace 'User' with real name
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
    final searches = DummyRecentSearches.searches;

    if (searches.isEmpty) {
      return Center(
        child: Text(
          'No recent searches',
          style: TextStyle(color: Colors.grey.shade500),
        ),
      );
    }

    return Column(
      children: searches.map((search) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: RecentSearchCard(
            from: search.fromCode,
            to: search.toCode,
            passengers: search.totalPassengers,
            onTap: () {
              // TODO: Pre-fill booking form with this search in Phase 5
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Re-search ${search.fromCode}→${search.toCode}: TODO Phase 5'),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOffers() {
    final offers = DummyOffers.offers;
    return Column(
      children: offers.map((offer) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: OfferCard(
            title: offer.title,
            subtitle: offer.subtitle,
            discount: offer.discount,
            validUntil: offer.validUntil,
            color: offer.color,
            onTap: () {},
          ),
        );
      }).toList(),
    );
  }
}
