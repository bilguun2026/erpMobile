import 'package:flutter/material.dart';
import 'package:erp_1/models/tenderModel.dart'; // Adjust path to where the Tender model is

class TenderTile extends StatelessWidget {
  final Tender tender;
  final VoidCallback onTap; // Callback for tap action

  TenderTile({required this.tender, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ListTile(
        title: Text(
          tender.name ?? 'Unnamed Tender',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text(
                'Description: ${tender.description ?? 'No description provided'}'),
            SizedBox(height: 4.0),
            Text(
                'Total Coal Quantity: ${tender.totalCoalQuantity ?? 'N/A'} tons'),
            SizedBox(height: 4.0),
            Text('Origin: ${tender.origin ?? 'Unknown'}'),
            SizedBox(height: 4.0),
            Text('Destination: ${tender.destination ?? 'Unknown'}'),
            SizedBox(height: 4.0),
            Text('Deadline: ${tender.deadline ?? 'No deadline'}',
                style: TextStyle(color: Colors.red)),
            SizedBox(height: 4.0),
            Text(
              'Status: ${tender.status ?? 'Unknown'}',
              style: TextStyle(
                color: tender.status == 'open' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap, // Trigger onTap when the tile is tapped
      ),
    );
  }
}
