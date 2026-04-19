import 'package:flutter/material.dart';
import 'package:readify_app/shared/widgets/layout.dart';
import 'package:readify_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:readify_app/shared/services/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // needed for SharedPreferences
  final showOnboarding = !(await PreferencesService.isOnboardingComplete());

  runApp(MyApp(showOnboarding: showOnboarding));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Readify',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D6A65)),
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(fontFamily: 'Manrope'),

          // Body
          bodyLarge: TextStyle(fontFamily: 'Newsreader'),
          bodyMedium: TextStyle(fontFamily: 'Newsreader'),
        ),
      ),
      home: showOnboarding ? const OnboardingScreen() : const Layout(),
    );
  }
}
