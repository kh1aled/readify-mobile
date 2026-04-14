import 'package:flutter/material.dart';
import 'package:readify_app/shared/widgets/layout.dart';
// import 'package:readify_app/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const Layout(),
    );
  }
}
