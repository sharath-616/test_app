import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/screens/Google%20Verification/google_verification_view.dart';
import 'package:test_app/screens/HomeView/home_view.dart';
import 'package:test_app/screens/LoginPage/loginpage.dart';
import 'package:test_app/screens/OnBoard%20View/onboard_view.dart';
import 'controllers/app_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/home_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        title: 'Test App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'SF Pro Display',
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => Consumer<AppController>(
                builder: (context, appController, _) {
                  print('Building /home route: isFirstLaunch=${appController.isFirstLaunch}, isLoggedIn=${appController.isLoggedIn}');
                  if (appController.isFirstLaunch) {
                    return  OnboardingView();
                  } else if (!appController.isLoggedIn) {
                    return const LoginView();
                  } else {
                    return const HomeView();
                  }
                },
              ),
          '/google_verification': (context) => const GoogleVerificationView(),
        },
      ),
    );
  }
}