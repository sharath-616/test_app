import 'package:flutter/material.dart';

class AppController with ChangeNotifier {
  bool _isLoggedIn = false;
  int _currentOnboardingPage = 0;
  bool _isOnboardingCompleted = false;

  bool get isLoggedIn => _isLoggedIn;
  int get currentOnboardingPage => _currentOnboardingPage;
  bool get isOnboardingCompleted => _isOnboardingCompleted;

  void login() {
    _isLoggedIn = true;
    print('AppController: User logged in');
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    print('AppController: User logged out');
    notifyListeners();
  }

  void setOnboardingPage(int page) {
    _currentOnboardingPage = page;
    print('AppController: Current onboarding page set to $page');
    notifyListeners();
  }

  void completeOnboarding() {
    _isOnboardingCompleted = true;
    print('AppController: Onboarding completed');
    notifyListeners();
  }
}