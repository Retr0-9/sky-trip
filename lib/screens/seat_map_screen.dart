import 'package:flutter/material.dart';

class SeatMapScreen extends StatefulWidget {
  const SeatMapScreen({super.key});

  @override
  State<SeatMapScreen> createState() => _SeatMapScreenState();
}

class _SeatMapScreenState extends State<SeatMapScreen> {
  // TODO: Replace with actual seat data from API
  // Seat status: available, occupied, selected
  final Map<String, String> _seatStatus = {};
  String? _selectedSeat;
  
  // Dummy seat configuration (6 rows, 6 seats per row: A-F)
  final int _rows = 12;
  final List<String> _columns = ['A', 'B', 'C', 'D', 'E', 'F'];
  
  @override
  void initState() {
    super.initState();
    // Initialize dummy seat data
    for (int row = 1; row <= _rows; row++) {
      for (String col in _columns) {
        String seatId = '$row$col';
        // Randomly mark some seats as occupied (dummy data)
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
      // Deselect previous seat
      if (_selectedSeat != null) {
        _seatStatus[_selectedSeat!] = 'available';
      }
      
      // Select new seat
      _seatStatus[seatId] = 'selected';
      _selectedSeat = seatId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Seat'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Legend
          _buildLegend(),
          
          // Seat Map
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate responsive seat size:
                // Available width - row numbers (24×2) - aisle (16) - padding (32)
                // Divided by 6 seats, minus margins (2×2 per seat)
                final double available = constraints.maxWidth - 24 - 24 - 16 - 32;
                final double seatMargin = 2.0;
                final double seatSize = (available / 6) - (seatMargin * 2);

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Column Headers (A B C - D E F)
                      _buildColumnHeaders(seatSize, seatMargin),
                      const SizedBox(height: 8),

                      // Seat Grid
                      ..._buildSeatRows(seatSize, seatMargin),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Bottom Button
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem(Colors.grey.shade300, 'Available'),
          _buildLegendItem(Colors.red.shade300, 'Occupied'),
          _buildLegendItem(Colors.cyan, 'Selected'),
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
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildColumnHeaders(double seatSize, double seatMargin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Row number placeholder (for alignment)
        SizedBox(width: 24),

        // Left side headers (A B C)
        ..._columns.sublist(0, 3).map((col) => Container(
          width: seatSize,
          margin: EdgeInsets.symmetric(horizontal: seatMargin),
          child: Center(
            child: Text(
              col,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        )),

        // Aisle gap
        const SizedBox(width: 16),

        // Right side headers (D E F)
        ..._columns.sublist(3).map((col) => Container(
          width: seatSize,
          margin: EdgeInsets.symmetric(horizontal: seatMargin),
          child: Center(
            child: Text(
              col,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        )),

        // Row number placeholder (for alignment)
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
        // Row number (left)
        SizedBox(
          width: 24,
          child: Text(
            rowNumber.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),

        // Left side seats (A B C)
        ..._columns.sublist(0, 3).map(
          (col) => _buildSeat(rowNumber, col, seatSize, seatMargin),
        ),

        // Aisle gap
        const SizedBox(width: 16),

        // Right side seats (D E F)
        ..._columns.sublist(3).map(
          (col) => _buildSeat(rowNumber, col, seatSize, seatMargin),
        ),

        // Row number (right)
        SizedBox(
          width: 24,
          child: Text(
            rowNumber.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
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
        seatColor = Colors.red.shade300;
        break;
      case 'selected':
        seatColor = Colors.cyan;
        break;
      default:
        seatColor = Colors.grey.shade300;
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
            color: status == 'selected'
                ? Colors.cyan.shade700
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Center(
          child: status == 'occupied'
              ? Icon(Icons.close, color: Colors.white, size: seatSize * 0.4)
              : status == 'selected'
                  ? Icon(Icons.check, color: Colors.white, size: seatSize * 0.4)
                  : null,
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
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
                    const Text(
                      'Selected: ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      _selectedSeat!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
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
                        // TODO: Save selected seat, then navigate
                        Navigator.pushNamed(context, '/payment');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm Seat',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
