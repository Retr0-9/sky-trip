import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/api_ticket_model.dart';
import '../theme/app_theme.dart';

class BoardingPassScreen extends StatelessWidget {
  const BoardingPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final detail =
        ModalRoute.of(context)?.settings.arguments as ApiTicketDetailModel?;

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Boarding Pass'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: detail == null
            ? const Center(child: Text('No boarding pass data.'))
            : _BoardingPassCard(detail: detail),
      ),
    );
  }
}

class _BoardingPassCard extends StatelessWidget {
  final ApiTicketDetailModel detail;
  const _BoardingPassCard({required this.detail});

  @override
  Widget build(BuildContext context) {
    final flight     = detail.flights.isNotEmpty ? detail.flights.first : null;
    final passenger  = detail.passengers.isNotEmpty ? detail.passengers.first : null;
    final pnr        = detail.bookingReference ?? detail.ticketId.toString();
    final from       = flight?.departureCity ?? '--';
    final to         = flight?.arrivalCity   ?? '--';
    final depTime    = _fmtDt(flight?.departureDateTime);
    final depDate    = _fmtDate(flight?.departureDateTime);
    final name       = passenger != null
        ? '${passenger.firstName} ${passenger.lastName}'.toUpperCase()
        : '--';

    // Hardcoded until API provides them
    const seatNumber = '14A';
    const gateNumber = 'B12';
    const travelClass = '--';   // placeholder — backend to provide

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppShadows.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              _buildRouteStrip(from, to, depTime, depDate),
              _buildTearOff(),
              _buildDetailsGrid(pnr, name, seatNumber, gateNumber, travelClass, depDate),
              _buildQrSection(pnr),
            ],
          ),
        ),
      ),
    );
  }

  // ── Cyan header ──────────────────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.cyanDark, AppColors.cyan],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.flight, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 12),
        const Text(
          'SkyTrip',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'BOARDING PASS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ]),
    );
  }

  // ── Route strip ──────────────────────────────────────────────────────────
  Widget _buildRouteStrip(String from, String to, String time, String date) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cityCol(from, 'ORIGIN'),
          Column(
            children: [
              const SizedBox(height: 4),
              const Icon(Icons.flight_takeoff, color: AppColors.cyan, size: 28),
              const SizedBox(height: 6),
              Text(time,
                  style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          _cityCol(to, 'DESTINATION', align: CrossAxisAlignment.end),
        ],
      ),
    );
  }

  Widget _cityCol(String city, String label,
      {CrossAxisAlignment align = CrossAxisAlignment.start}) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          city.length >= 3 ? city.substring(0, 3).toUpperCase() : city.toUpperCase(),
          style: const TextStyle(
              fontSize: 38, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
        ),
        Text(city,
            style: const TextStyle(
                fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
        Text(label,
            style: const TextStyle(fontSize: 10, color: AppColors.textHint, letterSpacing: 1)),
      ],
    );
  }

  // ── Tear-off divider ─────────────────────────────────────────────────────
  Widget _buildTearOff() {
    return Row(
      children: [
        _notch(left: true),
        Expanded(
          child: CustomPaint(
            size: const Size(double.infinity, 1),
            painter: _DashedLinePainter(),
          ),
        ),
        _notch(left: false),
      ],
    );
  }

  Widget _notch({required bool left}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: AppColors.gradientMid,
        borderRadius: BorderRadius.horizontal(
          left: left ? Radius.zero : const Radius.circular(10),
          right: left ? const Radius.circular(10) : Radius.zero,
        ),
      ),
    );
  }

  // ── Details grid ─────────────────────────────────────────────────────────
  Widget _buildDetailsGrid(String pnr, String name, String seat,
      String gate, String cls, String date) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(children: [
        Row(children: [
          Expanded(child: _detailCell('PASSENGER', name)),
          Expanded(child: _detailCell('PNR', pnr)),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _detailCell('SEAT', seat)),
          Expanded(child: _detailCell('GATE', gate)),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _detailCell('CLASS', cls)),
          Expanded(child: _detailCell('DATE', date)),
        ]),
      ]),
    );
  }

  Widget _detailCell(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                color: AppColors.textHint,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 3),
        Text(value,
            style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700),
            overflow: TextOverflow.ellipsis),
      ],
    );
  }

  // ── QR section ───────────────────────────────────────────────────────────
  Widget _buildQrSection(String pnr) {
    return Column(children: [
      Container(
        height: 1,
        color: const Color(0xFFEEEEEE),
        margin: const EdgeInsets.symmetric(horizontal: 20),
      ),
      Padding(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          QrImageView(
            data: pnr,
            version: QrVersions.auto,
            size: 160,
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 10),
          Text(
            pnr,
            style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 2),
          ),
        ]),
      ),
    ]);
  }

  // ── Helpers ──────────────────────────────────────────────────────────────
  String _fmtDt(String? iso) {
    if (iso == null) return '--:--';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso;
    final h   = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m   = dt.minute.toString().padLeft(2, '0');
    final suf = dt.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $suf';
  }

  String _fmtDate(String? iso) {
    if (iso == null) return '--';
    final dt = DateTime.tryParse(iso);
    if (dt == null) return iso.length >= 10 ? iso.substring(0, 10) : iso;
    const months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[dt.month]} ${dt.day}, ${dt.year}';
  }
}

// ── Dashed line painter ───────────────────────────────────────────────────────
class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final paint = Paint()
      ..color = const Color(0xFFCCCCCC)
      ..strokeWidth = 1.5;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(min(x + dashWidth, size.width), 0), paint);
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
