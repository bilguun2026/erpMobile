import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiUtils {
  // Base URL of your backend
  static const String baseUrl = 'http://202.70.34.58:8000';

  // GET request with optional token
  static Future<dynamic> get(String endpoint, {String? token}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers(token),
      );

      return _processResponse(response);
    } catch (error) {
      _logError('GET', endpoint, error);
      return {'error': 'Failed to connect to the server'};
    }
  }

  // POST request with optional token and body
  static Future<dynamic> post(String endpoint, Map<String, dynamic> body,
      {String? token}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers(token),
        body: jsonEncode(body),
      );

      return _processResponse(response);
    } catch (error) {
      _logError('POST', endpoint, error);
      return {'error': 'Failed to connect to the server'};
    }
  }

  // PUT request (for updating data)
  static Future<dynamic> put(String endpoint, Map<String, dynamic> body,
      {String? token}) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers(token),
        body: jsonEncode(body),
      );

      return _processResponse(response);
    } catch (error) {
      _logError('PUT', endpoint, error);
      return {'error': 'Failed to connect to the server'};
    }
  }

  // DELETE request (for deleting data)
  static Future<dynamic> delete(String endpoint, {String? token}) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers(token),
      );

      return _processResponse(response);
    } catch (error) {
      _logError('DELETE', endpoint, error);
      return {'error': 'Failed to connect to the server'};
    }
  }

  // Helper to add headers, including authorization token if available
  static Map<String, String> _headers(String? token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': token != null ? 'Bearer $token' : '',
    };
  }

  // Helper to process the response and handle errors
  static dynamic _processResponse(http.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final errorResponse = {
        'error': 'Error ${response.statusCode}: ${response.body}'
      };
      _logError(
          'HTTP Response', response.request?.url.toString(), errorResponse);
      return errorResponse;
    }
  }

  // Logger for handling and logging errors
  static void _logError(String method, String? endpoint, dynamic error) {
    final errorMessage = 'Error during $method request to $endpoint: $error';

    // Log to console
    print(errorMessage);

    // Optionally, send this to an external logging service in the future
    // Example: Sentry.captureMessage(errorMessage);
  }
}
