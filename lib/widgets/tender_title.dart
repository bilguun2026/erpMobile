import 'package:flutter/material.dart';
import 'package:erp_1/models/tenderModel.dart'; // Adjust path to where the Tender model is

class TenderTile extends StatelessWidget {
  final Tender tender;
  final VoidCallback onTap; // Callback for tap action

  const TenderTile({super.key, required this.tender, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ListTile(
        title: Text(
          tender.name ?? 'Unnamed Tender',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8.0),
            Text(
                'Description: ${tender.description ?? 'No description provided'}'),
            const SizedBox(height: 4.0),
            Text(
                'Total Coal Quantity: ${tender.totalCoalQuantity ?? 'N/A'} tons'),
            const SizedBox(height: 4.0),
            Text('Origin: ${tender.origin ?? 'Unknown'}'),
            const SizedBox(height: 4.0),
            Text('Destination: ${tender.destination ?? 'Unknown'}'),
            const SizedBox(height: 4.0),
            Text('Deadline: ${tender.deadline ?? 'No deadline'}',
                style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 4.0),
            Text(
              'Status: ${tender.status ?? 'Unknown'}',
              style: TextStyle(
                color: tender.status == 'open' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap, // Trigger onTap when the tile is tapped
      ),
    );
  }
}
