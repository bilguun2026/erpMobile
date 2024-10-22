import 'package:flutter/material.dart';
import 'package:erp_1/models/Models.dart'; // Adjust path

class JobTile extends StatelessWidget {
  final Job job;
  final VoidCallback onTap; // Callback for tapping the job

  JobTile({required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ListTile(
        title: Text(
          job.id ?? 'Unnamed Job',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            Text('Origin: ${job.origin ?? 'N/A'}'),
            Text('Destination: ${job.destination ?? 'N/A'}'),
            Text('Status: ${job.jobStatus ?? 'N/A'}'),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
