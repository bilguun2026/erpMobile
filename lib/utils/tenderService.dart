import 'package:erp_1/models/tenderModel.dart'; // Adjust the path to your Tender model
import 'package:erp_1/utils/api.dart'; // Adjust the path to your ApiUtils
import 'package:erp_1/utils/storage.dart'; // Adjust the path to your StorageUtils

class TenderService {
  Future<List<Tender>> fetchTenders() async {
    // Get the saved token from storage
    String? token = await StorageUtils.getToken();

    // Fetch tenders from the API using ApiUtils
    final response = await ApiUtils.get('/tenders/', token: token);

    if (response is List) {
      return response.map((json) => Tender.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tenders');
    }
  }
}
