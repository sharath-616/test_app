import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/controllers/app_controller.dart';
import 'package:test_app/controllers/auth_controller.dart';
import 'package:test_app/controllers/home_controller.dart'; 
import 'package:test_app/screens/HomeView/home_view.dart';
import 'package:test_app/screens/LoginPage/loginpage.dart';
import 'package:test_app/screens/OnBoard%20View/onboard_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => AppController()),
        ChangeNotifierProvider(create: (_) => HomeController()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/onboarding',
        routes: {
          '/onboarding': (context) =>  OnboardingView(),
          '/login': (context) => const LoginView(),
          '/home': (context) => const HomeView(),
        },
      ),
    );
  }
}                                        