import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_request_model/product_request_model.dart';
import 'package:bookie_buddy_web/features/product/domain/models/transfer_product_history_model/transfer_product_history_model.dart';
import 'package:flutter/material.dart';

abstract interface class IProductRepository {
  // --- Mutations ---
  Future<void> saveProduct({required ProductRequestModel product});
  Future<void> deleteProduct({required int productId, int? variantId});
  Future<void> updateVariant({
    required int productId,
    required int variantId,
    required String? updatedAttribute,
    required int? updatedStock,
    String? externalQrCode,
  });
  Future<void> addProductVariants({
    required int productId,
    required String attribute,
    required int stock,
  });
  Future<void> transferProductToAnotherShop({
    required int fromVariantId,
    required int toShopId,
    required int transferQuantity,
    int? toProductId,
  });

  // --- Queries ---
  Future<ProductModel> getProductInfo(int productId);
  Future<PaginationModel<ProductModel>> getProductsPaginated({
    int? serviceId,
    required int page,
    bool includeInStockOnly,
  });
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
    int? bookingId,
    List<int>? variantIds,
  });
  Future<PaginationModel<ProductModel>> searchAndFilterProducts({
    int? serviceId,
    required String? query,
    required String? type,
    required int? startPrice,
    required int? endPrice,
    int page,
    bool includeInStockOnly,
  });
  Future<PaginationModel<ProductModel>> searchAllProducts({
    required String? query,
    required int page,
    bool includeInStockOnly,
  });
  Future<PaginationModel<BookingsModel>> getProductBookings({
    required int productId,
    int page,
    String? status,
  });
  Future<List<ProductMonthlyDataModel>> getProductGrowthData(int productId);
  Future<PaginationModel<ProductModel>> getMatchingProductsFromAnotherShop({
    required int fromVariantId,
    required int toShopId,
    int page,
  });
  Future<PaginationModel<TransferProductHistoryModel>>
      getTransferProductHistory({
    required int shopId,
    required int page,
  });
  Future<List<int>> checkVariantAvailability({
    required String pickupDate,
    required String returnDate,
    required List<int> variantIds,
    int? bookingId,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
  });
}
