import 'package:flutter/foundation.dart';

class AuthController with ChangeNotifier {
  bool _isLoading = false;
  String _email = '';
  String _password = '';

  bool get isLoading => _isLoading;
  String get email => _email;
  String get password => _password;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<bool> signIn() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
    return true;
  }
}
