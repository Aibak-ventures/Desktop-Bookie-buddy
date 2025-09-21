import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_token.dart';
import '../network/uri_mixin.dart';

abstract class TokenRefreshService {
  Future<UserToken?> refreshToken(String refreshToken);
  Future<void> clearTokens();
  Future<UserToken?> getCurrentToken();
}

class TokenRefreshServiceImpl with UriMixin implements TokenRefreshService {
  final Dio _dio;

  TokenRefreshServiceImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<UserToken?> refreshToken(String refreshToken) async {
    try {
      // Create a separate Dio instance for token refresh to avoid infinite loops
      final refreshDio = Dio();
      refreshDio.options.baseUrl = _dio.options.baseUrl;
      
      final response = await refreshDio.post(
        getUri('auth/refresh'),
        data: {
          'refresh_token': refreshToken,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final newToken = UserToken.fromJson(response.data);
        
        // Save the new token to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', response.data.toString());
        
        return newToken;
      }
    } catch (e) {
      // If refresh fails, clear tokens and force re-authentication
      await clearTokens();
      rethrow;
    }
    
    return null;
  }

  @override
  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

  @override
  Future<UserToken?> getCurrentToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final tokenString = prefs.getString('user_token');
      
      if (tokenString != null) {
        // This is a simplified implementation
        // In a real app, you'd properly parse the stored JSON
        return null; // Return parsed token
      }
    } catch (e) {
      return null;
    }
    
    return null;
  }
}
