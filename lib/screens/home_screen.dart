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
                _DestCard(city: 'Dubai',  imagePath: 'lib/assets/cites_images/dubai.jpg'),
                _DestCard(city: 'London', imagePath: 'lib/assets/cites_images/london.jpg'),
                _DestCard(city: 'Paris',  imagePath: 'lib/assets/cites_images/paris.jpg'),
                _DestCard(city: 'Cairo',  imagePath: 'lib/assets/cites_images/cairo.jpg'),
                _DestCard(city: 'Riyadh', imagePath: 'lib/assets/cites_images/riyadh.jpg'),
                _DestCard(city: 'Amman',  imagePath: 'lib/assets/cites_images/amman.jpg'),
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
  final String imagePath;

  const _DestCard({required this.city, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: AppRadius.md,
        boxShadow: AppShadows.sm,
      ),
      child: ClipRRect(
        borderRadius: AppRadius.md,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
            ),
            Positioned(
              bottom: 10, left: 10,
              child: Text(
                city,
                style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
