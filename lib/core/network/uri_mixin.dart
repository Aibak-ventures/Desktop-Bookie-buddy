import '../env/env_config.dart';

/// Mixin that provides URL building functionality
/// This centralizes how we construct API URLs throughout the app
mixin UriMixin {
  /// Builds a complete API URL with proper formatting
  /// 
  /// Example usage:
  /// ```dart
  /// // Simple endpoint
  /// getUri('auth/login') 
  /// // -> https://api.bookingapp.com/api/v1/auth/login
  /// 
  /// // With path parameters
  /// getUri('users/{userId}/profile', pathParams: {'userId': '123'})
  /// // -> https://api.bookingapp.com/api/v1/users/123/profile
  /// 
  /// // With query parameters
  /// getUri('bookings', queryParameters: {'page': '1', 'limit': '10'})
  /// // -> https://api.bookingapp.com/api/v1/bookings?page=1&limit=10
  /// ```
  String getUri(
    String path, {
    String version = 'v1',
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
  }) {
    // Replace {param} in path with actual values
    // Example: 'users/{userId}' becomes 'users/123'
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        path = path.replaceAll('{$key}', value);
      });
    }

    // Build the complete URI
    final uri = Uri(
      scheme: 'https',
      host: EnvConfig.baseUrl,
      path: '/api/$version/$path',
      queryParameters: queryParameters,
    );

    return uri.toString();
  }

  /// Builds a URL without the API prefix (for special endpoints)
  /// 
  /// Example:
  /// ```dart
  /// getRawUri('health-check')
  /// // -> https://api.bookingapp.com/health-check
  /// ```
  String getRawUri(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? pathParams,
  }) {
    // Replace path parameters
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        path = path.replaceAll('{$key}', value);
      });
    }

    final uri = Uri(
      scheme: 'https',
      host: EnvConfig.baseUrl,
      path: '/$path',
      queryParameters: queryParameters,
    );

    return uri.toString();
  }

  /// Builds a URL for file uploads or downloads
  /// 
  /// Example:
  /// ```dart
  /// getFileUri('uploads/avatar/{userId}', pathParams: {'userId': '123'})
  /// // -> https://api.bookingapp.com/api/v1/uploads/avatar/123
  /// ```
  String getFileUri(
    String path, {
    String version = 'v1',
    Map<String, String>? pathParams,
  }) {
    if (pathParams != null) {
      pathParams.forEach((key, value) {
        path = path.replaceAll('{$key}', value);
      });
    }

    final uri = Uri(
      scheme: 'https',
      host: EnvConfig.baseUrl,
      path: '/api/$version/$path',
    );

    return uri.toString();
  }
}
