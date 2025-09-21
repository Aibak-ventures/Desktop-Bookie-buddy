import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  // Base URLs
  static String get baseUrl {
    final envUrl = dotenv.env['BASE_URL'];
    if (envUrl != null && envUrl.isNotEmpty) return envUrl;
    
    // Fallback to hardcoded URLs based on environment
    switch (environment) {
      case 'development':
        return 'http://dev.bookiebuddy.in';
      case 'staging':
        return 'http://dev.bookiebuddy.in';
      case 'production':
        return 'https://flutter.bookiebuddy.in';
      default:
        return 'http://dev.bookiebuddy.in';
    }
  }
  
  static String get apiBaseUrl => baseUrl; // Alias for consistency
  static String get bucketBaseUrl => dotenv.env['BUCKET_BASE_URL'] ?? '';
  static String get healthApiUrl => dotenv.env['HEALTH_CHECK_URL'] ?? '';
  static String get socketUrl => dotenv.env['SOCKET_URL'] ?? '';

  // API Endpoints based on your existing structure
  static const String loginEndpoint = '/api/v3/auth/login/';
  static const String refreshTokenEndpoint = '/api/token/refresh';
  static const String userProfileEndpoint = '/api/v3/auth/profile/';
  static const String changePasswordEndpoint = '/api/v1/auth/change-password';
  static const String secretLoginEndpoint = '/api/v1/auth/wallet-login';
  static const String updateSecretPasswordEndpoint = '/api/v1/auth/update-secondary-password';

  // Environment
  static String get environment => dotenv.env['ENV'] ?? 'development';
  static bool get isDevelopment => environment == 'development';
  static bool get isProduction => environment == 'production';
  static bool get isStaging => environment == 'staging';

  // Payment Keys
  static String get razorpayKey => dotenv.env['RAZORPAY_KEY'] ?? '';
  static String get stripePublishableKey => dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? '';

  // Debug & Monitoring
  static String get sentryDsn => dotenv.env['SENTRY_DSN'] ?? '';
  static bool get enableDebugLogs => _getBoolValue('ENABLE_DEBUG_LOGS', isDevelopment);
  static bool get enableNetworkLogs => _getBoolValue('ENABLE_NETWORK_LOGS', isDevelopment);
  static bool get enableMockData => _getBoolValue('ENABLE_MOCK_DATA', false);

  // App Update URLs
  static String get androidUpdateUrl => dotenv.env['APP_UPDATE_URL_ANDROID'] ?? '';
  static String get iosUpdateUrl => dotenv.env['APP_UPDATE_URL_IOS'] ?? '';

  // API Keys
  static String get googleMapsApiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';

  // Feature Flags
  static bool get enableBiometricAuth => _getBoolValue('ENABLE_BIOMETRIC_AUTH', !isDevelopment);
  static bool get enablePushNotifications => _getBoolValue('ENABLE_PUSH_NOTIFICATIONS', !isDevelopment);
  static bool get enableNewUI => _getBoolValue('ENABLE_NEW_UI', true);

  // Database
  static String get databaseName => dotenv.env['DATABASE_NAME'] ?? 'booking_app.db';

  // App Info
  static String get appName => dotenv.env['APP_NAME'] ?? 'Booking App';
  static String get appSuffix => dotenv.env['APP_SUFFIX'] ?? '';

  // Storage Keys (Environment-specific)
  static String get accessTokenKey => '${environment}_access_token';
  static String get refreshTokenKey => '${environment}_refresh_token';
  static String get userDataKey => '${environment}_user_data';

  // Timeouts
  static Duration get connectTimeout {
    if (isDevelopment) return const Duration(milliseconds: 60000);
    if (isStaging) return const Duration(milliseconds: 45000);
    return const Duration(milliseconds: 30000);
  }

  static Duration get receiveTimeout => connectTimeout;
  static Duration get sendTimeout => connectTimeout;

  // Helper method to parse boolean values from .env
  static bool _getBoolValue(String key, bool defaultValue) {
    final value = dotenv.env[key]?.toLowerCase();
    if (value == null) return defaultValue;
    return value == 'true' || value == '1' || value == 'yes';
  }

  // Utility methods
  static void printCurrentConfig() {
    print('🌍 Current Environment: $environment');
    print('🔗 Base URL: $baseUrl');
    print('🐛 Debug Logs: $enableDebugLogs');
    print('📱 App Name: $appName');
    print('⏱️ Connect Timeout: ${connectTimeout.inMilliseconds}ms');
    print('🔐 Enable Biometric: $enableBiometricAuth');
    print('💳 Razorpay Key: ${razorpayKey.isNotEmpty ? '${razorpayKey.substring(0, 10)}...' : 'Not set'}');
  }

  // Validation method
  static bool validateConfig() {
    final requiredKeys = [
      'BASE_URL',
      'ENV',
    ];

    for (final key in requiredKeys) {
      if (dotenv.env[key] == null || dotenv.env[key]!.isEmpty) {
        print('❌ Missing required environment variable: $key');
        return false;
      }
    }

    print('✅ Environment configuration is valid');
    return true;
  }
}
