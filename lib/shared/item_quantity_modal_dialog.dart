import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'base_modal_dialog.dart';

class QuantityDialog extends BaseModalDialog {
  /// The item name being modified
  final String itemName;

  /// The item code or SKU
  final String itemCode;

  /// The unit price of the item
  final double unitPrice;

  /// The initial quantity value
  final int initialQuantity;

  /// The maximum allowed quantity (null for unlimited)
  final int? maxQuantity;

  /// The minimum allowed quantity (defaults to 1)
  final int minQuantity;

  /// Callback when quantity is confirmed
  final Function(int quantity)? onQuantityConfirmed;

  /// Optional item image widget
  final Widget? itemImage;

  /// Quantity increment step (defaults to 1)
  final int step;

  // This will store the current quantity to access it in onPrimaryButtonPressed
  late int _currentQuantity;
  late final TextEditingController _quantityController;

  QuantityDialog({
    required super.title,
    required this.itemName,
    required this.itemCode,
    required this.unitPrice,
    this.initialQuantity = 1,
    this.maxQuantity,
    this.minQuantity = 1,
    this.onQuantityConfirmed,
    this.itemImage,
    this.step = 1,
    String confirmText = 'Apply',
    String cancelText = 'Cancel',
  }) : super(
         primaryButtonText: confirmText,
         secondaryButtonText: cancelText,
         maxWidth: 400.0,
       ) {
    // Initialize current quantity and controller
    _currentQuantity = initialQuantity;
    _quantityController = TextEditingController(
      text: initialQuantity.toString(),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    // Use stateful builder to manage quantity state within the dialog
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        // Function to update quantity with validation
        void updateQuantity(int newValue) {
          if ((maxQuantity != null && newValue > maxQuantity!) ||
              newValue < minQuantity) {
            return;
          }

          setState(() {
            _currentQuantity = newValue;
            _quantityController.text = _currentQuantity.toString();
          });
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item details section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Item image if available
                if (itemImage != null)
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: itemImage,
                  ),

                // Item details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text('Item Code: $itemCode'),
                      const SizedBox(height: 4.0),
                      Text(
                        'Unit Price: \$${unitPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (maxQuantity != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Stock Available: $maxQuantity',
                            style: TextStyle(
                              color:
                                  _currentQuantity >= maxQuantity!
                                      ? Colors.orange
                                      : Colors.grey[700],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24.0),

            // Quantity adjustment controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Decrease button
                ElevatedButton(
                  onPressed:
                      _currentQuantity > minQuantity
                          ? () => updateQuantity(_currentQuantity - step)
                          : null,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                  ),
                  child: const Icon(Icons.remove, size: 24.0),
                ),

                // Quantity display and input
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: 80.0,
                    child: TextField(
                      controller: _quantityController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8.0),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          final newQuantity = int.parse(value);
                          if ((maxQuantity == null ||
                                  newQuantity <= maxQuantity!) &&
                              newQuantity >= minQuantity) {
                            setState(() {
                              _currentQuantity = newQuantity;
                            });
                          }
                        }
                      },
                    ),
                  ),
                ),

                // Increase button
                ElevatedButton(
                  onPressed:
                      (maxQuantity == null || _currentQuantity < maxQuantity!)
                          ? () => updateQuantity(_currentQuantity + step)
                          : null,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.black,
                  ),
                  child: const Icon(Icons.add, size: 24.0),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Total calculation
            Center(
              child: Text(
                'Total: \$${(_currentQuantity * unitPrice).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void onPrimaryButtonPressed(BuildContext context) {
    // Simply use the stored _currentQuantity which is always up-to-date
    onQuantityConfirmed?.call(_currentQuantity);

    // Close the dialog and return the quantity
    Navigator.of(context).pop(_currentQuantity);
  }

  void dispose() {
    _quantityController.dispose();
  }
}
