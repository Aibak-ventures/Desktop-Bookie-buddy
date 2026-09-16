import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class ShopEndpoints {
  const ShopEndpoints();

  static const _root = '${ApiConfig.v3}/shop/';

  final availableShops = '${_root}available-shops/';
  final privacySettings = '${_root}shop-privacy-settings/';
  final updateSettings = '${_root}shop-settings/update-settings/';

  // Shop Summary
  String allShopSummary({required int year, required int month, int? shopId}) {
    final params = shopId != null ? '?shop_id=$shopId' : '';
    return '${_root}all-shop-summary/$year/$month/$params';
  }

  // Activity Logs
  final activityLogs = '${_root}activity-logs/';
  final recentActivities = '${_root}activity-logs/recent/';
  String activityLogsByDate(String date) => '${_root}activity-logs/$date/';
}
