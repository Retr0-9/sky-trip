import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import '../widgets/offer_card.dart';
import '../widgets/section_header.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onBookNow;
  const HomeScreen({super.key, this.onBookNow});

  static const _offers = [
    _OfferData('Summer Sale', 'Up to 30% off on select routes', '30%', 'Aug 31, 2026', AppColors.cyan),
    _OfferData('Early Bird', 'Book 60 days ahead & save', '20%', 'Dec 31, 2026', AppColors.purple),
    _OfferData('Weekend Escape', 'Special fares every Friday', '15%', 'Ongoing', AppColors.orange),
  ];

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
                style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              l10n.homeReady,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
          ),

          // ── Hero CTA ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.cyan, AppColors.cyanDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppShadows.md,
              ),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('Ready to fly?',
                      style: TextStyle(color: Colors.white, fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(l10n.bookingSubtitle,
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: onBookNow,
                    icon: const Icon(Icons.search, size: 16),
                    label: Text(l10n.bookingSearch),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.cyanDark,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ])),
                const SizedBox(width: 12),
                const Icon(Icons.flight_takeoff, color: Colors.white, size: 56),
              ]),
            ),
          ),

          const SizedBox(height: 24),

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
          ..._offers.map((o) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: OfferCard(
              title: o.title,
              subtitle: o.subtitle,
              discount: o.discount,
              validUntil: o.validUntil,
              color: o.color,
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

class _OfferData {
  final String title, subtitle, discount, validUntil;
  final Color color;
  const _OfferData(this.title, this.subtitle, this.discount, this.validUntil, this.color);
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
              child: Text(city,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
            ),
          ],
        ),
      ),
    );
  }
}
