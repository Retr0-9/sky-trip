import 'package:flutter/material.dart';

/// A promotional offer card shown on the Home screen.
/// Usage: OfferCard(title: 'Summer Sale', subtitle: 'Book flights to Europe',
///   discount: '30% OFF', validUntil: 'Dec 31, 2025', color: Colors.orange)
class OfferCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String discount;
  final String validUntil;
  final Color? color; // optional, fallback to theme
  final VoidCallback? onTap;

  const OfferCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.validUntil,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final cardColor = color ?? colorScheme.primary;
    final textColor = colorScheme.onPrimary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Discount Badge Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: textColor.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    discount,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Subtitle
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: textColor.withOpacity(0.9),
              ),
            ),

            const SizedBox(height: 10),

            // Valid Until
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 12,
                  color: textColor.withOpacity(0.8),
                ),
                const SizedBox(width: 6),
                Text(
                  'Valid until $validUntil',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    color: textColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}