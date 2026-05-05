import 'package:flutter/material.dart';

enum TicketStatus { upcoming, completed, cancelled }

/// A boarding-pass styled ticket card for the Tickets screen.
class TicketCard extends StatelessWidget {
  final String from;
  final String fromCity;
  final String to;
  final String toCity;
  final String date;
  final String time;
  final String flightNumber;
  final String seatNumber;
  final TicketStatus status;
  final IconData icon;
  final VoidCallback? onTap;

  const TicketCard({
    super.key,
    required this.from,
    required this.fromCity,
    required this.to,
    required this.toCity,
    required this.date,
    required this.time,
    required this.flightNumber,
    required this.seatNumber,
    required this.status,
    required this.icon,
    this.onTap,
  });

  Color get _statusColor {
    switch (status) {
      case TicketStatus.upcoming:
        return Colors.cyan;
      case TicketStatus.completed:
        return Colors.green;
      case TicketStatus.cancelled:
        return Colors.red;
    }
  }

  String get _statusLabel {
    switch (status) {
      case TicketStatus.upcoming:
        return 'Upcoming';
      case TicketStatus.completed:
        return 'Completed';
      case TicketStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[850] : Colors.white;
    final tearLineColor = isDark ? Colors.grey[700]! : Colors.grey.shade300;
    final labelColor = isDark ? Colors.grey[400]! : Colors.grey.shade500;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black26 : Colors.grey.shade200,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Section (Cyan header)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        from,
                        style:  TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        fromCity,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                   Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        to,
                        style:  TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        toCity,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tear Line
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: tearLineColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          (constraints.constrainWidth() / 12).floor(),
                          (_) => Container(
                            width: 6,
                            height: 1,
                            color: tearLineColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: tearLineColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),

            // Bottom Section (Ticket details)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailItem('Date', date, labelColor),
                      _buildDetailItem('Time', time, labelColor),
                      _buildDetailItem('Flight', flightNumber, labelColor),
                      _buildDetailItem('Seat', seatNumber, labelColor),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: _statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: _statusColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        _statusLabel,
                        style: TextStyle(
                          fontSize: 12,
                          color: _statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, Color labelColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}