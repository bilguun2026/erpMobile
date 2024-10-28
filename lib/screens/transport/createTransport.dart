import 'package:flutter/material.dart';
import 'package:erp_1/utils/transportService.dart'; // Adjust the path to your TransportService

class CreateTransportScreen extends StatefulWidget {
  @override
  _CreateTransportScreenState createState() => _CreateTransportScreenState();
}

class _CreateTransportScreenState extends State<CreateTransportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _remainingQuantityController = TextEditingController();
  final _transportWeightController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _statusController = TextEditingController();
  final _jobIdController = TextEditingController();
  final _vehicleIdController = TextEditingController();
  final _driverIdController = TextEditingController();
  final _userIdController = TextEditingController();

  bool _isLoading = false;

  // Method to handle the form submission
  Future<void> _createTransport() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Construct transport data from the form fields
      final transportData = {
        "remaining_job_quantity": int.parse(_remainingQuantityController.text),
        "transport_weight": int.parse(_transportWeightController.text),
        "startDate": _startDateController.text,
        "endDate": _endDateController.text,
        "status": _statusController.text,
        "job": _jobIdController.text,
        "vehicle": _vehicleIdController.text,
        "driver": int.parse(_driverIdController.text),
        "user": int.parse(_userIdController.text),
      };

      await TransportService().createTransport(transportData);

      // Show success message and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transport created successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error creating transport: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create transport')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _remainingQuantityController.dispose();
    _transportWeightController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _statusController.dispose();
    _jobIdController.dispose();
    _vehicleIdController.dispose();
    _driverIdController.dispose();
    _userIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Transport'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _remainingQuantityController,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: 'Remaining Job Quantity'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the remaining job quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _transportWeightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Transport Weight (kg)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the transport weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                keyboardType: TextInputType.datetime,
                decoration:
                    InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the end date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _statusController,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the status';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jobIdController,
                decoration: InputDecoration(labelText: 'Job ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the job ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _vehicleIdController,
                decoration: InputDecoration(labelText: 'Vehicle ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the vehicle ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _driverIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Driver ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the driver ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'User ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the user ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _createTransport,
                      child: Text('Create Transport'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
