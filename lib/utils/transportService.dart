import 'package:erp_1/models/Models.dart'; // Adjust the path to your Transport model
import 'package:erp_1/utils/api.dart'; // Adjust the path to your ApiUtils
import 'package:erp_1/utils/storage.dart'; // Adjust the path to your StorageUtils

class TransportService {
  // Fetch all transports
  Future<List<Transport>> fetchTransports() async {
    try {
      // Get the authentication token
      String? token = await StorageUtils.getToken();

      // Call the API to get transports
      final response = await ApiUtils.get('transports/', token: token);
      print('Raw response: $response'); // Print raw response

      // Check if the response is actually a list
      if (response is! List<dynamic>) {
        throw Exception('Unexpected response format: $response');
      }

      // Parse the response into a list of Transport objects
      List<dynamic> transportsJson = response;
      return transportsJson.map((json) => Transport.fromJson(json)).toList();
    } catch (error) {
      print('Error in fetchTransports: $error');
      throw error;
    }
  }

  // Create a new transport
  Future<Transport?> createTransport(Map<String, dynamic> transportData) async {
    try {
      // Get the authentication token
      String? token = await StorageUtils.getToken();

      // Call the API to create a transport
      final response =
          await ApiUtils.post('transports/', transportData, token: token);

      // Check if there was an error in the response
      if (response['error'] != null) {
        throw Exception('Error creating transport: ${response['error']}');
      }

      // Parse and return the created Transport object
      return Transport.fromJson(response);
    } catch (error) {
      print('Error in createTransport: $error');
      throw error;
    }
  }

  // Fetch a single transport by ID (optional if needed)
  Future<Transport?> getTransportById(String transportId) async {
    try {
      String? token = await StorageUtils.getToken();
      final response =
          await ApiUtils.get('transports/$transportId/', token: token);

      if (response['error'] != null) {
        throw Exception('Error fetching transport: ${response['error']}');
      }

      return Transport.fromJson(response);
    } catch (error) {
      print('Error in getTransportById: $error');
      throw error;
    }
  }

  // Update a transport (optional if needed)
  Future<Transport?> updateTransport(
      String transportId, Map<String, dynamic> transportData) async {
    try {
      String? token = await StorageUtils.getToken();
      final response = await ApiUtils.put(
          'transports/$transportId/', transportData,
          token: token);

      if (response['error'] != null) {
        throw Exception('Error updating transport: ${response['error']}');
      }

      return Transport.fromJson(response);
    } catch (error) {
      print('Error in updateTransport: $error');
      throw error;
    }
  }

  // Delete a transport (optional if needed)
  Future<void> deleteTransport(String transportId) async {
    try {
      String? token = await StorageUtils.getToken();
      final response =
          await ApiUtils.delete('transports/$transportId/', token: token);

      if (response['error'] != null) {
        throw Exception('Error deleting transport: ${response['error']}');
      }
    } catch (error) {
      print('Error in deleteTransport: $error');
      throw error;
    }
  }
}
