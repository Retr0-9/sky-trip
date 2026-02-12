import 'package:flutter/material.dart';

/// A card showing a recent flight search on the Home screen.
/// Usage: RecentSearchCard(from: 'AMM', to: 'DXB', passengers: 1)
class RecentSearchCard extends StatelessWidget {
  final String from;
  final String to;
  final int passengers;
  final VoidCallback? onTap;

  const RecentSearchCard({
    super.key,
    required this.from,
    required this.to,
    required this.passengers,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        child: Row(
          children: [
            // Flight Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.flight, color: Colors.cyan, size: 22),
            ),
            const SizedBox(width: 14),

            // Route and Passengers
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route
                  Row(
                    children: [
                      Text(
                        from,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.arrow_forward, size: 14, color: Colors.grey),
                      ),
                      Text(
                        to,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Passengers
                  Text(
                    '• $passengers passenger${passengers > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
