import 'package:flutter/material.dart';
import 'package:erp_1/utils/api.dart'; // Adjust the path for your API utility
import 'package:erp_1/utils/storage.dart'; // Adjust the path for storage utility (token)

class CreateTenderScreen extends StatefulWidget {
  @override
  _CreateTenderScreenState createState() => _CreateTenderScreenState();
}

class _CreateTenderScreenState extends State<CreateTenderScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? description;
  int? totalCoalQuantity;
  String? origin;
  String? destination;
  DateTime? deadline;
  bool _isLoading = false;

  // Method to handle tender creation logic
  Future<void> _createTender() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Get the token for authenticated requests
      String? token = await StorageUtils.getToken();

      // Show loading indicator
      setState(() {
        _isLoading = true;
      });

      // Format deadline as 'yyyy-mm-dd'
      String? formattedDeadline;
      if (deadline != null) {
        formattedDeadline =
            "${deadline!.year}-${deadline!.month.toString().padLeft(2, '0')}-${deadline!.day.toString().padLeft(2, '0')}";
      }

      // Create tender payload
      Map<String, dynamic> tenderData = {
        'name': name,
        'description': description,
        'total_coal_quantity': totalCoalQuantity,
        'origin': origin,
        'destination': destination,
        'deadline': formattedDeadline,
      };

      try {
        // Use the ApiUtils class to make a POST request to the backend
        final response =
            await ApiUtils.post('tenders/', tenderData, token: token);

        // Handle the response, check for errors
        if (response['error'] != null) {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Error creating tender: ${response['error']}')),
          );
        } else {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tender created successfully!')),
          );
          // Navigate back to the previous screen
          Navigator.pop(context);
        }
      } catch (e) {
        // Show error message in case of failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating tender: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Тендер үүсгэх'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Tender Name'),
                onSaved: (value) {
                  name = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the tender name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  description = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Total Coal Quantity (tons)'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  totalCoalQuantity = int.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the total coal quantity';
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
              // Date picker for deadline
              TextFormField(
                decoration: InputDecoration(labelText: 'Deadline'),
                onTap: () async {
                  FocusScope.of(context)
                      .requestFocus(FocusNode()); // Hide keyboard
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      deadline = pickedDate;
                    });
                  }
                },
                readOnly: true,
                controller: TextEditingController(
                    text: deadline != null
                        ? "${deadline!.year}-${deadline!.month.toString().padLeft(2, '0')}-${deadline!.day.toString().padLeft(2, '0')}"
                        : ''),
              ),
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _createTender,
                      child: Text('Create Tender'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
