import 'package:erp_1/screens/dashboard/dashboard.dart';
import 'package:erp_1/screens/job/job.dart';
import 'package:erp_1/screens/payroll.dart';
import 'package:erp_1/screens/salary.dart';
import 'package:erp_1/screens/tender/tender.dart';
import 'package:erp_1/screens/transport/transport.dart';
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
        '/jobs': (context) => JobScreen(),
        '/transports': (context) => TransportScreen(),
        '/salary': (context) => SalaryScreen(),
        '/payroll': (context) => PayrollScreen(
              month: '2022-01',
            ),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
