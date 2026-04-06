import 'dart:convert';
import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/app_constants.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/shared_preference_helper.dart';
import 'package:flutter/material.dart';

class SessionStorage {
  final SharedPreferenceHelper _preferences;
  DateTime? _tokenExpiryTime;

  SessionStorage(this._preferences);

  bool get isTokenExpiringSoon {
    // Always safe-guard nulls
    if (_tokenExpiryTime == null) {
      log('Token expiry time is null, cannot check expiring soon');
      return false;
    }

    final buffer = const Duration(minutes: 7); // <- Consistent buffer
    final now = DateTime.now();
    final isExpiring = now.isAfter(_tokenExpiryTime!.subtract(buffer));

    log(
      'Token is expiring soon: now = ${now.timeFormat()}, expiry - buffer = ${_tokenExpiryTime!.subtract(buffer).timeFormat()}, remaining = ${_tokenExpiryTime!.difference(now).inMinutes} min => $isExpiring',
    );

    return isExpiring;
  }

  Future<void> setTokenExpiry(DateTime expiryTime) async {
    log('Token expiry time set to $expiryTime');
    _tokenExpiryTime = expiryTime;
    await _preferences.instance.setString(
      AppConstants.tokenExpiryKey,
      expiryTime.toIso8601String(),
    ); // Persist it
  }

  Future<void> loadTokenExpiry() async {
    final expiryString =
        _preferences.instance.getString(AppConstants.tokenExpiryKey);
    if (expiryString != null) {
      final parsed = DateTime.tryParse(expiryString);
      if (parsed != null) {
        _tokenExpiryTime = parsed;
        log('Token expiry restored from storage: $_tokenExpiryTime');
      }
    }
  }

  /// Save refresh token
  Future<void> saveTokens({
    String? accessToken,
    String? refreshToken,
  }) async {
    try {
      if (accessToken != null) {
        await _preferences.instance
            .setString(AppConstants.accessTokenKey, accessToken);
        final expiryTime = getTokenExpiry(accessToken) ??
            DateTime.now().add(const Duration(minutes: 30));
        await setTokenExpiry(expiryTime);
      }
      if (refreshToken != null) {
        await _preferences.instance.setString(
          AppConstants.refreshTokenKey,
          refreshToken,
        );
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
    }
  }

  /// Get access token
  String? get accessToken =>
      _preferences.instance.getString(AppConstants.accessTokenKey);

  /// Get refresh token
  String? get refreshToken =>
      _preferences.instance.getString(AppConstants.refreshTokenKey);

  /// Clear SharedPreferences
  Future<void> clearTokens() async {
    await _preferences.instance.remove(AppConstants.accessTokenKey);
    await _preferences.instance.remove(AppConstants.refreshTokenKey);
    await _preferences.instance.remove(AppConstants.tokenExpiryKey);
    _tokenExpiryTime = null;
  }

  DateTime? getTokenExpiry(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final payloadMap = json.decode(payload);

      if (payloadMap is! Map<String, dynamic>) return null;

      final exp = payloadMap['exp'] as int?;
      if (exp == null) return null;

      return DateTime.fromMillisecondsSinceEpoch(
        exp * 1000,
      ); // exp is in seconds
    } catch (e) {
      debugPrint('Token decode error: $e');
      return null;
    }
  }
}
