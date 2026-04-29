class AppConstants {
  AppConstants._();

  static const double pagePadding = 20.0;
  static const double cardRadius = 12.0;
  static const double buttonRadius = 30.0;
  static const double sectionSpacing = 16.0;
  static const double coverWidthSmall = 90.0;
  static const double coverHeightSmall = 120.0;
  static const double coverWidthMain = 140.0;
  static const double coverHeightMain = 196.0;
  static const double bottomNavHeight = 68.0;
  static const double searchBarHeight = 44.0;
  static const double buyButtonHeight = 52.0;

  static const String BaseUrl = 'https://localhost:7287';
  static const String apiBaseUrl = 'https://localhost:7287/api';


  // Auth endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String refreshTokenEndpoint = '/auth/refresh-token';
  static const String logoutEndpoint = '/auth/logout';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String verifyEmailEndpoint = '/auth/verify-email';
  static const String resendOtpEndpoint = '/auth/resend-otp';
  static const String profileEndpoint = '/users/me';

  // Books endpoints
  static const String booksEndpoint = '/books';
  static const String featuredBooksEndpoint = '/books/featured';
  static const String categoriesEndpoint = '/categories';

  // Token storage keys
  static const String tokenKey = 'jwt_token';
  static const String refreshTokenKey = 'jwt_refresh_token';
  static const String userKey = 'user_data';
}