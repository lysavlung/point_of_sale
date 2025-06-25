import 'package:flutter/material.dart';
import 'base_modal_dialog.dart';

/// A large modal dialog for closing cashier shift
class CloseShiftDialog extends BaseModalDialog {
  final double totalSales;
  final double expectedCash;
  final String cashierName;
  final DateTime shiftStart;
  final DateTime shiftEnd;
  final double exchangeRate; // Add exchange rate

  CloseShiftDialog({
    required this.totalSales,
    required this.expectedCash,
    required this.cashierName,
    required this.shiftStart,
    required this.shiftEnd,
    required this.exchangeRate,
  }) : super(
         title: 'Close Shift',
         maxWidth: 700,
         maxHeight: 900,
         primaryButtonText: 'Confirm Close',
         secondaryButtonText: 'Cancel',
       );

  // --- Denomination Input Section ---
  final List<int> usdDenominations = const [100, 50, 20, 10, 5, 2, 1];
  final List<int> khrDenominations = const [
    100000,
    50000,
    20000,
    10000,
    5000,
    2000,
    1000,
    500,
    100,
  ];
  final Map<int, TextEditingController> _usdControllers = {};
  final Map<int, TextEditingController> _khrControllers = {};

  double get usdTotal {
    double total = 0;
    for (final denom in usdDenominations) {
      final count = int.tryParse(_usdControllers[denom]?.text ?? '') ?? 0;
      total += denom * count;
    }
    return total;
  }

  double get khrTotal {
    double total = 0;
    for (final denom in khrDenominations) {
      final count = int.tryParse(_khrControllers[denom]?.text ?? '') ?? 0;
      total += denom * count;
    }
    return total;
  }

  double get cashInDrawerUSD => usdTotal + (khrTotal / exchangeRate);
  double get discrepancy => cashInDrawerUSD - expectedCash;

  @override
  Widget buildContent(BuildContext context) {
    // For testing: set sample values
    _usdControllers[100] ??= TextEditingController(text: '2'); // $100 x2 = $200
    _usdControllers[20] ??= TextEditingController(text: '3'); // $20 x3 = $60
    _khrControllers[10000] ??= TextEditingController(
      text: '5',
    ); // 10,000 x5 = 50,000 KHR
    // exchangeRate = 4100 (passed in constructor)
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSummarySection(context),
          const SizedBox(height: 24),
          _buildDenominationInputSection(context),
          const SizedBox(height: 24),
          _buildDiscrepancySection(context),
          const SizedBox(height: 24),
          _buildNotesSection(context),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.04),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cashier: $cashierName',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Shift: ${_formatDateTime(shiftStart)} - ${_formatDateTime(shiftEnd)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryTile('Total Sales', totalSales),
                _buildSummaryTile('Expected Cash', expectedCash),
                _buildSummaryTile('Cash in Drawer', cashInDrawerUSD),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTile(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        Text(
          value.toStringAsFixed(2),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildDiscrepancySection(BuildContext context) {
    final isDiscrepant = discrepancy.abs() > 0.01;
    return Row(
      children: [
        Icon(
          isDiscrepant ? Icons.warning_amber_rounded : Icons.check_circle,
          color: isDiscrepant ? Colors.orange : Colors.green,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            isDiscrepant
                ? 'Discrepancy detected: ${discrepancy > 0 ? '+' : ''}${discrepancy.toStringAsFixed(2)}'
                : 'No cash discrepancy detected.',
            style: TextStyle(
              color: isDiscrepant ? Colors.orange : Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes (optional):',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Add any notes about this shift closure... ',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildDenominationInputSection(BuildContext context) {
    void refresh() => (context as Element).markNeedsBuild();
    // Build USD notes
    final usdNoteFields =
        usdDenominations.map((denom) {
          _usdControllers.putIfAbsent(
            denom,
            () => TextEditingController(text: '0'),
          );
          if (_usdControllers[denom]!.text.isEmpty) {
            _usdControllers[denom]!.text = '0';
          }
          return _buildDenominationField(
            label: '\$ $denom',
            controller: _usdControllers[denom]!,
            onChanged: refresh,
          );
        }).toList();
    // KHR notes
    final khrNoteFields =
        khrDenominations.map((denom) {
          _khrControllers.putIfAbsent(
            denom,
            () => TextEditingController(text: '0'),
          );
          if (_khrControllers[denom]!.text.isEmpty) {
            _khrControllers[denom]!.text = '0';
          }
          return _buildDenominationField(
            label: '$denom ៛',
            controller: _khrControllers[denom]!,
            onChanged: refresh,
          );
        }).toList();

    double usdTotal = 0;
    for (final denom in usdDenominations) {
      final count = int.tryParse(_usdControllers[denom]?.text ?? '') ?? 0;
      usdTotal += denom * count;
    }
    double khrTotal = 0;
    for (final denom in khrDenominations) {
      final count = int.tryParse(_khrControllers[denom]?.text ?? '') ?? 0;
      khrTotal += denom * count;
    }

    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primary.withOpacity(0.03),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Count Cash by Denomination',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text('USD Notes', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Wrap(spacing: 12, runSpacing: 8, children: usdNoteFields),
            const SizedBox(height: 8),
            Text(
              'USD Total: \$${usdTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('KHR Notes', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Wrap(spacing: 12, runSpacing: 8, children: khrNoteFields),
            const SizedBox(height: 8),
            Text(
              'KHR Total: ${khrTotal.toStringAsFixed(0)} ៛',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDenominationField({
    required String label,
    required TextEditingController controller,
    VoidCallback? onChanged,
  }) {
    return SizedBox(
      width: 90,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
        ),
        onChanged: (_) {
          if (onChanged != null) onChanged();
        },
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  void onPrimaryButtonPressed(BuildContext context) {
    // TODO: Implement shift close logic, e.g., API call, local save, etc.
    Navigator.of(context).pop(true);
  }
}
