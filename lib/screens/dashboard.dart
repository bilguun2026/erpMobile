import 'package:erp_1/screens/login.dart';
import 'package:flutter/material.dart';
import '../utils/storage.dart'; // For token removal and retrieval
import '../utils/api.dart'; // For making API requests

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? dashboardData;
  String? token;

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  // Fetch token and data from the API
  Future<void> _fetchDashboardData() async {
    try {
      // Retrieve the token using StorageUtils
      token = await StorageUtils.getToken();

      if (token == null) {
        // If no token is found, log the user out
        print("No token found, logging out...");
        _logout(context);
        return;
      }

      // Print the token for debugging
      print("Token found: $token");

      // Use the token to fetch data from the endpoint
      final response = await ApiUtils.get('dashboard/', token: token);

      if (response == null || response.isEmpty) {
        // If the response is empty or invalid, handle gracefully
        print('Empty or invalid response from API');
        _logout(context);
      } else {
        setState(() {
          dashboardData = response;
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching dashboard data: $error');
      // Show an error message instead of logging out immediately
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching dashboard data.')),
      );
    }
  }

  // Logout function
  Future<void> _logout(BuildContext context) async {
    // Remove token using StorageUtils
    await StorageUtils.clearToken();

    // Navigate back to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, // Remove all routes behind
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Dashboard Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                await _logout(context);
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : dashboardData != null
              ? RefreshIndicator(
                  onRefresh: _fetchDashboardData, // Swipe to refresh
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildJobAndTransportList(),
                  ),
                )
              : Center(child: Text('No data available')),
    );
  }

  Widget _buildJobAndTransportList() {
    if (dashboardData == null) return Text('No jobs or transports found.');
    var jobs = dashboardData!['jobs'] ?? [];
    var transports = dashboardData!['transports'] ?? [];

    return ListView.builder(
      itemCount: jobs.length + transports.length,
      itemBuilder: (context, index) {
        if (index < jobs.length) {
          // Display jobs
          var job = jobs[index];
          return Card(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Positioned(
                    top: 15,
                    child: Text(
                      'Job ${job['job_tender_name']}',
                      style: TextStyle(color: Colors.white),
                    )),
              )

              // ListTile(
              //   title: Text('Job ${index + 1}'),
              //   subtitle: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text('Coal Quantity: ${job['job_coal_quantity']} tons'),
              //       Text('Origin: ${job['origin']}'),
              //       Text('Destination: ${job['destination']}'),
              //       Text('Status: ${job['job_status']}'),
              //     ],
              //   ),
              // ),
              );
        } else {
          // Display transports
          var transport = transports[index - jobs.length];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text('Transport ${index + 1 - jobs.length}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Weight: ${transport['transport_weight']} kg'),
                  Text(
                      'Vehicle: ${transport['vehicle_registration_number']} (${transport['vehicle_capacity']} kg)'),
                  Text('Status: ${transport['status']}'),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
