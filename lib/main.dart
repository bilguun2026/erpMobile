import 'package:erp_1/screens/dashboard.dart';
import 'package:erp_1/screens/tender.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardScreen(),
        '/tenders': (context) => TenderScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
