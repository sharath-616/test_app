import 'package:flutter/foundation.dart';

class AppController with ChangeNotifier {
  bool _isFirstLaunch = true;
  bool _isLoggedIn = false;
  int _currentOnboardingPage = 0;

  bool get isFirstLaunch => _isFirstLaunch;
  bool get isLoggedIn => _isLoggedIn;
  int get currentOnboardingPage => _currentOnboardingPage;

  void completeOnboarding() {
    _isFirstLaunch = false;
    notifyListeners();
  }

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setOnboardingPage(int page) {
    _currentOnboardingPage = page;
    notifyListeners();
  }
}
