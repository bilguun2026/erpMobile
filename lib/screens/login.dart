import 'package:erp_1/screens/forgotPass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
import '../utils/api.dart'; // API utility
import '../utils/storage.dart'; // Token storage utility
import '../widgets/button.dart';
import '../utils/dialog.dart'; // Dialog utility

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;
  bool _isLoading = false;
  bool _rememberMe = false; // Track Remember Me state

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials(); // Check if the username and password are remembered on startup
  }

  // Load remembered username and password from SharedPreferences
  Future<void> _loadRememberedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRemembered = prefs.getBool('remember_me') ?? false;

    if (isRemembered) {
      String? savedUsername = prefs.getString('saved_username');
      String? savedPassword = prefs.getString('saved_password');

      if (savedUsername != null && savedPassword != null) {
        _usernameController.text = savedUsername;
        _passwordController.text = savedPassword;
        setState(() {
          _rememberMe = true; // Automatically check the "Remember Me" box
        });
      }
    }
  }

  // Function to handle login API call
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    // Data to send to the API
    final response = await ApiUtils.post('/api/token/', {
      'username': _usernameController.text,
      'password': _passwordController.text,
    });

    setState(() {
      _isLoading = false;
    });

    if (response['access'] != null) {
      // Save the token for future use
      await StorageUtils.saveToken(response['access']);

      print(response['access']);

      // Save username and password if Remember Me is checked
      if (_rememberMe) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('remember_me', true);
        await prefs.setString('saved_username', _usernameController.text);
      } else {
        // If "Remember Me" is unchecked, remove saved credentials
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('remember_me');
        await prefs.remove('saved_username');
      }

      // Navigate to the dashboard or home page
      // DialogUtils.showSuccessDialog(context, 'Logged in successfully');
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      // Show error if login fails
      DialogUtils.showErrorDialog(context, response['error'] ?? 'Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo and header
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/Vector.svg', // Adjust path
                        height: 100, // Adjust size
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Ай Хө',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'ERP System',
                        style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),

                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Нэвтрэх',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // Username Input
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Нэвтрэх нэр',
                    hintText: 'Нэвтрэх нэр оруулах',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // Password Input
                TextField(
                  controller: _passwordController,
                  obscureText: _isObscured,
                  decoration: InputDecoration(
                    labelText: 'Нууц үг',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()),
                        );
                      },
                      child: Text('Нууц үг мартсан'),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                _isLoading
                    ? CircularProgressIndicator()
                    : GradientButton(
                        text: 'Нэвтрэх',
                        onPressed: _login, // Call the login function
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
