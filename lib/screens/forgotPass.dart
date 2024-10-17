import 'package:flutter/material.dart';
import '../utils/api.dart'; // API utility
import '../utils/dialog.dart'; // Dialog utility for success/error messages

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _isObscured = true; // Toggle password visibility

  // Function to reset password via API
  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    // Make an API call to reset the password
    final response = await ApiUtils.post('reset-password/', {
      'username': _usernameController.text,
      'new_password': _newPasswordController.text,
    });

    setState(() {
      _isLoading = false;
    });

    if (response['message'] != null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Амжилттай'),
          content: Text('Нууц үг амжилттай солигдлоо. Дахин нэвтэрнэ үү!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop(); // Close the dialog
                Navigator.pushReplacementNamed(
                    context, '/login'); // Navigate to login
              },
            ),
          ],
        ),
      );
    } else {
      DialogUtils.showErrorDialog(
        context,
        response['error'] ?? 'Нууц үг солих үед алдаа гарлаа.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Нууц үг солих'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username Input
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Нэвтрэх нэр',
                hintText: 'Нэвтрэх нэрээ оруулна уу.',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // New Password Input
            TextField(
              controller: _newPasswordController,
              obscureText: _isObscured,
              decoration: InputDecoration(
                labelText: 'Шинэ нууц үг',
                border: OutlineInputBorder(),
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
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _resetPassword,
                    child: Text('Нууц үг солих'),
                  ),
          ],
        ),
      ),
    );
  }
}
