import 'package:flutter/material.dart';
import 'screens/customer_screen.dart';
import 'screens/home_screen.dart';
import 'screens/seller/seller_screen.dart';
import 'screens/settings_screen.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'POS Home',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/pos/customer': (context) => const CustomerScreen(),
            '/pos/seller': (context) => const SellerScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
        );
      },
    );
  }
}
