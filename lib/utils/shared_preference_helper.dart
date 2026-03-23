import 'package:bookie_buddy_web/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences _preferences;

  SharedPreferenceHelper(this._preferences);

  SharedPreferences get instance {
    return _preferences;
  }

  Future<void> clearAll() async {
    await instance.clear();
  }

  Future<void> setShopId(int value) async {
    await instance.setInt(AppConstants.shopIdKey, value);
  }

  int? get getShopId => instance.getInt(AppConstants.shopIdKey);

  Future<void> clearShopId() async {
    await instance.remove(AppConstants.shopIdKey);
  }
}
