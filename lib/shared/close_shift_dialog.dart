import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:point_of_sale/shared/currency_utils.dart';

/// A large modal dialog for closing cashier shift (Stateful version, best practices)
class CloseShiftDialog extends StatefulWidget {
  final double totalSales;
  final double expectedCash;
  final String cashierName;
  final DateTime shiftStart;
  final DateTime shiftEnd;
  final double exchangeRate;

  const CloseShiftDialog({
    super.key,
    required this.totalSales,
    required this.expectedCash,
    required this.cashierName,
    required this.shiftStart,
    required this.shiftEnd,
    required this.exchangeRate,
  });

  @override
  State<CloseShiftDialog> createState() => _CloseShiftDialogState();
}

class _CloseShiftDialogState extends State<CloseShiftDialog> {
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
  late final Map<int, TextEditingController> _usdControllers;
  late final Map<int, TextEditingController> _khrControllers;
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usdControllers = {
      for (var d in usdDenominations) d: TextEditingController(text: '0'),
    };
    _khrControllers = {
      for (var d in khrDenominations) d: TextEditingController(text: '0'),
    };
    // Sample values for testing
    _usdControllers[100]?.text = '2';
    _usdControllers[20]?.text = '3';
    _khrControllers[10000]?.text = '5';
    for (final c in _usdControllers.values) {
      c.addListener(_onInputChanged);
    }
    for (final c in _khrControllers.values) {
      c.addListener(_onInputChanged);
    }
  }

  @override
  void dispose() {
    for (final c in _usdControllers.values) {
      c.dispose();
    }
    for (final c in _khrControllers.values) {
      c.dispose();
    }
    _notesController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    setState(() {}); // Rebuild to update totals/discrepancy
  }

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

  double get cashInDrawerUSD => usdTotal + (khrTotal / widget.exchangeRate);
  double get discrepancy => cashInDrawerUSD - widget.expectedCash;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 900),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
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
                ),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 16.0, 16.0),
      decoration: BoxDecoration(
        color: Color.alphaBlend(
          Theme.of(context).colorScheme.primary.withAlpha((0.06 * 255).toInt()),
          Theme.of(context).scaffoldBackgroundColor,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Close Shift',
            style:
                Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ) ??
                const TextStyle(fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
            splashRadius: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed:
                () => Navigator.of(context).pop({
                  'usdTotal': usdTotal,
                  'khrTotal': khrTotal,
                  'cashInDrawerUSD': cashInDrawerUSD,
                  'discrepancy': discrepancy,
                  'notes': _notesController.text,
                }),
            child: const Text('Confirm Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color.alphaBlend(
        Theme.of(context).colorScheme.primary.withAlpha((0.04 * 255).toInt()),
        Theme.of(context).scaffoldBackgroundColor,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cashier: ${widget.cashierName}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Shift: ${_formatDateTime(widget.shiftStart)} - ${_formatDateTime(widget.shiftEnd)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryTile(
                  'Total Sales',
                  widget.totalSales,
                  currency: '\$',
                ),
                _buildSummaryTile(
                  'Expected Cash',
                  widget.expectedCash,
                  currency: '\$',
                ),
                _buildSummaryTile(
                  'Cash in Drawer',
                  cashInDrawerUSD,
                  currency: '\$',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTile(String label, double value, {String currency = ''}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        Text(
          currency.isNotEmpty
              ? formatAccounting(value, currency: currency)
              : value.toStringAsFixed(2),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildDiscrepancySection(BuildContext context) {
    final isDiscrepant = discrepancy.abs() > 0.01;
    String formattedDiscrepancy = formatAccounting(discrepancy);
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
                ? 'Discrepancy detected: $formattedDiscrepancy'
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
        Row(
          children: [
            const Icon(
              Icons.sticky_note_2_outlined,
              color: Colors.amber,
              size: 20,
            ),
            const SizedBox(width: 6),
            Text(
              'Notes (optional):',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _notesController,
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
    return Card(
      elevation: 0,
      color: Color.alphaBlend(
        Theme.of(context).colorScheme.primary.withAlpha((0.03 * 255).toInt()),
        Theme.of(context).scaffoldBackgroundColor,
      ),
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
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children:
                  usdDenominations
                      .map(
                        (denom) => _buildDenominationField(
                          label: '\$$denom',
                          controller: _usdControllers[denom]!,
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 8),
            Text(
              'USD Total: \$${usdTotal.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('KHR Notes', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children:
                  khrDenominations
                      .map(
                        (denom) => _buildDenominationField(
                          label: '$denom ៛',
                          controller: _khrControllers[denom]!,
                        ),
                      )
                      .toList(),
            ),
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
  }) {
    final isActive =
        int.tryParse(controller.text) != null && int.parse(controller.text) > 0;
    return SizedBox(
      width: 90,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: isActive ? Colors.green : Colors.grey.shade400,
              width: isActive ? 2 : 1,
            ),
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
          fillColor:
              isActive ? Colors.green.shade50 : null, // Use a light green shade
          filled: isActive,
        ),
        style: TextStyle(
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? Colors.green[800] : null,
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
