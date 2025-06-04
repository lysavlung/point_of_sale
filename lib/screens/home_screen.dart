import 'package:flutter/material.dart';
import 'package:point_of_sale/shared/app_bar.dart';
import '../shared/menu_items.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SharedAppBar(title: "Home"),
      drawer: const AppDrawer(),
      body: const Center(
        child: Text(
          'Home Content Removed',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }
}
