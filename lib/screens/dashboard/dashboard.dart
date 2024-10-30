import 'package:erp_1/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/storage.dart'; // For token removal and retrieval
import '../../utils/api.dart'; // For making API requests
import 'package:erp_1/widgets/appBar.dart'; // Import CustomScaffold

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

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
      token = await StorageUtils.getToken();

      if (token == null) {
        print("No token found, logging out...");
        _logout(context);
        return;
      }

      final response = await ApiUtils.get('dashboard/', token: token);

      if (response == null || response.isEmpty) {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching dashboard data.')),
      );
    }
  }

  Future<void> _logout(BuildContext context) async {
    await StorageUtils.clearToken();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Dashboard",
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : dashboardData != null
              ? RefreshIndicator(
                  onRefresh: _fetchDashboardData,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildJobAndTransportList(),
                  ),
                )
              : const Center(child: Text('No data available')),
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job, double screenWidth) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.white,
              elevation: 4,
              child: Container(
                width: screenWidth * 1.0,
                height: 200,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30), // space for the tab
                    Text("Нийт тонн: ${job['job_coal_quantity']}",
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text("Эхлэх хугацаа:"),
                        Spacer(),
                        Text("Дуусах хугацаа:"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text("${job['startDate']}"),
                        const Spacer(),
                        Text("${job['endDate']}"),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text("Хаанаас: ${job['origin']}"),
                    const SizedBox(height: 8),
                    Text("Хаашаа: ${job['destination']}"),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 30,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: const Text(
                  'Ажил',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text('${job['job_tender_name']}',
                    style: const TextStyle(fontSize: 16)),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: job['percentage'] / 100,
                strokeWidth: 6,
                backgroundColor: Colors.white,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 76, 244, 54)),
              ),
            ),
            Positioned(
              right: 35,
              bottom: 40,
              child: Text(
                "${job["percentage"]}% ",
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Text("${job['job_status']}"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildJobAndTransportList() {
    if (dashboardData == null)
      return const Text('No jobs or transports found.');
    var jobs = dashboardData!['jobs'] ?? [];
    var transports = dashboardData!['transports'] ?? [];
    double screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: jobs.length + transports.length,
      itemBuilder: (context, index) {
        if (index < jobs.length) {
          var job = jobs[index];
          return _buildJobCard(job, screenWidth);
        } else {
          var transport = transports[index - jobs.length];
          return _buildTransportCard(transport, screenWidth);
        }
      },
    );
  }

  Widget _buildTransportCard(
      Map<String, dynamic> transport, double screenWidth) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            elevation: 4,
            child: Container(
              width: screenWidth * 1.0,
              height: 400,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30), // space for the tab
                  Text("Нийт тонн: ${transport['transport_weight']}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  const Row(children: [
                    Text("Эхлэх хугацаа:"),
                    Spacer(),
                    Text("Дуусах хугацаа:"),
                  ]),
                  const SizedBox(height: 8),
                  Row(children: [
                    Text("${transport['startDate']}"),
                    const Spacer(),
                    Text("${transport['endDate']}"),
                  ]),
                  const SizedBox(height: 16),
                  _buildTransportProgress(transport, screenWidth),
                  const SizedBox(height: 16),
                  Text(
                      "Тээврийн хэрэгсийн улсын дугаар: ${transport['vehicle_registration_number']}"),
                  const SizedBox(height: 8),
                  Text(
                      "Тээврийн хэрэгслийн даац: ${transport['vehicle_capacity']}"),
                  const SizedBox(height: 8),
                  Text(
                    "Тээврийн хэрэгслийн аюулгүй байдал: ${transport['vehicle_safety'] == true ? 'Аюулгүй' : 'Асуудалтай'}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  _buildNoteButtons(transport),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 30,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const Text(
                'Тээвэрлэлт',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text('${transport['job_tender_name']}',
                  style: const TextStyle(fontSize: 16)),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text("${transport['status']}"),
          ),
        ],
      ),
    );
  }

  Widget _buildTransportProgress(
      Map<String, dynamic> transport, double screenWidth) {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: LinearProgressIndicator(
                value: transport['percentage'] / 100,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            left: (screenWidth - 40) * (transport['percentage'] / 100),
            top: 0,
            child: const Icon(
              Icons.directions_car,
              size: 30,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteButtons(Map<String, dynamic> transport) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            _showNoteDialog(
              context,
              'А тэмдэглэл',
              transport['point_a_note'] != null
                  ? transport['point_a_note']['note']
                  : 'Тэмдэглэл байхгүй байна',
            );
          },
          child: const Text('А тэмдэглэл'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            _showNoteDialog(
              context,
              'Б тэмдэглэл',
              transport['point_b_note'] != null
                  ? transport['point_b_note']['note']
                  : 'Тэмдэглэл байхгүй байна',
            );
          },
          child: const Text('Б тэмдэглэл'),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            _showNoteDialog(
              context,
              'Ерөнхий тэмдэглэл',
              transport['general_supervisor_note'] != null
                  ? transport['general_supervisor_note']['note']
                  : 'Тэмдэглэл байхгүй байна',
            );
          },
          child: const Text('Ерөнхий'),
        ),
      ],
    );
  }

  void _showNoteDialog(BuildContext context, String title, String note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(note),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
