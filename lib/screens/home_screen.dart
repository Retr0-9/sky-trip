import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import '../widgets/offer_card.dart';
import '../widgets/recent_search_card.dart';
import '../widgets/section_header.dart';
import '../data/dummy_offers.dart';
import '../data/dummy_recent_searches.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>();
    final l10n = AppLocalizations.of(context)!;
    final hour = DateTime.now().hour;
    final icon = hour < 12 ? Icons.wb_sunny : hour < 17 ? Icons.wb_sunny_outlined : Icons.nights_stay_outlined;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Greeting ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Row(children: [
              Icon(icon, color: AppColors.orange, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n.homeGreeting(user.greeting, user.firstName),
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              l10n.homeReady,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),

          // ── Recent Searches ──────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SectionHeader(
              title: l10n.homeRecentSearches,
              icon: Icons.history,
              onSeeAll: () {},
            ),
          ),
          const SizedBox(height: 10),
          ...DummyRecentSearches.searches.map((search) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: RecentSearchCard(
              from: search.fromCode,
              to: search.toCode,
              passengers: search.totalPassengers,
              onTap: () {},
            ),
          )),

          const SizedBox(height: 8),

          // ── Latest Offers ───────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SectionHeader(
              title: l10n.homeLatestOffers,
              icon: Icons.trending_up,
              onSeeAll: () {},
            ),
          ),
          const SizedBox(height: 10),
          ...DummyOffers.offers.map((offer) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: OfferCard(
              title: offer.title,
              subtitle: offer.subtitle,
              discount: offer.discount,
              validUntil: offer.validUntil,
              color: offer.color,
              onTap: () {},
            ),
          )),

          const SizedBox(height: 8),

          // ── Featured Destinations ───────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SectionHeader(
              title: l10n.homeFeaturedDestinations,
              icon: Icons.star_border,
              onSeeAll: () {},
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                _DestCard(city: 'Dubai', emoji: '🏙️', color: Color(0xFF5BB8C8)),
                _DestCard(city: 'London', emoji: '🎡', color: Color(0xFF7C9CBF)),
                _DestCard(city: 'Paris', emoji: '🗼', color: Color(0xFF9B8EA8)),
                _DestCard(city: 'Cairo', emoji: '🏛️', color: Color(0xFFC4956A)),
                _DestCard(city: 'Istanbul', emoji: '🕌', color: Color(0xFF7EB5A0)),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _DestCard extends StatelessWidget {
  final String city;
  final String emoji;
  final Color color;

  const _DestCard({required this.city, required this.emoji, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: AppRadius.md,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.7)],
        ),
        boxShadow: AppShadows.sm,
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10, right: 10,
            child: Text(emoji, style: const TextStyle(fontSize: 36)),
          ),
          Positioned(
            bottom: 12, left: 12,
            child: Text(
              city,
              style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
