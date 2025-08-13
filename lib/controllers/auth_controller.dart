import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_app/api/api_data.dart';

class AuthController with ChangeNotifier {
  bool _isLoading = false;
  String _email = '';
  String _password = '';
  String? _errorMessage;
  String? _accessToken;
  String? _refreshToken;

  bool get isLoading => _isLoading;
  String get email => _email;
  String get password => _password;
  String? get errorMessage => _errorMessage;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  void setEmail(String email) {
    _email = email;
    _errorMessage = null;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    _errorMessage = null;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  bool validateForm(GlobalKey<FormState> formKey) {
    final isValid = formKey.currentState?.validate() ?? false;
    print('Form validation result: $isValid');
    return isValid;
  }

  Future<bool> signIn(GlobalKey<FormState> formKey) async {
    if (!validateForm(formKey)) {
      print('Form validation failed');
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('Sending login request to $loginapi with email: $_email');
      final response = await http.post(
        Uri.parse(loginapi),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': _email,
          'password': _password,
        }),
      );

      print('SignIn Response status: ${response.statusCode}');
      print('SignIn Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('SignIn Response data: $responseData');
        if (responseData['status'] == true) { 
          _accessToken = responseData['access_token'];
          _refreshToken = responseData['refresh_token'];
          print('Login successful, access_token: $_accessToken');
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = responseData['message'] ?? 'Login failed';
          print('Login failed: $_errorMessage');
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        _errorMessage = 'Error: ${response.statusCode}. Please try again.';
        print('Login error: $_errorMessage');
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Network error: $e';
      print('Network error: $_errorMessage');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    print('Simulating Google Sign-In');
    await Future.delayed(const Duration(seconds: 2));
    print('Google Sign-In successful (simulated)');

    _isLoading = false;
    notifyListeners();
    return true;
  }
}