import 'package:flutter/material.dart';
import '../../shared/close_shift_dialog.dart';

/// Helper to show the CloseShiftDialog with sample/mock data
void showCloseShiftDialog(BuildContext context) {
  // TODO: Replace these with real values from your app state
  final double totalSales = 1234.56;
  final double expectedCash = 1234.56;
  final String cashierName = 'John Doe';
  final DateTime shiftStart = DateTime.now().subtract(const Duration(hours: 8));
  final DateTime shiftEnd = DateTime.now();
  final double exchangeRate = 4100; // Sample exchange rate

  showDialog(
    context: context,
    barrierDismissible: true,
    builder:
        (context) => CloseShiftDialog(
          totalSales: totalSales,
          expectedCash: expectedCash,
          cashierName: cashierName,
          shiftStart: shiftStart,
          shiftEnd: shiftEnd,
          exchangeRate: exchangeRate,
        ),
  );
}
