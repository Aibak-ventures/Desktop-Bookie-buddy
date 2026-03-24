import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_monthly_data_entity/product_monthly_data_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_request_entity/product_request_entity.dart';
import 'package:flutter/material.dart';

abstract interface class IProductRepository {
  // --- Mutations ---
  Future<void> saveProduct({required ProductRequestEntity product});

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
  Future<ProductEntity> getProductInfo(int productId);

  Future<PaginationModel<ProductEntity>> getProductsPaginated({
    int? serviceId,
    required int page,
    bool includeInStockOnly,
  });

  Future<PaginationModel<ProductEntity>> getAvailableProductsPaginated({
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

  Future<PaginationModel<ProductEntity>> searchAndFilterProducts({
    int? serviceId,
    required String? query,
    required String? type,
    required int? startPrice,
    required int? endPrice,
    int page,
    bool includeInStockOnly,
  });

  Future<PaginationModel<ProductEntity>> searchAllProducts({
    required String? query,
    required int page,
    bool includeInStockOnly,
  });

  Future<PaginationModel<BookingEntity>> getProductBookings({
    required int productId,
    int page,
    String? status,
  });

  Future<List<ProductMonthlyDataEntity>> getProductGrowthData(int productId);

  Future<PaginationModel<ProductEntity>> getMatchingProductsFromAnotherShop({
    required int fromVariantId,
    required int toShopId,
    int page,
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
