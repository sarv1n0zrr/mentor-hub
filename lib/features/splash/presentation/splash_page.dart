import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentor_hub/features/auth/presentation/pages/auth_page.dart';
import 'package:mentor_hub/features/common/presentation/pages/base_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Lottie.asset(
          'assets/animations/Animation - 1739417240420.json',
        ),
      ),
      nextScreen: _getNextScreen(),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 300,
      duration: 2500,
      backgroundColor: Colors.white,
    );
  }

  Widget _getNextScreen() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const AuthPage();
    } else {
      return const BasePage();
    }
  }
}
