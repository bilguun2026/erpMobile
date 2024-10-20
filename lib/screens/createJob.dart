import 'package:flutter/material.dart';
import 'package:erp_1/utils/api.dart'; // API utility
import 'package:erp_1/utils/storage.dart'; // For token storage

class CreateJobScreen extends StatefulWidget {
  @override
  _CreateJobScreenState createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? origin;
  String? destination;
  int? jobCoalQuantity;
  String? status;
  bool _isLoading = false;

  // Method to handle job creation logic
  Future<void> _createJob() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String? token = await StorageUtils.getToken();

      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> jobData = {
        'name': name,
        'origin': origin,
        'destination': destination,
        'job_coal_quantity': jobCoalQuantity,
        'status': status,
      };

      try {
        final response = await ApiUtils.post('jobs/', jobData, token: token);
        if (response['error'] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating job: ${response['error']}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Job created successfully!')),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating job: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Job'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Job Name'),
                onSaved: (value) {
                  name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Origin'),
                onSaved: (value) {
                  origin = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the origin';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Destination'),
                onSaved: (value) {
                  destination = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the destination';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Job Coal Quantity (tons)'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  jobCoalQuantity = int.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job coal quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _createJob,
                      child: Text('Create Job'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
