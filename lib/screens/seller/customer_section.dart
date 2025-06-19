import 'package:flutter/material.dart';
import '../../shared/customer_search_dialog.dart';

/// Displays customer information or a prompt to select/add a customer.
class CustomerSection extends StatelessWidget {
  final Map<String, dynamic>? customer;
  final void Function(Map<String, dynamic>?) onCustomerChanged;

  const CustomerSection({
    super.key,
    required this.customer,
    required this.onCustomerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return customer == null
        ? _NoCustomerWidget(onCustomerChanged: onCustomerChanged)
        : _CustomerInfoWidget(customer: customer!);
  }
}

class _NoCustomerWidget extends StatelessWidget {
  final void Function(Map<String, dynamic>?) onCustomerChanged;
  const _NoCustomerWidget({required this.onCustomerChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 500,
        minHeight: 80,
        maxHeight: 120,
      ),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.person_outline, size: 36, color: Colors.grey),
            const SizedBox(width: 12),
            Text(
              'No customer selected',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.person_add),
              label: const Text('Add/Select Customer'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(160, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () async {
                final result = await CustomerSearchDialog()
                    .show<Map<String, dynamic>>(context);
                if (result != null) {
                  onCustomerChanged(result);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerInfoWidget extends StatelessWidget {
  final Map<String, dynamic> customer;
  const _CustomerInfoWidget({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 900,
        minHeight: 90,
        maxHeight: 120,
      ),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CustomerInfoRow(
            icon: Icons.badge,
            iconColor: Theme.of(context).colorScheme.primary,
            label: 'Member Number',
            value: customer["number"] ?? '123456',
          ),
          const SizedBox(width: 32),
          _CustomerInfoRow(
            icon: Icons.verified_user,
            iconColor: Colors.amber[700],
            label: 'Member Type',
            value: customer["type"] ?? 'Gold',
            valueStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.amber[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 32),
          _CustomerInfoRow(
            icon: Icons.stars,
            iconColor: Theme.of(context).colorScheme.secondary,
            label: 'Loyalty Point',
            value: customer["points"]?.toString() ?? '2500',
            valueStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerInfoRow extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String value;
  final TextStyle? valueStyle;
  const _CustomerInfoRow({
    required this.icon,
    this.iconColor,
    required this.label,
    required this.value,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: valueStyle ?? Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
