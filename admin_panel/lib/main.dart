import 'package:admin_panel/Screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommarce app Admin Pannel',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const DashboardScreen(),
    );
  }
}
