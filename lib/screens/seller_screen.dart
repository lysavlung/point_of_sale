import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../shared/app_bar.dart';
import '../shared/confirm_modal_dialog.dart';
import '../shared/form_modal_dialog.dart';
import '../shared/item_quantity_modal_dialog.dart';

// Convert to StatefulWidget
class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  // Add state variable to track view mode
  bool _isGridView = true;

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
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Member Number:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    '123456',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Member Type:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    'Gold',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Loyalty Point:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    '2500',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
                    child: Container(
                      alignment: Alignment(0, 0),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Item code",
                          border: OutlineInputBorder(),
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        child: const Text("Scan Item"),
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        child: const Text("Discount"),
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        child: const Text("Hold Purchase"),
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
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          // Add your button logic here
                        },
                        child: const Text("Close"),
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
