import 'package:flutter/material.dart';
import 'package:erp_1/models/tenderModel.dart'; // Adjust the path

class TenderDetailScreen extends StatelessWidget {
  final Tender tender;

  TenderDetailScreen({required this.tender});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tender.name ?? 'Tender Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Name: ${tender.name ?? 'N/A'}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Description: ${tender.description ?? 'N/A'}'),
            SizedBox(height: 10),
            Text('Total Coal Quantity: ${tender.totalCoalQuantity ?? 'N/A'}'),
            SizedBox(height: 10),
            Text('Origin: ${tender.origin ?? 'N/A'}'),
            SizedBox(height: 10),
            Text('Destination: ${tender.destination ?? 'N/A'}'),
            SizedBox(height: 10),
            Text('Deadline: ${tender.deadline ?? 'N/A'}'),
            SizedBox(height: 10),
            Text('Status: ${tender.status ?? 'N/A'}',
                style: TextStyle(
                    color: tender.status == 'open' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Jobs',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...(tender.jobs?.map((job) => _buildJobCard(job)) ??
                [Text('No jobs available')]),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(Job job) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Job Coal Quantity: ${job.jobCoalQuantity ?? 'N/A'}'),
            SizedBox(height: 5),
            Text('Origin: ${job.origin ?? 'N/A'}'),
            Text('Destination: ${job.destination ?? 'N/A'}'),
            Text('Status: ${job.jobStatus ?? 'N/A'}'),
            SizedBox(height: 10),
            Text('Transports', style: TextStyle(fontWeight: FontWeight.bold)),
            ...(job.transports
                    ?.map((transport) => _buildTransportDetail(transport)) ??
                [Text('No transports available')]),
          ],
        ),
      ),
    );
  }

  Widget _buildTransportDetail(Transport transport) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transport Weight: ${transport.transportWeight ?? 'N/A'}'),
          Text('Start Date: ${transport.startDate ?? 'N/A'}'),
          Text('End Date: ${transport.endDate ?? 'N/A'}'),
          Text('Status: ${transport.status ?? 'N/A'}'),
        ],
      ),
    );
  }
}
