import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const OnlineLearningApp());
}

class OnlineLearningApp extends StatelessWidget {
  const OnlineLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Learning App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const OnboardingScreen(),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(
            physics: const BouncingScrollPhysics(),
            scrollbars: false,
          ),
          child: child!,
        );
      },
    );
  }
}
