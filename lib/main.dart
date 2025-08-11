
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/screens/HomeView/home_view.dart';
import 'package:test_app/screens/LoginPage/loginpage.dart';
import 'package:test_app/screens/OnBoard%20View/onboard_view.dart';
import 'controllers/app_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/home_controller.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: MaterialApp(
        title: 'Flutter MVC App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'SF Pro Display',
        ),
        home: Consumer<AppController>(
          builder: (context, appController, _) {
            if (appController.isFirstLaunch) {
              return OnboardingView();
            } else if (!appController.isLoggedIn) {
              return LoginView();
            } else {
              return HomeView();
            }
          },
        ),
      ),
    );
  }
}











