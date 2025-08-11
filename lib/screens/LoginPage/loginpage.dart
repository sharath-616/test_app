// views/login_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/controllers/app_controller.dart';
import 'package:test_app/controllers/auth_controller.dart';
import 'package:test_app/screens/Google%20Verification/google_verification_view.dart';


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<AuthController>(
        builder: (context, authController, _) {
          return Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign in to your\nAccount',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 40),
                _buildTextField(
                  'Enter your email address',
                  onChanged: authController.setEmail,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  'Enter your password',
                  isPassword: true,
                  onChanged: authController.setPassword,
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: authController.isLoading ? null : () async {
                      bool success = await authController.signIn();
                      if (success) {
                        context.read<AppController>().login();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => GoogleVerificationView()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: authController.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OR', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      bool success = await authController.signInWithGoogle();
                      if (success) {
                        context.read<AppController>().login();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => GoogleVerificationView()),
                        );
                      }
                    },
                    icon: Text('G', style: TextStyle(fontWeight: FontWeight.bold)),
                    label: Text('Continue with Google'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(String hint, {bool isPassword = false, Function(String)? onChanged}) {
    return TextField(
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}