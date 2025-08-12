import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/controllers/app_controller.dart';
import 'package:test_app/controllers/auth_controller.dart';


class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    print('Building LoginView');
    final formKey = GlobalKey<FormState>(); 
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Consumer<AuthController>(
        builder: (context, authController, _) {
          return Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign in to your\nAccount',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (authController.errorMessage != null) ...[
                    Text(
                      authController.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                  ],
                  _buildTextField(
                    'Enter your email address',
                    isEmail: true,
                    validator: authController.validateEmail,
                    onChanged: authController.setEmail,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    'Enter your password',
                    isPassword: true,
                    validator: authController.validatePassword,
                    onChanged: authController.setPassword,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authController.isLoading
                          ? null
                          : () async {
                              bool success = await authController.signIn(formKey);
                              if (success) {
                                context.read<AppController>().login();
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/google_verification',
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
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('OR', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        bool success = await authController.signInWithGoogle();
                        if (success) {
                          context.read<AppController>().login();
                          Navigator.pushReplacementNamed(
                            context,
                            '/google_verification',
                          );
                        }
                      },
                      icon: const Text(
                        'G',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      label: const Text('Continue with Google'),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    bool isPassword = false,
    bool isEmail = false,
    String? Function(String?)? validator,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      obscureText: isPassword,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}