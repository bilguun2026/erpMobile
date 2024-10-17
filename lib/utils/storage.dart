import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static const String _tokenKey = 'auth_token'; // Use the same key consistently

  // Save the token to local storage
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token); // Save token with the correct key
  }

  // Get the token from local storage
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey); // Retrieve token with the same key
  }

  // Remove the token (for logout)
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey); // Remove token with the correct key
  }

  // Clear token (for logout or other purposes)
  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey); // Use the correct key
  }
}
