import 'package:flutter/material.dart';
import 'package:readify_app/core/services/service_locator.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/auth/data/auth_remote_data_source.dart';
import 'package:readify_app/features/auth/data/auth_repository_impl.dart';
import 'package:readify_app/features/auth/presentation/auth_provider.dart';
import 'package:readify_app/features/auth/presentation/screens/login_screen.dart';
import 'package:readify_app/features/auth/presentation/screens/register_screen.dart';
import 'package:readify_app/features/home/presentation/screens/home_screen.dart';
import 'package:readify_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:readify_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:readify_app/shared/services/preferences_service.dart';
import 'package:readify_app/shared/widgets/layout.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  final showOnboarding = !(await PreferencesService.isOnboardingComplete());
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(
        AuthRepositoryImpl(
          remoteDataSource: AuthRemoteDataSource(),
          tokenStorage: TokenStorageService(sharedPreferences),
        ),
      ),
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
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(title: 'Home'),
        Layout.routeName: (_) => const Layout(),
        ProfileScreen.routeName: (_) => const ProfileScreen(),
      },
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
    if (authProvider.status == AuthStatus.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (showOnboarding) {
      return const OnboardingScreen();
    }

    if (authProvider.status != AuthStatus.authenticated) {
      return const LoginScreen();
    }

    return const Layout();
  }
}
