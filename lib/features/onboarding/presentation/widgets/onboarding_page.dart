// lib/features/onboarding/presentation/widgets/onboarding_page.dart
import 'package:flutter/material.dart';
import 'package:readify_app/features/onboarding/data/onboarding_data.dart';

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPageData data;
  final bool isFirst;

  const OnboardingPageWidget({
    super.key,
    required this.data,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image (screens 2 & 3)
          if (data.imagePath.isNotEmpty) ...[
            Image.asset(data.imagePath, height: 220),
            const SizedBox(height: 40),
          ] else
            const SizedBox(height: 60), // top spacing for text-hero screen

          // Title
          if (isFirst) _buildRichTitle() else _buildSimpleTitle(),

          const SizedBox(height: 16),

          // Subtitle
          Text(
            data.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 15,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRichTitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontFamily: 'Manrope',
          fontSize: 38,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          height: 1.2,
        ),
        children: [
          TextSpan(text: data.title),
          TextSpan(
            text: data.titleItalic,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              color: Color(0xFF2D6A65),   // your brand teal
            ),
          ),
          if (data.titleSuffix != null) TextSpan(text: data.titleSuffix),
        ],
      ),
    );
  }

  Widget _buildSimpleTitle() {
    return Text(
      data.title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontFamily: 'Manrope',
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        height: 1.3,
      ),
    );
  }
}