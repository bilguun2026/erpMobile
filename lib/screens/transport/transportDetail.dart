import 'package:flutter/material.dart';
import 'package:erp_1/models/Models.dart'; // Adjust the path to your Transport model

class TransportDetailScreen extends StatelessWidget {
  final Transport transport;

  const TransportDetailScreen({
    Key? key,
    required this.transport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transport Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transport ID: ${transport.id}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Remaining Job Quantity: ${transport.remainingJobQuantity}'),
            Text('Percentage: ${transport.percentage}%'),
            Text('Start Date: ${transport.startDate}'),
            Text('End Date: ${transport.endDate}'),
            Text('Transport Weight: ${transport.transportWeight} kg'),
            Text('Status: ${transport.status}'),
            SizedBox(height: 10),
            Divider(),
            Text(
              'Associated Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Job ID: ${transport.job}'),
            Text('Vehicle ID: ${transport.vehicle}'),
            Text('Driver ID: ${transport.driver}'),
            Text('User ID: ${transport.user}'),
            SizedBox(height: 10),
            Divider(),
            Text(
              'Supervisor Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Point A Note: ${transport.pointANote ?? "No note"}'),
            Text('Point B Note: ${transport.pointBNote ?? "No note"}'),
            Text(
                'General Supervisor Note: ${transport.generalSupervisorNote ?? "No note"}'),
          ],
        ),
      ),
    );
  }
}
