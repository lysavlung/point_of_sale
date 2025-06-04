import 'package:flutter/material.dart';

import '../shared/app_bar.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SharedAppBar(title: "Items"),
      body: Row(
        children: [
          // Left Column: List of Items
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200],
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: 10, // Replace with your dynamic item count
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ListTile(
                      leading: const Icon(Icons.shopping_cart),
                      title: Text('Item ${index + 1}'),
                      subtitle: const Text('Description of the item'),
                      trailing: Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Quantity: 2',
                              style: TextStyle(
                                // fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            // SizedBox(height: 3),
                            Text(
                              'Price: \$10.00', // Replace with dynamic price
                              style: TextStyle(
                                // fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            // SizedBox(height: 3),
                            Text(
                              'Discount: \$2.00',
                              style: TextStyle(
                                // fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Right Column: Summary and Actions
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Subtotal
                  const Text(
                    'Subtotal:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$100.00', // Replace with dynamic subtotal
                    style: TextStyle(fontSize: 16),
                  ),
                  const Divider(height: 32),
                  // Discount
                  const Text(
                    'Discount:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$10.00', // Replace with dynamic discount
                    style: TextStyle(fontSize: 16),
                  ),
                  const Divider(height: 32),
                  // Total
                  const Text(
                    'Total:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$90.00', // Replace with dynamic total
                    style: TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  // Buttons Layout
                  ElevatedButton(
                    onPressed: () {
                      // Add print functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Print'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add checkout functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Check Out'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
