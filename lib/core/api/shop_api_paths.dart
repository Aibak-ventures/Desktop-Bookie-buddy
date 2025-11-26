import 'package:bookie_buddy_web/core/api/api_config.dart';

class ShopApiPaths {
  static const _root = '${ApiConfig.v3}/shop/';
  static const availableShops = '${_root}available-shops/';
  static const privacySettings = '${_root}shop-privacy-settings/';
  static const updateSettings = '${_root}shop-settings/update-settings/';
}
