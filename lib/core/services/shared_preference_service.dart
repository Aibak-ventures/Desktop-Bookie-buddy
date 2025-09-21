import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _prefs;

  SharedPreferenceService(this._prefs);

  // Auth Tokens
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _nextTokenKey = 'next_token';
  static const String _referralCodeKey = 'referral_code';

  // Access Token
  Future<void> saveAccessToken(String token) async {
    await _prefs.setString(_accessTokenKey, token);
  }

  Future<String?> getAccessToken() async {
    return _prefs.getString(_accessTokenKey);
  }

  Future<void> removeAccessToken() async {
    await _prefs.remove(_accessTokenKey);
  }

  // Refresh Token
  Future<void> saveRefreshToken(String token) async {
    await _prefs.setString(_refreshTokenKey, token);
  }

  Future<String?> getRefreshToken() async {
    return _prefs.getString(_refreshTokenKey);
  }

  Future<void> removeRefreshToken() async {
    await _prefs.remove(_refreshTokenKey);
  }

  // Next Token
  Future<void> saveNextToken(String token) async {
    await _prefs.setString(_nextTokenKey, token);
  }

  Future<String?> getNextToken() async {
    return _prefs.getString(_nextTokenKey);
  }

  Future<void> removeNextToken() async {
    await _prefs.remove(_nextTokenKey);
  }

  // Referral Code
  Future<void> saveReferralCode(String code) async {
    await _prefs.setString(_referralCodeKey, code);
  }

  Future<String?> getReferralCode() async {
    return _prefs.getString(_referralCodeKey);
  }

  Future<void> removeReferralCode() async {
    await _prefs.remove(_referralCodeKey);
  }

  // Clear all auth data
  Future<void> clearAuthData() async {
    await removeAccessToken();
    await removeRefreshToken();
    await removeNextToken();
    await removeReferralCode();
  }
}
