import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

class PosCheckoutScreen extends StatefulWidget {
  const PosCheckoutScreen({super.key});

  @override
  State<PosCheckoutScreen> createState() => _PosCheckoutScreenState();
}

class _PosCheckoutScreenState extends State<PosCheckoutScreen> {
  bool isGrid = true;

  final List<String> products = [
    'Beanie with Logo',
    'T-Shirt with Logo',
    'Single',
    'Album',
    'Polo',
    'Long Sleeve Tee',
    'Hoodie with Zipper',
    'Hoodie with Pocket',
    'Sunglasses',
    'Cap',
    'Belt',
    'Beanie',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS Checkout'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: Row(
        children: [
          // Left: Product Grid/List
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Top search and filter bar
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Scan your product',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                        child: const Text('Scan'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 2,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 12,
                            ),
                          ),
                          value: 'All categories',
                          items: const [
                            DropdownMenuItem(
                              value: 'All categories',
                              child: Text('All categories'),
                            ),
                            DropdownMenuItem(
                              value: 'T-Shirts',
                              child: Text('T-Shirts'),
                            ),
                            DropdownMenuItem(
                              value: 'Accessories',
                              child: Text('Accessories'),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: Icon(
                          isGrid ? Icons.grid_view : Icons.grid_view_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            isGrid = true;
                          });
                        },
                        color: isGrid ? Colors.blue : null,
                      ),
                      IconButton(
                        icon: Icon(isGrid ? Icons.menu_outlined : Icons.menu),
                        onPressed: () {
                          setState(() {
                            isGrid = false;
                          });
                        },
                        color: !isGrid ? Colors.blue : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Product grid or list
                  Expanded(
                    child:
                        isGrid
                            ? ResponsiveGridList(
                              desiredItemWidth: 140,
                              minSpacing: 12,
                              children:
                                  products.map((name) {
                                    return Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.circular(8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 12),
                                            Container(
                                              height: 48,
                                              width: 48,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Icon(
                                                Icons.image,
                                                size: 32,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              name,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                            )
                            : ListView.separated(
                              itemCount: products.length,
                              separatorBuilder:
                                  (_, __) => const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final name = products[index];
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    title: Text(name),
                                    trailing: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text('Add'),
                                    ),
                                  ),
                                );
                              },
                            ),
                  ),
                  // Bottom bar
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.red[200],
                    child: const Center(
                      child: Text(
                        'Simply click to add',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right: Cart and Checkout (unchanged)
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Cart header
                  Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search customer',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(icon: const Icon(Icons.add), onPressed: () {}),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Cart table header
                  Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Product',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Qty',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Price',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 32),
                      ],
                    ),
                  ),
                  // Cart items
                  Expanded(
                    child: ListView(
                      children: [
                        _cartItem('Single', 1, '£14.99'),
                        _cartItem('Album', 1, '£14.99'),
                        _cartItem('Hoodie with Pocket', 1, '£33.33'),
                        _cartItem('Sunglasses', 1, '£85.71'),
                        _cartItem('Hoodie with Zipper', 1, '£42.86'),
                        _cartItem('Long Sleeve Tee', 1, '£23.81'),
                        _cartItem('Belt', 1, '£17.34'),
                        _cartItem('Beanie', 1, '£14.34'),
                      ],
                    ),
                  ),
                  // Cart summary
                  Column(
                    children: [
                      _cartSummaryRow('Subtotal', '£288.56'),
                      _cartSummaryRow('Tax', '£14.44'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Add Discount'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Add Fee'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text('Add Note'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                              ),
                              child: const Text(
                                'Pay Now',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '£303.00',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
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
        ],
      ),
    );
  }

  static Widget _cartItem(String name, int qty, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Row(
        children: [
          Expanded(flex: 4, child: Text(name)),
          Expanded(flex: 2, child: Text(qty.toString())),
          Expanded(flex: 2, child: Text(price)),
          IconButton(icon: const Icon(Icons.close, size: 18), onPressed: () {}),
        ],
      ),
    );
  }

  static Widget _cartSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
