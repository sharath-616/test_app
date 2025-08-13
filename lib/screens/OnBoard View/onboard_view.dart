import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/controllers/app_controller.dart';
import 'package:test_app/screens/LoginPage/loginpage.dart';

class OnboardingView extends StatelessWidget {
  final PageController _pageController = PageController();

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome to soon!',
      'subtitle': 'Lorem ipsum is simply dummy text of the printing!',
      'emoji': '👨‍🍳'
    },
    {
      'title': 'Lorem ipsum is simply dummy text of the printing!',
      'subtitle':
          'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
      'emoji': '🧑‍🍳'
    },
    {
      'title': 'It is a long established fact that a reader will',
      'subtitle':
          'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
      'emoji': '👨‍🍳'
    },
  ];

  OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AppController>(
        builder: (context, appController, _) {
          return Column(
            children: [
              Expanded(
 
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                  appController.setOnboardingPage(index);
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    return _buildOnboardingPage(_onboardingData[index]);
                  },
                ),
              ),
              _buildBottomSection(context, appController),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOnboardingPage(Map<String, String> data) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(40),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 500, 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  data['emoji']!,
                  style: TextStyle(fontSize: 80),
                ),
              ),
            ),
            SizedBox(height: 60),
            Text(
              data['title']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
              data['subtitle']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, AppController appController) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: appController.currentOnboardingPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: appController.currentOnboardingPage == index
                      ? Colors.orange
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                if (appController.currentOnboardingPage <
                    _onboardingData.length - 1) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  appController.completeOnboarding();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginView()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                appController.currentOnboardingPage ==
                        _onboardingData.length - 1
                    ? 'Get Started'
                    : 'Next',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
                                                                                                  