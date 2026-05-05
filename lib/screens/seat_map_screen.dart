import 'package:flutter/material.dart';
import 'package:skytrip/generated/l10n/app_localizations.dart';
import '../theme/app_theme.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';

class SeatMapScreen extends StatefulWidget {
  const SeatMapScreen({super.key});

  @override
  State<SeatMapScreen> createState() => _SeatMapScreenState();
}

class _SeatMapScreenState extends State<SeatMapScreen> {
  final Map<String, String> _seatStatus = {};
  String? _selectedSeat;

  final int _rows = 12;
  final List<String> _columns = ['A', 'B', 'C', 'D', 'E', 'F'];

  @override
  void initState() {
    super.initState();
    for (int row = 1; row <= _rows; row++) {
      for (String col in _columns) {
        String seatId = '$row$col';
        if ((row + col.codeUnitAt(0)) % 3 == 0) {
          _seatStatus[seatId] = 'occupied';
        } else {
          _seatStatus[seatId] = 'available';
        }
      }
    }
  }

  void _selectSeat(String seatId) {
    if (_seatStatus[seatId] == 'occupied') return;
    setState(() {
      if (_selectedSeat != null) {
        _seatStatus[_selectedSeat!] = 'available';
      }
      _seatStatus[seatId] = 'selected';
      _selectedSeat = seatId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(l10n.seatMapTitle),
          elevation: 0,
        ),
        body: Column(
          children: [
            _buildLegend(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double available = constraints.maxWidth - 24 - 24 - 16 - 32;
                  final double seatMargin = 2.0;
                  final double seatSize = (available / 6) - (seatMargin * 2);

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildColumnHeaders(seatSize, seatMargin),
                        const SizedBox(height: 8),
                        ..._buildSeatRows(seatSize, seatMargin),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildBottomButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.surface, // بديل background غير موجود
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(_availableColor(context), l10n.seatMapAvailable),
          _buildLegendItem(AppColors.error, l10n.seatMapOccupied),
          _buildLegendItem(AppColors.cyan, l10n.seatMapSelected),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildColumnHeaders(double seatSize, double seatMargin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 24),
        ..._columns.sublist(0, 3).map((col) => Container(
          width: seatSize,
          margin: EdgeInsets.symmetric(horizontal: seatMargin),
          child: Center(
            child: Text(col,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        )),
        const SizedBox(width: 16),
        ..._columns.sublist(3).map((col) => Container(
          width: seatSize,
          margin: EdgeInsets.symmetric(horizontal: seatMargin),
          child: Center(
            child: Text(col,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        )),
        SizedBox(width: 24),
      ],
    );
  }

  List<Widget> _buildSeatRows(double seatSize, double seatMargin) {
    List<Widget> rows = [];
    for (int row = 1; row <= _rows; row++) {
      rows.add(_buildSeatRow(row, seatSize, seatMargin));
      rows.add(const SizedBox(height: 6));
    }
    return rows;
  }

  Widget _buildSeatRow(int rowNumber, double seatSize, double seatMargin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          child: Text(
            rowNumber.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        ..._columns.sublist(0, 3).map((col) => _buildSeat(rowNumber, col, seatSize, seatMargin)),
        const SizedBox(width: 16),
        ..._columns.sublist(3).map((col) => _buildSeat(rowNumber, col, seatSize, seatMargin)),
        SizedBox(
          width: 24,
          child: Text(
            rowNumber.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildSeat(int row, String col, double seatSize, double seatMargin) {
    String seatId = '$row$col';
    String status = _seatStatus[seatId] ?? 'available';

    Color seatColor;
    switch (status) {
      case 'occupied':
        seatColor = AppColors.error;
        break;
      case 'selected':
        seatColor = AppColors.cyan;
        break;
      default:
        seatColor = _availableColor(context);
    }

    return GestureDetector(
      onTap: () => _selectSeat(seatId),
      child: Container(
        width: seatSize,
        height: seatSize,
        margin: EdgeInsets.symmetric(horizontal: seatMargin),
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: status == 'selected' ? AppColors.cyanDark : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: status == 'occupied'
              ? Icon(Icons.close, color: AppColors.surface, size: seatSize * 0.4)
              : status == 'selected'
                  ? Icon(Icons.check, color: AppColors.surface, size: seatSize * 0.4)
                  : null,
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface, // بدل colorScheme.surface
        boxShadow: [
          BoxShadow(
            color: AppColors.border.withOpacity(0.15), // بدل colorScheme.shadow
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedSeat != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Selected: ', style: TextStyle(fontSize: 16)),
                    Text(_selectedSeat!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.cyan,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedSeat != null
                    ? () {
                        context.read<BookingProvider>().selectSeat(_selectedSeat!);
                        Navigator.pushNamed(context, '/payment');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cyan,
                  foregroundColor: AppColors.surface,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Confirm Seat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _availableColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? AppColors.textHint : AppColors.bg;
  }
}