import 'package:erp_1/models/models.dart';
import 'package:erp_1/utils/api.dart';

class PayrollService {
  Future<Payroll?> fetchPayroll(String month, {String? token}) async {
    try {
      final response = await ApiUtils.get('payrolls/$month/', token: token);
      return Payroll.fromJson(response);
    } catch (e) {
      print('Error fetching payroll: $e');
      return null;
    }
  }

  Future<void> updatePayrollStatus(String payrollId, String status,
      {String? token}) async {
    try {
      final data = {'status': status};
      await ApiUtils.patch('payrolls/$payrollId/', data, token: token);
    } catch (e) {
      print('Error updating payroll status: $e');
    }
  }
}
