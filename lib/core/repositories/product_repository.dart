import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/services/product_service/product_action_service.dart';
import 'package:bookie_buddy_web/core/services/product_service/product_query_service.dart';
import 'package:bookie_buddy_web/features/add_booking/models/check_availability_model.dart';
import 'package:bookie_buddy_web/features/product/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:bookie_buddy_web/features/product/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';
import 'package:flutter/material.dart';

class ProductRepository {
  final ProductQueryService _queryService;
  final ProductActionService _actionService;

  ProductRepository({
    required ProductQueryService queryService,
    required ProductActionService actionService,
  })  : _queryService = queryService,
        _actionService = actionService;

  // CREATE or UPDATE Product
  Future<void> saveProduct({
    required ProductRequestModel product,
  }) async {
    await _actionService.addOrUpdateProduct(
      product: product,
    );
  }

  // CREATE or UPDATE Expense
  Future<void> saveProductExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      await _actionService.addOrUpdateProductExpense(
        expense: expense,
      );
    } catch (e) {
      rethrow;
    }
  }

  // Delete expense
  Future<void> deleteExpense(int expenseId) async {
    try {
      await _actionService.deleteExpense(expenseId);
    } catch (_) {
      rethrow;
    }
  }

  // Delete product
  Future<bool> deleteProduct({required int productId, int? variantId}) async {
    try {
      return await _actionService.deleteProduct(
        productId: productId,
        variantId: variantId,
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> updateVariant({
    required int productId,
    required int variantId,
    required String? updatedAttribute,
    required int? updatedStock,
  }) async {
    await _actionService.updateVariant(
        productId: productId,
        variantId: variantId,
        updatedAttribute: updatedAttribute,
        updatedStock: updatedStock);
  }

  Future<void> addProductVariants({
    required int productId,
    required String attribute,
    required int stock,
  }) async {
    return await _actionService.addProductVariants(
      productId: productId,
      attribute: attribute,
      stock: stock,
    );
  }

  // Fetch product info
  Future<ProductModel> getProductInfo(int productId) async {
    try {
      return await _actionService.fetchProductInfo(productId);
    } catch (_) {
      rethrow;
    }
  }

  // Search products
  Future<PaginationModel<ProductModel>> searchAndFilterProducts({
    required int serviceId,
    required String? query,
    required String? type,
    required int? startPrice,
    required int? endPrice,
    int page = 1,
  }) async {
    try {
      return await _queryService.searchAndFilterProducts(
        serviceId: serviceId,
        query: query,
        type: type,
        page: page,
        startPrice: startPrice,
        endPrice: endPrice,
      );
    } catch (_) {
      rethrow;
    }
  }

  // Fetch booked dates
  Future<PaginationModel<BookingsModel>> getProductBookings({
    required int productId,
    int page = 1,
    String? status,
  }) async {
    return await _queryService.getProductBookings(
      productId: productId,
      page: page,
      status: status,
    );
  }

  // 📦 Fetch paginated products
  Future<PaginationModel<ProductModel>> getProductsPaginated({
    required int serviceId,
    required int page,
  }) async {
    try {
      return await _queryService.fetchProductsPaginated(
        serviceId,
        page: page,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<PaginationModel<ProductModel>> getAvailableProductsPaginated({
    required int serviceId,
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
  }) async {
    try {
      return await _queryService.fetchAvailableProductsPaginated(
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
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<CheckAvailabilityModel> checkAvailability({
    required String eventDate,
    required String returnDate,
    required List<int> productIds,
  }) async {
    return await _queryService.checkAvailability(
      eventDate: eventDate,
      returnDate: returnDate,
      productIds: productIds,
    );
  }

  Future<List<ProductMonthlyDataModel>> getProductGrowthData(
      int productId) async {
    return await _queryService.fetchProductGrowthData(productId);
  }

  Future<PaginationModel<ProductModel>> searchAllProducts({
    required String? query,
    required int page,
  }) {
    return _queryService.searchAllProducts(
      page: page,
      query: query,
    );
  }

  Future<PaginationModel<ProductModel>> getMatchingProductsFromAnotherShop({
    required int fromVariantId,
    required int toShopId,
    int page = 1,
  }) =>
      _queryService.fetchMatchingProductsFromAnotherShop(
        fromVariantId: fromVariantId,
        toShopId: toShopId,
        page: page,
      );

  Future<void> transferProductToAnotherShop({
    required int fromVariantId,
    required int toShopId,
    required int transferQuantity,
    int? toProductId,
  }) =>
      _actionService.transferProductToAnotherShop(
        fromVariantId: fromVariantId,
        toShopId: toShopId,
        transferQuantity: transferQuantity,
        toProductId: toProductId,
      );
}
