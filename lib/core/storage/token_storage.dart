import 'dart:convert';
import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static SharedPreferences _preferences = SharedPreferenceHelper.instance;
  static DateTime? _tokenExpiryTime;

  /// Initialize the SharedPreferences instance
  // static Future<void> init() async {
  //   _preferences = await SharedPreferences.getInstance();
  // }

  static bool get isTokenExpiringSoon {
    if (_tokenExpiryTime == null) {
      log("Token expiry time is null");
      if (accessToken == null) {
        log("Access token is null");
        return false;
      }
      final expiryTime = getTokenExpiry(accessToken!) ??
          DateTime.now().add(
            const Duration(minutes: 30),
          );
      setTokenExpiry(expiryTime);
    }
    if (_tokenExpiryTime == null) {
      log("Token expiry time is still null");
      return false;
    }
    final time = DateTime.now()
        .isAfter(_tokenExpiryTime!.subtract(const Duration(minutes: 7)));
    log("Token is expiring soon: ${DateTime.now().timeFormat()} - ${_tokenExpiryTime!.subtract(const Duration(minutes: 5)).timeFormat()} = $time. remaining: ${_tokenExpiryTime!.difference(DateTime.now()).inMinutes}");
    return time;
  }

  static void setTokenExpiry(DateTime expiryTime) {
    log("Token expiry time set to $expiryTime");
    _tokenExpiryTime = expiryTime;
  }

  /// Save refresh token
  static Future<void> saveTokens(
      {String? accessToken, String? refreshToken}) async {
    try {
      if (accessToken != null)
        await _preferences.setString('accessToken', accessToken);
      if (refreshToken != null)
        await _preferences.setString('refreshToken', refreshToken);

      final expiryTime = getTokenExpiry(accessToken!) ??
          DateTime.now().add(
            const Duration(minutes: 30),
          );
      setTokenExpiry(expiryTime);
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  /// Get access token
  static String? get accessToken => _preferences.getString('accessToken');

  /// Get refresh token
  static String? get refreshToken => _preferences.getString('refreshToken');

  /// Clear SharedPreferences
  static Future<void> clearTokens() async {
    await _preferences.remove('accessToken');
    await _preferences.remove('refreshToken');
    _tokenExpiryTime = null;
  }

  static DateTime? getTokenExpiry(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload =
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final payloadMap = json.decode(payload);

      if (payloadMap is! Map<String, dynamic>) return null;

      final exp = payloadMap['exp'];
      if (exp == null) return null;

      return DateTime.fromMillisecondsSinceEpoch(
          exp * 1000); // exp is in seconds
    } catch (e) {
      print('Token decode error: $e');
      return null;
    }
  }
}
