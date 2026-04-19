class OnboardingPageData {
  final String title;
  final String? titleItalic;
  final String? titleSuffix;
  final String subtitle;
  final String imagePath;

  const OnboardingPageData({
    required this.title,
    this.titleItalic,
    this.titleSuffix,
    required this.subtitle,
    required this.imagePath,
  });
}

final List<OnboardingPageData> onboardingPages = [
  OnboardingPageData(
    title: 'Your personal ',
    titleItalic: 'library',
    titleSuffix: ',\nrefined for\nthe modern mind.',
    subtitle: 'Discover Your Next Favorite Book',
    imagePath: '',  // Screen 1 has no image — text-only hero
  ),
  OnboardingPageData(
    title: 'Read Anytime, Anywhere',
    subtitle:
        'Take your library wherever you go.\nEnjoy seamless reading across all your devices.',
    imagePath: 'assets/images/onboarding/man_studying.png',
  ),
  OnboardingPageData(
    title: 'Track your progress',
    subtitle:
        'Build better reading habits –\nand watch your library grow over time.',
    imagePath: 'assets/images/onboarding/track_progress.png',
  ),
];