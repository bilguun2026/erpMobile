import 'package:flutter/material.dart';
import 'package:erp_1/models/tenderModel.dart'; // Adjust path

class JobDetailScreen extends StatelessWidget {
  final Job job;

  JobDetailScreen({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCombinedDetailSection(
              title: 'Job Details',
              details: {
                'Job Coal Quantity': '${job.jobCoalQuantity ?? 'N/A'} tons',
                'Origin': job.origin ?? 'N/A',
                'Destination': job.destination ?? 'N/A',
                'Status': job.jobStatus ?? 'N/A',
              },
            ),
            SizedBox(height: 20),
            Text(
              'Transports',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...(job.transports
                    ?.map((transport) => _buildTransportDetail(transport)) ??
                [Text('No transports available')]),
          ],
        ),
      ),
    );
  }

  Widget _buildCombinedDetailSection({
    required String title,
    required Map<String, String> details,
  }) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            ...details.entries.map((entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(entry.value),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportDetail(Transport transport) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCombinedDetailSection(
              title: 'Transport Details',
              details: {
                'Transport Weight':
                    '${transport.transportWeight ?? 'N/A'} tons',
                'Start Date': transport.startDate ?? 'N/A',
                'End Date': transport.endDate ?? 'N/A',
                'Status': transport.status ?? 'N/A',
              },
            ),
          ],
        ),
      ),
    );
  }
}
