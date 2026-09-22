import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class NotificationsEndpoints {
  const NotificationsEndpoints();

  static const _root = '${ApiConfig.v3}/notifications/device-tokens/';

  final register = '${_root}register/';
  final remove = '${_root}remove/';
  final updateShop = '${_root}update-shop/';
}
