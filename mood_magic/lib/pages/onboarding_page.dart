import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../main_page.dart'; // Import your main page

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome to Mood Magic",
          body: "Discover a new way to manage your mood with Mood Magic.",
          image: Image.asset(
              "assets/onboarding1.png"), // Replace with your image asset
        ),
        PageViewModel(
          title: "Stay Organized",
          body: "Keep track of your emotions, events, and more.",
          image: Image.asset(
              "assets/onboarding2.png"), // Replace with your image asset
        ),
        PageViewModel(
          title: "Connect and Share",
          body: "Connect with friends and share your mood journey.",
          image: Image.asset(
              "assets/onboarding3.png"), // Replace with your image asset
        ),
      ],
      onDone: () {
        // Navigate to the main page after onboarding is complete
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      },
      onSkip: () {
        // Navigate to the main page if the user skips onboarding
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      },
      done: const Text("Get Started"),
      skip: const Text("Skip"),
    );
  }
}
