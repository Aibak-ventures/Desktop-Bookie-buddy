import 'package:bookie_buddy_web/core/network/endpoints/api_config.dart';

/// API paths for Product endpoints (v4)
class ProductEndpoints {
  static const _root = '${ApiConfig.v4}/products/';

  // CRUD Operations
  static const products = '${_root}products/'; // List & Create
  static String productDetail(int id) => '${_root}products/$id/'; // Get detail
  static String updateProduct(int id) => '${_root}products/$id/'; // Update
  static String deleteProduct(int id) => '${_root}products/$id/'; // Delete

  // Product Variants
  static String productVariants(int productId) =>
      '${_root}products/$productId/variants/';
  static String createProductVariant(int productId) =>
      '${_root}products/$productId/variants/';
  static String productVariantDetail(int productId, int variantId) =>
      '${_root}products/$productId/variants/$variantId/';
  static String updateProductVariant(int productId, int variantId) =>
      '${_root}products/$productId/variants/$variantId/';
  static String deleteProductVariant(int productId, int variantId) =>
      '${_root}products/$productId/variants/$variantId/';

  // Product Materials
  static String productMaterials(int productId) =>
      '${_root}products/$productId/materials/';
  static String addProductMaterial(int productId) =>
      '${_root}products/$productId/materials/';
  static String removeProductMaterial(int productId, int materialId) =>
      '${_root}products/$productId/materials/$materialId/';

  // Availability & Stock
  static String checkAvailability(int productId) =>
      '${_root}products/$productId/check-availability/';
  static String updateStock(int productId) =>
      '${_root}products/$productId/update-stock/';
  static const lowStockProducts = '${_root}products/low-stock/';
  static const outOfStockProducts = '${_root}products/out-of-stock/';

  // Search & Filter
  static const searchProducts = '${_root}products/search/';
  static const filterByCategory = '${_root}products/filter-by-category/';
  static const filterByPrice = '${_root}products/filter-by-price/';
}
