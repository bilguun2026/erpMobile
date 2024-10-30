import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget?
      floatingActionButton; // Add floatingActionButton as an optional parameter

  const CustomScaffold({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton, // Accept the floatingActionButton as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Ай Хө ERP system',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.auto_graph),
              title: const Text('Үндсэн'),
              onTap: () async {
                await _dashboard(context); // Navigate to dashboard
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Тендер'),
              onTap: () async {
                await _tender(context); // Navigate to tenders
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Ажил'),
              onTap: () async {
                await _job(context); // Navigate to tenders
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await _logout(context); // Perform logout
              },
            ),
          ],
        ),
      ),
      body: body, // Use the body passed from the screen
      floatingActionButton:
          floatingActionButton, // Include the floating action button if passed
    );
  }

  // Define the logout functionality
  Future<void> _logout(BuildContext context) async {
    // Implement your logout logic here (e.g., removing token)
    Navigator.pushReplacementNamed(context, '/login');
  }

  Future<void> _tender(BuildContext context) async {
    Navigator.pushReplacementNamed(context, '/tenders');
  }

  Future<void> _job(BuildContext context) async {
    Navigator.pushReplacementNamed(context, '/jobs');
  }

  Future<void> _dashboard(BuildContext context) async {
    Navigator.pushReplacementNamed(context, '/dashboard');
  }
}
