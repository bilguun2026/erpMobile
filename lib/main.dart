import 'package:erp_1/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transport ERP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define the routes for navigation
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
