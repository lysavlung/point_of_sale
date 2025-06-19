import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../shared/app_bar.dart';
import '../../shared/confirm_modal_dialog.dart';
import '../../shared/item_quantity_modal_dialog.dart';
import 'actions_section.dart';
import 'customer_section.dart';

// Product model
class Product {
  final int id;
  final String code;
  final String name;
  final double price;
  final int quantity;

  Product(this.id, this.code, this.name, this.price, this.quantity);
}

// DataGridSource for Syncfusion DataGrid
class ProductDataSource extends DataGridSource {
  List<DataGridRow> _rows = [];

  ProductDataSource(List<Product> products) {
    _rows =
        products
            .map<DataGridRow>(
              (product) => DataGridRow(
                cells: [
                  DataGridCell<int>(columnName: 'id', value: product.id),
                  DataGridCell<String>(columnName: 'code', value: product.code),
                  DataGridCell<String>(columnName: 'name', value: product.name),
                  DataGridCell<double>(
                    columnName: 'price',
                    value: product.price,
                  ),
                  DataGridCell<int>(
                    columnName: 'quantity',
                    value: product.quantity,
                  ),
                ],
              ),
            )
            .toList();
  }

  @override
  List<DataGridRow> get rows => _rows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: [
        // Image cell
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.image, size: 24, color: Colors.blueGrey),
        ),
        // Code
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(row.getCells()[1].value.toString()),
        ),
        // Name
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(row.getCells()[2].value.toString()),
        ),
        // Price
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Text(
            '\$${(row.getCells()[3].value as double).toStringAsFixed(2)}',
            style: TextStyle(
              color: Colors.green[700],
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ),
        // Quantity
        Row(
          children: [
            Icon(
              Icons.confirmation_num,
              size: 16,
              color: Colors.deepPurpleAccent,
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                row.getCells()[4].value.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.deepPurple[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Convert to StatefulWidget
class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  bool _isGridView = true;
  Map<String, dynamic>? customer;

  // Example product data
  final List<Product> products = List.generate(
    20,
    (i) => Product(
      i + 1,
      (i + 1).toString().padLeft(6, '0'),
      'Product Name ${i + 1}',
      (i + 1) * 10.0,
      (i + 1) * 2,
    ),
  );

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
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 350),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeOut,
                    child:
                        _isGridView
                            ? _buildGridView(key: ValueKey('grid'))
                            : _buildListView(key: ValueKey('list')),
                  ),
                ),
                Expanded(
                  // Customer section
                  flex: 0,
                  child: Center(
                    child: CustomerSection(
                      customer: customer,
                      onCustomerChanged: (c) => setState(() => customer = c),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            // Actions section
            flex: 1,
            child: ActionsSection(),
          ),
        ],
      ),
    );
  }

  // Extract grid view to a separate method
  Widget _buildGridView({Key? key}) {
    return ResponsiveGridList(
      key: key,
      desiredItemWidth: 250,
      minSpacing: 10,
      children:
          List.generate(
            20,
            (index) => index + 1,
          ).map((i) => _buildProductCard(i)).toList(),
    );
  }

  // Create a list view alternative using Syncfusion DataGrid
  Widget _buildListView({Key? key}) {
    // Example product data
    final List<Product> products = List.generate(
      20,
      (i) => Product(
        i + 1,
        (i + 1).toString().padLeft(6, '0'),
        'Product Name ${i + 1}',
        (i + 1) * 10.0,
        (i + 1) * 2,
      ),
    );
    final ProductDataSource productDataSource = ProductDataSource(products);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SfDataGrid(
        key: key,
        source: productDataSource,
        columns: [
          GridColumn(
            columnName: 'id',
            label: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              child: Text(
                'Image',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GridColumn(
            columnName: 'code',
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8),
              child: Text(
                'Code',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GridColumn(
            columnName: 'name',
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8),
              child: Text(
                'Product Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GridColumn(
            columnName: 'price',
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8),
              child: Text(
                'Unit Price',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GridColumn(
            columnName: 'quantity',
            label: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(8),
              child: Text(
                'Quantity',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
        columnWidthMode: ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
        allowSorting: true,
        allowMultiColumnSorting: true,
        isScrollbarAlwaysShown: true,
        onCellTap: (details) {
          if (details.rowColumnIndex.rowIndex > 0) {
            final rowIndex = details.rowColumnIndex.rowIndex - 1;
            final row = productDataSource.rows[rowIndex];
            final code = row.getCells()[1].value;
            final name = row.getCells()[2].value;
            final price = row.getCells()[3].value;
            showAddItemDialog(context, name, code, price);
          }
        },
      ),
    );
  }

  // Extract the product card to be reused in both views
  Widget _buildProductCard(int i) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          showAddItemDialog(context, 'Product Name $i', 'Code-$i', i * 10.0);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Reduced padding
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 64, // Back to previous size
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.image,
                  size: 40, // Slightly smaller icon
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(width: 12), // Reduced spacing
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Code: ${i.toString().padLeft(6, '0')}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14, // Slightly smaller font
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Product Name $i',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Unit Price: \$${(i * 10).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.confirmation_num,
                          size: 16,
                          color: Colors.deepPurpleAccent,
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Quantity: ${i * 2}', // Example quantity
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.deepPurple[700],
                              fontWeight: FontWeight.w500,
                            ),
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

// Removed duplicate ProductDataSource (DataTableSource) implementation
