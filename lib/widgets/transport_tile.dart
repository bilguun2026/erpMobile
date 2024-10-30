import 'package:flutter/material.dart';
import 'package:erp_1/models/Models.dart'; // Adjust the path to Transport model

class TransportTile extends StatelessWidget {
  final Transport transport;
  final VoidCallback onTap;

  const TransportTile({
    Key? key,
    required this.transport,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      child: ListTile(
        onTap: onTap,
        title: Text(
          'Transport ID: ${transport.id}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Remaining Quantity: ${transport.remainingJobQuantity}'),
            Text('Weight: ${transport.transportWeight} kg'),
            Text('Status: ${transport.status}'),
            Text('Start Date: ${transport.startDate}'),
            Text('End Date: ${transport.endDate}'),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
