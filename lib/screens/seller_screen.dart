import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../shared/app_bar.dart';
import '../shared/confirm_modal_dialog.dart';
import '../shared/item_quantity_modal_dialog.dart';
import '../shared/customer_search_dialog.dart'; // Make sure this import path matches your project

// Convert to StatefulWidget
class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  // Add state variable to track view mode
  bool _isGridView = true;

  // Add a customer variable (replace with your actual customer model if available)
  Map<String, dynamic>? customer; // null means no customer selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SharedAppBar(title: "Seller"),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.grid_view),
                      onPressed: () {
                        // Implement grid view toggle
                        setState(() {
                          _isGridView = true;
                        });
                      },
                      color: _isGridView ? Colors.blue : Colors.grey,
                    ),
                    IconButton(
                      icon: const Icon(Icons.list),
                      onPressed: () {
                        // Implement list view toggle
                        setState(() {
                          _isGridView = false;
                        });
                      },
                      color: !_isGridView ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
                Expanded(
                  flex: 4,
                  child: _isGridView ? _buildGridView() : _buildListView(),
                ),
                Expanded(
                  flex: 0,
                  child: Center(
                    child:
                        customer == null
                            ? Container(
                              constraints: const BoxConstraints(
                                maxWidth: 500,
                                minHeight: 80,
                                maxHeight: 120,
                              ),
                              margin: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(
                                      context,
                                    ).shadowColor.withOpacity(0.08),
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
                                    Icon(
                                      Icons.person_outline,
                                      size: 36,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'No customer selected',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(width: 24),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.person_add),
                                      label: const Text('Add/Select Customer'),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(160, 44),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            24,
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        // Show customer search dialog and wait for result
                                        final result =
                                            await CustomerSearchDialog()
                                                .show<Map<String, dynamic>>(
                                                  context,
                                                );
                                        if (result != null) {
                                          setState(() {
                                            customer = result;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : Container(
                              constraints: const BoxConstraints(
                                maxWidth: 900,
                                minHeight: 90,
                                maxHeight: 120,
                              ),
                              margin: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(
                                      context,
                                    ).shadowColor.withOpacity(0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.badge,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Member Number',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              customer!["number"] ?? '123456',
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.verified_user,
                                          color: Colors.amber[700],
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Member Type',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              customer!["type"] ?? 'Gold',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.copyWith(
                                                color: Colors.amber[800],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.stars,
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.secondary,
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Loyalty Point',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              customer!["points"]?.toString() ??
                                                  '2500',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.copyWith(
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.secondary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ResponsiveGridRow(
              children: [
                ResponsiveGridCol(
                  lg: 12,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        readOnly: true,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Item code",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 16,
                          ),
                          prefixIcon: Icon(
                            Icons.qr_code,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  xs: 12,
                  md: 6,
                  lg: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        icon: const Icon(Icons.qr_code_scanner),
                        label: const Text("Scan Item"),
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  xs: 12,
                  md: 6,
                  lg: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        icon: const Icon(Icons.percent),
                        label: const Text("Discount"),
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  xs: 12,
                  md: 6,
                  lg: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        icon: const Icon(Icons.pause_circle_filled),
                        label: const Text("Hold Purchase"),
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  xs: 12,
                  md: 6,
                  lg: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        icon: const Icon(Icons.lock),
                        label: const Text("Lock"),
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  xs: 12,
                  md: 6,
                  lg: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        icon: const Icon(Icons.swap_horiz),
                        label: const Text("Transfer"),
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  xs: 12,
                  md: 6,
                  lg: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        icon: const Icon(Icons.print),
                        label: const Text("Print"),
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  xs: 12,
                  md: 6,
                  lg: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        icon: const Icon(Icons.payment),
                        label: const Text("Payment"),
                      ),
                    ),
                  ),
                ),
                ResponsiveGridCol(
                  xs: 12,
                  md: 6,
                  lg: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        icon: const Icon(Icons.close),
                        label: const Text("Close"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Extract grid view to a separate method
  Widget _buildGridView() {
    return ResponsiveGridList(
      desiredItemWidth: 250,
      minSpacing: 10,
      children:
          List.generate(20, (index) => index + 1).map((i) {
            return _buildProductCard(i);
          }).toList(),
    );
  }

  // Create a list view alternative
  Widget _buildListView() {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        final i = index + 1;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: _buildProductCard(i),
        );
      },
    );
  }

  // Extract the product card to be reused in both views
  Widget _buildProductCard(int i) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          showAddItemDialog(context, 'Product Name $i', 'Code-$i', i * 10.0);
        },
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left column: Product image
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image, size: 40, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                // Right column: Product details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Code: ${i.toString().padLeft(6, '0')}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Product Name $i',
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Unit Price: \$${(i * 10).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Example 1: Simple confirmation dialog
  void showDeleteConfirmation(BuildContext context) {
    final dialog = ConfirmationDialog(
      title: 'Delete Item',
      message: 'Are you sure you want to delete this item?',
      onConfirm: () {
        // Handle deletion
        print('Item deleted');
      },
    );

    dialog.show(context);
  }

  // Example 2: Form dialog
  void showAddItemDialog(
    BuildContext context,
    String itemName,
    String itemCode,
    double unitPrice,
  ) {
    final dialog = QuantityDialog(
      title: 'Add Quantity',
      onQuantityConfirmed: (quantity) {
        // Handle quantity submission
        print('Added quantity: $quantity');
      },
      itemName: itemName,
      itemCode: itemCode,
      unitPrice: unitPrice,
      maxQuantity: 5,
    );

    dialog.show(context);
  }
}
