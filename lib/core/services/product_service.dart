import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/api/api_paths.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';

/// Service class for Product API operations
class ProductService {
  Dio get _dio => DioClient.dio;

  /// Get paginated list of products
  Future<CustomResponseModel> getProducts({
    int page = 1,
    String? search,
    String? category,
    double? minPrice,
    double? maxPrice,
     
  }) async {
    try {
      log('🔄 Fetching products - Page: $page, Search: $search');

      final response = await _dio.get(
        ApiPaths.products.products,
        queryParameters: {
          'page': page,
          if (search != null && search.isNotEmpty) 'search': search,
          if (category != null && category.isNotEmpty) 'category': category,
          if (minPrice != null) 'min_price': minPrice,
          if (maxPrice != null) 'max_price': maxPrice,
        },
      );

      log('✅ Products API Response: ${response.realUri}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error fetching products: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Get product details
  Future<CustomResponseModel> getProductDetails(int id) async {
    try {
      final response = await _dio.get(ApiPaths.products.productDetail(id));
      log('✅ Product details: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error getting product details: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Create a new product
  Future<CustomResponseModel> createProduct(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        ApiPaths.products.products,
        data: data,
      );
      log('✅ Product created: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error creating product: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Update an existing product
  Future<CustomResponseModel> updateProduct(
      int id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(
        ApiPaths.products.updateProduct(id),
        data: data,
      );
      log('✅ Product updated: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error updating product: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Delete a product
  Future<CustomResponseModel> deleteProduct(int id) async {
    try {
      final response = await _dio.delete(ApiPaths.products.deleteProduct(id));
      log('✅ Product deleted: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error deleting product: $e', stackTrace: stack);
      rethrow;
    }
  }

  // =============== Product Variants ===============

  /// Get product variants
  Future<CustomResponseModel> getProductVariants(int productId) async {
    try {
      final response =
          await _dio.get(ApiPaths.products.productVariants(productId));
      log('✅ Product variants: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error getting product variants: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Create product variant
  Future<CustomResponseModel> createProductVariant(
    int productId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.post(
        ApiPaths.products.createProductVariant(productId),
        data: data,
      );
      log('✅ Product variant created: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error creating product variant: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Update product variant
  Future<CustomResponseModel> updateProductVariant(
    int productId,
    int variantId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.patch(
        ApiPaths.products.updateProductVariant(productId, variantId),
        data: data,
      );
      log('✅ Product variant updated: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error updating product variant: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Delete product variant
  Future<CustomResponseModel> deleteProductVariant(
      int productId, int variantId) async {
    try {
      final response = await _dio.delete(
        ApiPaths.products.deleteProductVariant(productId, variantId),
      );
      log('✅ Product variant deleted: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error deleting product variant: $e', stackTrace: stack);
      rethrow;
    }
  }

  // =============== Product Materials ===============

  /// Get product materials
  Future<CustomResponseModel> getProductMaterials(int productId) async {
    try {
      final response =
          await _dio.get(ApiPaths.products.productMaterials(productId));
      log('✅ Product materials: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error getting product materials: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Add product material
  Future<CustomResponseModel> addProductMaterial(
    int productId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.post(
        ApiPaths.products.addProductMaterial(productId),
        data: data,
      );
      log('✅ Product material added: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error adding product material: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Remove product material
  Future<CustomResponseModel> removeProductMaterial(
      int productId, int materialId) async {
    try {
      final response = await _dio.delete(
        ApiPaths.products.removeProductMaterial(productId, materialId),
      );
      log('✅ Product material removed: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error removing product material: $e', stackTrace: stack);
      rethrow;
    }
  }

  // =============== Availability & Stock ===============

  /// Check product availability
  Future<CustomResponseModel> checkAvailability(int productId) async {
    try {
      final response =
          await _dio.get(ApiPaths.products.checkAvailability(productId));
      log('✅ Product availability: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error checking availability: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Update product stock
  Future<CustomResponseModel> updateStock(
      int productId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(
        ApiPaths.products.updateStock(productId),
        data: data,
      );
      log('✅ Product stock updated: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error updating stock: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Get low stock products
  Future<CustomResponseModel> getLowStockProducts() async {
    try {
      final response = await _dio.get(ApiPaths.products.lowStockProducts);
      log('✅ Low stock products: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error getting low stock products: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Get out of stock products
  Future<CustomResponseModel> getOutOfStockProducts() async {
    try {
      final response = await _dio.get(ApiPaths.products.outOfStockProducts);
      log('✅ Out of stock products: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error getting out of stock products: $e', stackTrace: stack);
      rethrow;
    }
  }

  // =============== Search & Filter ===============

  /// Search products
  Future<CustomResponseModel> searchProducts({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiPaths.products.searchProducts,
        queryParameters: {
          'q': query,
          'page': page,
        },
      );
      log('✅ Product search results: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error searching products: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Filter products by category
  Future<CustomResponseModel> filterByCategory({
    required String category,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiPaths.products.filterByCategory,
        queryParameters: {
          'category': category,
          'page': page,
        },
      );
      log('✅ Products filtered by category: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error filtering by category: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Filter products by price range
  Future<CustomResponseModel> filterByPrice({
    required double minPrice,
    required double maxPrice,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiPaths.products.filterByPrice,
        queryParameters: {
          'min_price': minPrice,
          'max_price': maxPrice,
          'page': page,
        },
      );
      log('✅ Products filtered by price: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error filtering by price: $e', stackTrace: stack);
      rethrow;
    }
  }
}
