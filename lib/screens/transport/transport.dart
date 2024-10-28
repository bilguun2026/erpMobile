import 'package:erp_1/screens/transport/transportDetail.dart';
import 'package:flutter/material.dart';
import 'package:erp_1/models/Models.dart'; // Adjust the path
import 'package:erp_1/utils/transportService.dart'; // Adjust the path
import 'package:erp_1/widgets/transport_tile.dart'; // Create a similar widget for Transport display
import 'package:erp_1/widgets/appBar.dart'; // CustomScaffold
import 'package:erp_1/screens/transport/createTransport.dart'; // Create Transport Screen

class TransportScreen extends StatefulWidget {
  @override
  _TransportScreenState createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  List<Transport>? transportList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTransports();
  }

  // Method to fetch transports
  Future<void> _fetchTransports() async {
    setState(() {
      _isLoading = true;
    });
    try {
      transportList = await TransportService().fetchTransports();
      print(transportList);
    } catch (e, stackTrace) {
      print('Error fetching transports: $e');
      print('Stack trace: $stackTrace');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method to refresh transports
  Future<void> _refreshTransports() async {
    await _fetchTransports();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Transports",
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : transportList != null
              ? RefreshIndicator(
                  onRefresh: _refreshTransports,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: transportList!.length,
                      itemBuilder: (context, index) {
                        final transport = transportList![index];
                        return TransportTile(
                          transport: transport,
                          onTap: () {
                            // Navigate to TransportDetailScreen when a transport is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransportDetailScreen(
                                        transport: transport,
                                      )),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              : Center(child: Text('No transports available')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Create Transport Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTransportScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Create Transport',
      ),
    );
  }
}
