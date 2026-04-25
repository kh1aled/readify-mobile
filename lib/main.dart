import 'package:flutter/material.dart';
import 'package:readify_app/features/auth/presentation/provider/auth_provider.dart';
import 'package:readify_app/features/auth/presentation/screens/login_screen.dart';
import 'package:readify_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:readify_app/shared/services/preferences_service.dart';
import 'package:readify_app/shared/widgets/layout.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final showOnboarding = !(await PreferencesService.isOnboardingComplete());

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider()..checkLoginStatus(),
      child: MyApp(showOnboarding: showOnboarding),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;
  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

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
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          return _getStartScreen(authProvider);
        },
      ),
    );
  }

  Widget _getStartScreen(AuthProvider authProvider) {
    if (authProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (showOnboarding) {
      return const OnboardingScreen();
    }

    if (!authProvider.isLoggedIn) {
      return const LoginScreen();
    }

    return const Layout();
  }
}
