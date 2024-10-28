import 'package:erp_1/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:erp_1/models/models.dart';
import 'package:erp_1/utils/salaryService.dart';

class SalaryScreen extends StatefulWidget {
  @override
  _SalaryScreenState createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  List<Salary> salaries = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSalaries();
  }

  Future<void> _fetchSalaries() async {
    setState(() {
      isLoading = true;
    });
    SalaryService service = SalaryService();
    salaries = await service.fetchSalaries();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _refreshSalaries() async {
    await _fetchSalaries();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Salary Details',
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshSalaries,
              child: salaries.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        itemCount: salaries.length,
                        itemBuilder: (context, index) {
                          final salary = salaries[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Base Salary: ${salary.baseSalary}'),
                                  Text('Bonus: ${salary.bonus}'),
                                  Text(
                                      'Travel Allowance: ${salary.travelAllowance}'),
                                  Text(
                                      'Food Allowance: ${salary.foodAllowance}'),
                                  Text(
                                      'Housing Allowance: ${salary.housingAllowance}'),
                                  Text('Deductions: ${salary.deductions}'),
                                  Text('Tax: ${salary.tax}'),
                                  Text(
                                      'Overtime Hours: ${salary.overtimeHours}'),
                                  Text('Overtime Rate: ${salary.overtimeRate}'),
                                  Text('Total Salary: ${salary.totalSalary}'),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : ListView(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('No salary details available'),
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
