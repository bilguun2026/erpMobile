import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiUtils {
  static const String baseUrl = 'http://192.168.230.67:8000';

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

  static Future<dynamic> patch(String endpoint, Map<String, dynamic> body,
      {String? token}) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/$endpoint'),
        headers: _headers(token),
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (error) {
      _logError('PATCH', endpoint, error);
      return {'error': 'Failed to connect to the server'};
    }
  }

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

  static Map<String, String> _headers(String? token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': token != null ? 'Bearer $token' : '',
    };
  }

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

  static void _logError(String method, String? endpoint, dynamic error) {
    final errorMessage = 'Error during $method request to $endpoint: $error';
    print(errorMessage);
  }
}
