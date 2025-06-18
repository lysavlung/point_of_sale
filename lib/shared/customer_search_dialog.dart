import 'package:flutter/material.dart';
import 'base_modal_dialog.dart';

class CustomerSearchDialog extends BaseModalDialog {
  CustomerSearchDialog({super.key})
    : super(
        title: 'Search Customer',
        primaryButtonText: 'OK',
        secondaryButtonText: 'Cancel',
        maxWidth: 400,
      );

  // Use a GlobalKey to access the state of the content widget
  final GlobalKey<_CustomerSearchContentState> _contentKey = GlobalKey();

  @override
  Widget buildContent(BuildContext context) {
    return _CustomerSearchContent(key: _contentKey);
  }

  @override
  void onPrimaryButtonPressed(BuildContext context) {
    // Use the key to get the selected customer
    final selected = _contentKey.currentState?.selectedCustomer;
    Navigator.of(context).pop(selected);
  }
}

class _CustomerSearchContent extends StatefulWidget {
  const _CustomerSearchContent({Key? key}) : super(key: key);

  @override
  State<_CustomerSearchContent> createState() => _CustomerSearchContentState();
}

class _CustomerSearchContentState extends State<_CustomerSearchContent> {
  final TextEditingController _searchController = TextEditingController();
  Map<String, dynamic>? selectedCustomer;

  // Example static customer list
  final List<Map<String, dynamic>> _customers = [
    {"number": "123456", "type": "Gold", "points": 2500, "name": "Alice Smith"},
    {
      "number": "654321",
      "type": "Silver",
      "points": 1200,
      "name": "Bob Johnson",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered =
        _searchController.text.isEmpty
            ? _customers
            : _customers
                .where(
                  (c) => c['name'].toString().toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
                )
                .toList();

    return SizedBox(
      width: 350,
      height: 300,
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Search by name',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final customer = filtered[index];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(customer['name']),
                  subtitle: Text(
                    'No: ${customer['number']} • ${customer['type']}',
                  ),
                  trailing:
                      selectedCustomer == customer
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                  selected: selectedCustomer == customer,
                  onTap: () {
                    setState(() {
                      selectedCustomer = customer;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
