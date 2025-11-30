import 'package:bookie_buddy_web/core/api/api_config.dart';

class ShopApiPaths {
  static const _root = '${ApiConfig.v3}/shop/';
  static const availableShops = '${_root}available-shops/';
  static const privacySettings = '${_root}shop-privacy-settings/';
  static const updateSettings = '${_root}shop-settings/update-settings/';

  // Activity Logs
  static const activityLogs = '${_root}activity-logs/';
  static const recentActivities = '${_root}activity-logs/recent/';
  static String activityLogsByDate(String date) =>
      '${_root}activity-logs/$date/';
}
