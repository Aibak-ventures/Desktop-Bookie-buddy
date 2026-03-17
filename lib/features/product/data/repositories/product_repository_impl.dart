import 'dart:developer';

import 'package:bookie_buddy_web/features/booking/domain/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/product/data/datasources/product_action_remote_datasource.dart';
import 'package:bookie_buddy_web/features/product/data/datasources/product_query_remote_datasource.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/transfer_product_history_model/transfer_product_history_model.dart';
import 'package:flutter/material.dart';

class ProductRepositoryImpl implements IProductRepository {
  final ProductQueryRemoteDatasource _queryDatasource;
  final ProductActionRemoteDatasource _actionDatasource;

  ProductRepositoryImpl({
    required ProductQueryRemoteDatasource queryDatasource,
    required ProductActionRemoteDatasource actionDatasource,
  })  : _queryDatasource = queryDatasource,
        _actionDatasource = actionDatasource;

  // CREATE or UPDATE Product
  @override
  Future<void> saveProduct({required ProductRequestModel product}) async {
    try {
      final response = await safeApiCall(
        () => _actionDatasource.addOrUpdateProduct(product: product),
      );
      log('Save product response: ${response.toJson()}');
      if (response.status.isSuccess) {
        return;
      }
      log('Save product failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error saving product: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Delete expense
  // Future<void> deleteExpense(int expenseId) async {
  //   try {
  //     final response = await safeApiCall(
  //       () => _actionService.deleteExpense(expenseId),
  //     );
  //     log('Delete expense response: ${response.toJson()}');
  //     if (response.status.isSuccess) {
  //       return;
  //     }
  //     log('Delete expense failed: ${response.devMessage}');
  //     throw response.message ?? 'Failed to complete operation';
  //   } catch (e, stack) {
  //     log('Error deleting expense: $e', stackTrace: stack);
  //     rethrow;
  //   }
  // }

  // Delete product
  @override
  Future<void> deleteProduct({required int productId, int? variantId}) async {
    try {
      final response = await safeApiCall(
        () => _actionDatasource.deleteProduct(
          productId: productId,
          variantId: variantId,
        ),
      );
      log('Delete product response: ${response.toJson()}');
      if (response.status.isSuccess) {
        return;
      }
      log('Delete product failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error deleting product: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> updateVariant({
    required int productId,
    required int variantId,
    required String? updatedAttribute,
    required int? updatedStock,
    String? externalQrCode,
  }) async {
    try {
      final response = await safeApiCall(
        () => _actionDatasource.updateVariant(
          productId: productId,
          variantId: variantId,
          updatedAttribute: updatedAttribute,
          updatedStock: updatedStock,
          externalQrCode: externalQrCode,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error updating variant: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error updating variant: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> addProductVariants({
    required int productId,
    required String attribute,
    required int stock,
  }) async {
    try {
      final response = await safeApiCall(
        () => _actionDatasource.addProductVariants(
          productId: productId,
          attribute: attribute,
          stock: stock,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error adding product variants: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error adding product variants: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Fetch product info
  @override
  Future<ProductModel> getProductInfo(int productId) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.fetchProductInfo(productId),
      );
      // log('Fetch product info response: ${response.toJson()}');
      if (response.status.isSuccess) {
        return ProductModel.fromJson(response.data);
      }
      log('Fetch product info failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error fetching product info: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Search products
  @override
  Future<PaginationModel<ProductModel>> searchAndFilterProducts({
    int? serviceId,
    required String? query,
    required String? type,
    required int? startPrice,
    required int? endPrice,
    int page = 1,
    bool includeInStockOnly = false,
  }) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.searchAndFilterProducts(
          serviceId: serviceId,
          query: query,
          type: type,
          page: page,
          startPrice: startPrice,
          endPrice: endPrice,
          includeInStockOnly: includeInStockOnly,
        ),
      );
      // log('Search and filter products response: ${response.toJson()}');
      if (response.status.isSuccess) {
        return PaginationModel<ProductModel>.fromJson(
          response.data,
          (json) => ProductModel.fromJson(json as Map<String, dynamic>),
          listFromJson: (data) {
            if (startPrice != null || endPrice != null) {
              return data.where((e) {
                final price = e.price;
                return price != null && price > 0;
              }).toList();
            }
            return data;
          },
        );
      }
      log('Search and filter products failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error fetching products: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Fetch booked dates
  @override
  Future<PaginationModel<BookingsModel>> getProductBookings({
    required int productId,
    int page = 1,
    String? status,
  }) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.getProductBookings(
          productId: productId,
          page: page,
          status: status,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel<BookingsModel>.fromJson(
          response.data,
          (json) => BookingsModel.fromJson(json as Map<String, dynamic>),
        );
      }
      log('Fetch product bookings failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error fetching product bookings: $e', stackTrace: stack);
      rethrow;
    }
  }

  // 📦 Fetch paginated products
  @override
  Future<PaginationModel<ProductModel>> getProductsPaginated({
    int? serviceId,
    required int page,
    bool includeInStockOnly = false,
  }) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.fetchProductsPaginated(
          serviceId: serviceId,
          page: page,
          includeInStockOnly: includeInStockOnly,
        ),
      );
      // log('Fetch products response: ${response.toJson()}');
      if (response.status.isSuccess) {
        return PaginationModel<ProductModel>.fromJson(
          response.data,
          (json) => ProductModel.fromJson(json as Map<String, dynamic>),
        );
      }
      log('Fetch products failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error fetching products: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<PaginationModel<ProductModel>> getAvailableProductsPaginated({
    int? serviceId,
    required int page,
    required String pickupDate,
    required String returnDate,
    required String? nextPageUrl,
    String? query,
    String? type,
    int? startPrice,
    int? endPrice,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
    int? bookingId, // For edit mode
    List<int>? variantIds, // For edit mode
  }) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.fetchAvailableProductsPaginated(
          serviceId: serviceId,
          page: page,
          pickupDate: pickupDate,
          returnDate: returnDate,
          nextPageUrl: nextPageUrl,
          query: query,
          type: type,
          startPrice: startPrice,
          endPrice: endPrice,
          pickupTime: pickupTime,
          returnTime: returnTime,
          bookingId: bookingId,
          variantIds: variantIds,
        ),
      );

      if (response.status.isSuccess) {
        return PaginationModel<ProductModel>.fromJson(
          response.data,
          (json) => ProductModel.fromJson(json as Map<String, dynamic>),
          customJsonParser: (dataJson, itemFromJson) {
            final dataMap = dataJson as Map<String, dynamic>;
            // Products list is nested: data.products[]
            // Each product already contains main_service_name, so we don't override it
            final data = (dataMap['products'] as List<dynamic>?)?.map(
              (item) => itemFromJson(item as Map<String, dynamic>),
            );
            return data?.toList() ?? [];
          },
        );
      }
      log('Fetch available products failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error fetching available products: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Future<CheckAvailabilityModel> checkAvailability({
  //   required String eventDate,
  //   required String returnDate,
  //   required List<int> productIds,
  // }) async {
  //   final response = await safeApiCall(
  //     () => _queryService.checkAvailability(
  //       eventDate: eventDate,
  //       returnDate: returnDate,
  //       productIds: productIds,
  //     ),
  //   );
  // }

  @override
  Future<List<ProductMonthlyDataModel>> getProductGrowthData(
    int productId,
  ) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.fetchProductGrowthData(productId),
      );
      if (response.status.isSuccess) {
        return (response.data as List<dynamic>)
            .map((item) => ProductMonthlyDataModel.fromJson(item))
            .toList();
      }
      log('Fetch product growth data failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error fetching product growth data: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<PaginationModel<ProductModel>> searchAllProducts({
    required String? query,
    required int page,
    bool includeInStockOnly = false,
  }) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.searchAllProducts(
            page: page, query: query, includeInStockOnly: includeInStockOnly),
      );

      if (response.status.isSuccess) {
        return PaginationModel<ProductModel>.fromJson(
          response.data,
          (json) => ProductModel.fromJson(json as Map<String, dynamic>),
        );
      }
      log('Fetch all products failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error searching all products: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<PaginationModel<ProductModel>> getMatchingProductsFromAnotherShop({
    required int fromVariantId,
    required int toShopId,
    int page = 1,
  }) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.fetchMatchingProductsFromAnotherShop(
          fromVariantId: fromVariantId,
          toShopId: toShopId,
          page: page,
        ),
      );

      if (response.status.isSuccess) {
        return PaginationModel<ProductModel>.fromJson(
          response.data,
          (json) => ProductModel.fromJson(json as Map<String, dynamic>),
        );
      }
      log('Fetch matching products failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error fetching matching products: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> transferProductToAnotherShop({
    required int fromVariantId,
    required int toShopId,
    required int transferQuantity,
    int? toProductId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _actionDatasource.transferProductToAnotherShop(
          fromVariantId: fromVariantId,
          toShopId: toShopId,
          transferQuantity: transferQuantity,
          toProductId: toProductId,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error transferring product: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error transferring product: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<PaginationModel<TransferProductHistoryModel>>
      getTransferProductHistory(
          {required int shopId, required int page}) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.fetchTransferProductHistory(
          shopId: shopId,
          page: page,
        ),
      );

      if (response.status.isSuccess) {
        return PaginationModel<TransferProductHistoryModel>.fromJson(
          response.data,
          (json) => TransferProductHistoryModel.fromJson(
            json as Map<String, dynamic>,
          ),
        );
      }
      log('Fetch transfer product history failed: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error fetching transfer product history: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Check which variant IDs from [variantIds] are NOT available for the
  /// given [pickupDate] / [returnDate] range (optionally excluding [bookingId]).
  ///
  /// Returns a list of variant IDs that are **not available** (not_found_ids
  /// from the API meta field).
  @override
  Future<List<int>> checkVariantAvailability({
    required String pickupDate,
    required String returnDate,
    required List<int> variantIds,
    int? bookingId,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
  }) async {
    try {
      final response = await safeApiCall(
        () => _queryDatasource.checkVariantAvailability(
          pickupDate: pickupDate,
          returnDate: returnDate,
          variantIds: variantIds,
          bookingId: bookingId,
          pickupTime: pickupTime,
          returnTime: returnTime,
        ),
      );
      if (response.status.isSuccess) {
        // Response structure: data.data.products[].variants[].remaining_stock
        final dataMap = response.data as Map<String, dynamic>?;
        final innerData = dataMap?['data'] as Map<String, dynamic>?;
        final products = (innerData?['products'] as List<dynamic>?) ?? [];

        // Collect variant IDs where remaining_stock == 0
        final unavailableIds = <int>[];
        for (final product in products) {
          final productMap = product as Map<String, dynamic>?;
          final variants = (productMap?['variants'] as List<dynamic>?) ?? [];
          for (final variant in variants) {
            final variantMap = variant as Map<String, dynamic>?;
            final remainingStock =
                (variantMap?['remaining_stock'] as num?)?.toInt() ?? 0;
            if (remainingStock == 0) {
              final variantId = (variantMap?['id'] as num?)?.toInt();
              if (variantId != null) unavailableIds.add(variantId);
            }
          }
        }
        log('checkVariantAvailability: variants with remaining_stock=0: $unavailableIds');
        return unavailableIds;
      }
      log('checkVariantAvailability failed: ${response.devMessage}');
      return [];
    } catch (e, stack) {
      log('Error checking variant availability: $e', stackTrace: stack);
      return [];
    }
  }
}
