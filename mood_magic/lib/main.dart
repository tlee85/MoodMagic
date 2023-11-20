import 'package:flutter/material.dart';
import 'main_page.dart';
import 'pages/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasCompletedOnboarding =
        true; // Set this flag based on whether onboarding is completed

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Check if onboarding is completed and navigate accordingly
      home: hasCompletedOnboarding ? const MainPage() : const OnboardingPage(),
    );
  }
}
