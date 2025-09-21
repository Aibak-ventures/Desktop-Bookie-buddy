class AppConstants {
  // App Information
  static const String appName = 'Booking Application';
  static const String appVersion = '2.4.0';
  
  // API Configuration
  static const String apiVersion = 'v1';
  static const String contentType = 'application/json';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Timeouts
  static const Duration defaultTimeout = Duration(seconds: 30);
  static const Duration longTimeout = Duration(seconds: 60);
  
  // Storage Keys
  static const String onboardingCompleted = 'onboarding_completed';
  static const String languageCode = 'language_code';
  static const String themeMode = 'theme_mode';
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int maxNameLength = 50;
  
  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  
  // Error Messages
  static const String internetConnectionError = 'Please check your internet connection';
  static const String serverError = 'Server error occurred. Please try again later';
  static const String unknownError = 'An unknown error occurred';
  static const String timeoutError = 'Request timeout. Please try again';
  
  // Success Messages
  static const String loginSuccess = 'Logged in successfully';
  static const String registrationSuccess = 'Registration completed successfully';
  static const String updateSuccess = 'Updated successfully';
  
  // Validation Messages
  static const String emailRequired = 'Email is required';
  static const String passwordRequired = 'Password is required';
  static const String nameRequired = 'Name is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String passwordTooShort = 'Password must be at least $minPasswordLength characters';
  static const String passwordTooLong = 'Password must be less than $maxPasswordLength characters';
  static const String confirmPasswordMismatch = 'Passwords do not match';
  
  // Feature Flags
  static const bool enableBiometric = true;
  static const bool enableDarkMode = true;
  static const bool enableNotifications = true;
}

class ApiEndpoints {
  // Authentication
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String logout = 'auth/logout';
  static const String refreshToken = 'auth/refresh';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';
  static const String verifyEmail = 'auth/verify-email';
  
  // User Profile
  static const String profile = 'user/profile';
  static const String updateProfile = 'user/profile';
  static const String changePassword = 'user/change-password';
  static const String uploadAvatar = 'user/avatar';
  
  // Bookings
  static const String bookings = 'bookings';
  static const String createBooking = 'bookings';
  static const String updateBooking = 'bookings/{id}';
  static const String cancelBooking = 'bookings/{id}/cancel';
  static const String bookingDetails = 'bookings/{id}';
  
  // Search & Discovery
  static const String search = 'search';
  static const String categories = 'categories';
  static const String popular = 'popular';
  static const String recommendations = 'recommendations';
}

class AssetPaths {
  // Images
  static const String _images = 'assets/images/';
  static const String logo = '${_images}logo.png';
  static const String placeholder = '${_images}placeholder.png';
  static const String avatar = '${_images}default_avatar.png';
  
  // Icons
  static const String _icons = 'assets/icons/';
  static const String home = '${_icons}home.svg';
  static const String search = '${_icons}search.svg';
  static const String profile = '${_icons}profile.svg';
  static const String booking = '${_icons}booking.svg';
  
  // Animations
  static const String _animations = 'assets/animations/';
  static const String loading = '${_animations}loading.json';
  static const String success = '${_animations}success.json';
  static const String error = '${_animations}error.json';
  static const String empty = '${_animations}empty.json';
}

class RouteNames {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String bookings = '/bookings';
  static const String bookingDetails = '/booking-details';
  static const String search = '/search';
  static const String error = '/error';
  static const String networkError = '/network-error';
  static const String notFound = '/not-found';
}
