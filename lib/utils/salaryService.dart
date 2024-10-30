import 'package:erp_1/models/models.dart';
import 'package:erp_1/utils/api.dart';
import 'package:erp_1/utils/storage.dart';

class SalaryService {
  Future<List<Salary>> fetchSalaries() async {
    try {
      String? token = await StorageUtils.getToken();
      final response = await ApiUtils.get('salaries/', token: token);

      // Check if the response is a list and map each item to a Salary instance
      if (response is List) {
        return response.map((json) => Salary.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } catch (e) {
      print('Error fetching salaries: $e');
      return [];
    }
  }
}
