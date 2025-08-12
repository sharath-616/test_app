
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_app/Api/api_data.dart';

class AuthController with ChangeNotifier {
  bool _isLoading = false;
  String _email = '';
  String _password = '';
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String get email => _email;
  String get password => _password;
  String? get errorMessage => _errorMessage;

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
    return formKey.currentState?.validate() ?? false;
  }

  Future<bool> signIn(GlobalKey<FormState> formKey) async {
    if (!validateForm(formKey)) return false;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
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
        if (responseData['success'] == true) {
          _isLoading = false;
          notifyListeners();
          return true;
        } else {
          _errorMessage = responseData['message'] ?? 'Login failed';
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        _errorMessage = 'Error: ${response.statusCode}. Please try again.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Network error: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    return true;
  }
}