import 'package:bookie_buddy_web/core/network/endpoints/api_config.dart';

class NotificationsEndpoints {
  static const _root = '${ApiConfig.v3}/notifications/device-tokens/';
  static const register = '${_root}register/';
  static const remove = '${_root}remove/';
  static const updateShop = '${_root}update-shop/';
}
