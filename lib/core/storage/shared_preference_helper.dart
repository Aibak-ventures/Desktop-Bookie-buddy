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

  static String? getString(String key) {
    return instance.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await instance.setBool(key, value);
  }

  static bool? getBool(String key) {
    return instance.getBool(key);
  }

  static Future<void> setShopId(int value) async {
    await instance.setInt('shopId', value);
  }

  static int? get getShopId => instance.getInt('shopId');

  static Future<void> clearShopId() async {
    await instance.remove('shopId');
  }
}
