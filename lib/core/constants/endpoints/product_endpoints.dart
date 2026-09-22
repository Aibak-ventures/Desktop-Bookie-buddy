import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class ProductEndpoints {
  const ProductEndpoints();

  static const _root = '${ApiConfig.v3}/service/';
  static const _transferRoot = '${_root}transfer-product/';
  static const _bookingsRootV3 = '${ApiConfig.v3}/bookings/bookings/';

  final productSearch = '${_root}product-search/';
  final productsRoot = '${_root}products/';
  final availableProducts = '${_bookingsRootV3}desktop-available-products/';

  String productById(int id) => '${productsRoot}$id/';
  String monthlySummary(int id) => '$productsRoot/monthly-summary/$id/';
  String productBookings(int productId) =>
      '${productsRoot}product-bookings/$productId/';

  // Product Variants
  String productVariants(int productId) => '$productsRoot$productId/variants/';
  String productVariantById(int productId, int variantId) =>
      '$productsRoot$productId/variants/$variantId/';
  String productOrVariant(int productId, {int? variantId}) =>
      '$productsRoot$productId/${variantId == null ? '' : 'variants/$variantId/'}';

  // Product Transfer
  final matchProduct = '${_transferRoot}match-product/';
  final transferHistory = '${_transferRoot}transfer-history/';
  final transferStock = '${_transferRoot}transfer-stock/';
}
