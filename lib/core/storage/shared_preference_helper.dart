import 'package:bookie_buddy_web/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences _preferences;
  static bool _isInitialized = false;

  static SharedPreferences get instance {
    if (!_isInitialized)
      throw Exception(
          'SharedPreferenceHelper is not initialized, call SharedPreferenceHelper.init() first.');
    return _preferences;
  }

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  static Future<void> clearAll() async {
    await instance.clear();
  }

  static Future<void> setString(String key, String value) async {
    await instance.setString(key, value);
  }

  static String? getString(String key) => instance.getString(key);

  static Future<void> setBool(String key, bool value) async {
    await instance.setBool(key, value);
  }

  static bool? getBool(String key) => instance.getBool(key);

  Future<void> setShopId(int value) async {
    await instance.setInt(AppConstants.shopIdKey, value);
  }

  int? get getShopId => instance.getInt(AppConstants.shopIdKey);

  static Future<void> clearShopId() async {
    await instance.remove(AppConstants.shopIdKey);
  }
}
