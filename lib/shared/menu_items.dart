import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          // Updated Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Row(
              children: [
                // Logo Container
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.link, // Replace with your logo icon
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // App Name
                const Text(
                  'X POS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
                ExpansionTile(
                  leading: const Icon(Icons.store),
                  title: const Text('Store Products'),
                  children: const [
                    ListTile(title: Text('Product'), onTap: null),
                    ListTile(title: Text('Inventory'), onTap: null),
                    ListTile(title: Text('Categories'), onTap: null),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Customer'),
                  onTap: () {
                    Navigator.pushNamed(context, '/pos/customer');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bar_chart),
                  title: const Text('Sales'),
                  onTap: () {
                    Navigator.pushNamed(context, '/pos/seller');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.campaign),
                  title: const Text('Marketing'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.analytics),
                  title: const Text('Analytics'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Setting'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
