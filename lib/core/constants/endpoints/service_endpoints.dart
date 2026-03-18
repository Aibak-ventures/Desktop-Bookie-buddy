import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class ServiceEndpoints {
  static const _root = '${ApiConfig.v3}/service/';
  static const selected = '${_root}selected/';
  static const productSearch = '${_root}product-search/';
  static const productsRoot = '${_root}products/';

  static String productById(String id) => '$productsRoot$id/';
  static String monthlySummary(String id) =>
      '$productsRoot/monthly-summary/$id/';

  // Product Transfer
  static const _transferRoot = '${_root}transfer-product/';
  static const matchProduct = '${_transferRoot}match-product/';
  static const transferHistory = '${_transferRoot}transfer-history/';
  static const transferStock = '${_transferRoot}transfer-stock/';
}
