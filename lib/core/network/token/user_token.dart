import 'package:shared_preferences/shared_preferences.dart';
import '../../env/env_config.dart';

class UserToken {
  static final UserToken _instance = UserToken._internal();
  factory UserToken() => _instance;
  UserToken._internal();

  Future<Map<String, String>> getHeaders() async {
    final token = await getAccessToken();
    
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(EnvConfig.accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(EnvConfig.refreshTokenKey);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(EnvConfig.accessTokenKey, accessToken);
    await prefs.setString(EnvConfig.refreshTokenKey, refreshToken);
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(EnvConfig.accessTokenKey);
    await prefs.remove(EnvConfig.refreshTokenKey);
    await prefs.remove(EnvConfig.userDataKey);
  }

  Future<bool> hasValidToken() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
