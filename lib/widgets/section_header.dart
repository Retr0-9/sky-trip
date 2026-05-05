import 'package:flutter/material.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';

/// A section title with an optional "See All" action.
/// Usage: SectionHeader(title: 'Latest Offers')
/// With action: SectionHeader(title: 'Recent Searches', onSeeAll: () {})
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.icon,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final iconColor = isDark ? Colors.grey[400] : Colors.grey.shade700;
    const seeAllColor = Colors.cyan;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: titleColor,
              ),
            ),
          ],
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            style: TextButton.styleFrom(
              foregroundColor: seeAllColor,
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              AppLocalizations.of(context)!.homeSeeAll ,
              style: const TextStyle(fontSize: 13),
            ),
          ),
      ],
    );
  }
}