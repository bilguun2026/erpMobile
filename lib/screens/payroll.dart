import 'package:erp_1/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:erp_1/models/models.dart';
import 'package:erp_1/utils/payrollService.dart';

class PayrollScreen extends StatefulWidget {
  final String month;
  PayrollScreen({required this.month});

  @override
  _PayrollScreenState createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  Payroll? payroll;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPayroll();
  }

  Future<void> _fetchPayroll() async {
    setState(() {
      isLoading = true;
    });
    PayrollService service = PayrollService();
    payroll = await service.fetchPayroll(widget.month);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Payroll Details',
      body: Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : payroll != null
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Salary: ${payroll!.totalSalary}'),
                        Text('Status: ${payroll!.status}'),
                        Text('Paid On: ${payroll!.paidOn ?? "Not Paid"}'),
                        // Add other fields as necessary
                      ],
                    ),
                  )
                : Center(child: Text('Payroll details not available')),
      ),
    );
  }
}
