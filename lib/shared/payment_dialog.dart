import 'package:flutter/material.dart';
import 'base_modal_dialog.dart';

class PaymentDialog extends BaseModalDialog {
  final double totalAmountUSD;
  final double exchangeRate;
  final void Function(PaymentDialogResult result)? onPaymentConfirmed;

  PaymentDialog({
    required this.totalAmountUSD,
    required this.exchangeRate,
    this.onPaymentConfirmed,
  }) : super(
         title: 'Payment',
         primaryButtonText: 'Pay',
         secondaryButtonText: 'Cancel',
         maxWidth: 700, // Increased for large dialog
         maxHeight: 600, // Optionally set a larger height
       );

  final GlobalKey<_PaymentDialogContentState> _contentKey = GlobalKey();

  @override
  Widget buildContent(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 650, // Large width for payment dialog only
        child: _PaymentDialogContent(
          key: _contentKey,
          totalAmountUSD: totalAmountUSD,
          exchangeRate: exchangeRate,
        ),
      ),
    );
  }

  @override
  void onPrimaryButtonPressed(BuildContext context) {
    final state = _contentKey.currentState;
    if (state != null && state.isValid) {
      Navigator.of(context).pop();
      if (onPaymentConfirmed != null) {
        onPaymentConfirmed!(state.result);
      }
    }
  }
}

class PaymentDialogResult {
  final double paidUSD;
  final double paidKHR;
  final double changeUSD;
  final double changeKHR;
  final String paymentType;
  final String paymentMethod;
  PaymentDialogResult({
    required this.paidUSD,
    required this.paidKHR,
    required this.changeUSD,
    required this.changeKHR,
    required this.paymentType,
    required this.paymentMethod,
  });
}

class _PaymentDialogContent extends StatefulWidget {
  final double totalAmountUSD;
  final double exchangeRate;
  const _PaymentDialogContent({
    Key? key,
    required this.totalAmountUSD,
    required this.exchangeRate,
  }) : super(key: key);

  @override
  State<_PaymentDialogContent> createState() => _PaymentDialogContentState();
}

class _PaymentDialogContentState extends State<_PaymentDialogContent> {
  final TextEditingController _paidUSDController = TextEditingController();
  final TextEditingController _paidKHRController = TextEditingController();

  String paymentType = 'Single Payment';
  String paymentMethod = 'ABA Bank';

  double get paidUSD => double.tryParse(_paidUSDController.text) ?? 0.0;
  double get paidKHR => double.tryParse(_paidKHRController.text) ?? 0.0;
  double get totalKHR => widget.totalAmountUSD * widget.exchangeRate;
  double get receivedUSD => paidUSD;
  double get receivedKHR => paidKHR;
  double get changeUSD {
    final totalPaidUSD = paidUSD + (paidKHR / widget.exchangeRate);
    final change = totalPaidUSD - widget.totalAmountUSD;
    return change > 0 ? change : 0.0;
  }

  double get changeKHR {
    final totalPaidKHR = paidKHR + (paidUSD * widget.exchangeRate);
    final change = totalPaidKHR - totalKHR;
    return change > 0 ? change : 0.0;
  }

  bool get isValid =>
      (paidUSD + (paidKHR / widget.exchangeRate)) >= widget.totalAmountUSD;

  PaymentDialogResult get result => PaymentDialogResult(
    paidUSD: paidUSD,
    paidKHR: paidKHR,
    changeUSD: changeUSD,
    changeKHR: changeKHR,
    paymentType: paymentType,
    paymentMethod: paymentMethod,
  );

  @override
  void dispose() {
    _paidUSDController.dispose();
    _paidKHRController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: _AmountDisplay(
                    label: 'Total (USD)',
                    amount: widget.totalAmountUSD,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _AmountDisplay(
                    label: 'Total (KHR)',
                    amount: totalKHR,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _paidUSDController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Received (USD)',
                      prefixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceVariant,
                    ),
                    style: theme.textTheme.titleMedium,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _paidKHRController,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Received (KHR)',
                      prefixIcon: Icon(Icons.currency_exchange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceVariant,
                    ),
                    style: theme.textTheme.titleMedium,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: paymentType,
                    items: const [
                      DropdownMenuItem(
                        value: 'Single Payment',
                        child: Text('Single Payment'),
                      ),
                      DropdownMenuItem(
                        value: 'Instalment',
                        child: Text('Instalment'),
                      ),
                    ],
                    onChanged:
                        (val) => setState(
                          () => paymentType = val ?? 'Single Payment',
                        ),
                    decoration: InputDecoration(
                      labelText: 'Payment Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: paymentMethod,
                    items: const [
                      DropdownMenuItem(
                        value: 'ABA Bank',
                        child: Text('ABA Bank'),
                      ),
                      DropdownMenuItem(
                        value: 'Acleda Bank',
                        child: Text('Acleda Bank'),
                      ),
                    ],
                    onChanged:
                        (val) =>
                            setState(() => paymentMethod = val ?? 'ABA Bank'),
                    decoration: InputDecoration(
                      labelText: 'Payment Method',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _AmountDisplay(
                    label: 'Change (USD)',
                    amount: changeUSD,
                    color:
                        changeUSD > 0
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.error,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _AmountDisplay(
                    label: 'Change (KHR)',
                    amount: changeKHR,
                    color:
                        changeKHR > 0
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.error,
                  ),
                ),
              ],
            ),
            if (!isValid)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  'Insufficient payment. Please enter an amount greater than or equal to total.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AmountDisplay extends StatelessWidget {
  final String label;
  final double amount;
  final Color color;
  const _AmountDisplay({
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            amount.toStringAsFixed(2),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
