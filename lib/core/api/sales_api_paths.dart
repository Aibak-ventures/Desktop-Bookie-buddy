import 'package:bookie_buddy_web/core/api/api_config.dart';

class SalesApiPaths {
  static const _rootV3 = '${ApiConfig.v3}/sales/';
  static const _rootV4 = '${ApiConfig.v4}/sales/';

  // v3 paths (legacy support)
  static const sales = '${_rootV3}sales/';
  static const updateSale = '${sales}update-sale/';

  // v4 paths (new standard)
  static const salesV4 = '${_rootV4}sales/';
  static String salesDetailV4(int id) => '${salesV4}$id/';
  static String updateSaleV4(int id) => '${salesV4}$id/';
  static String deleteSaleV4(int id) => '${salesV4}$id/';
}
