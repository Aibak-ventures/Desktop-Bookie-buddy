import 'dart:convert';
import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/product_endpoints.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductQueryRemoteDatasource {
  final Dio _dio;

  ProductQueryRemoteDatasource({required Dio dio}) : _dio = dio;

  ProductEndpoints get _endpoint => ApiEndpoints.products;

  Future<CustomResponseModel> searchAllProducts({
    required String? query,
    required int page,
    bool includeInStockOnly = false,
  }) async {
    try {
      final response = await _dio.get(
        _endpoint.productSearch,
        queryParameters: {
          'page': page,
          'search_by': 'name',
          'search': query,
          'in_stock_only': includeInStockOnly,
        },
      );
      log('Search all product url: ${response.realUri.toString()}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error searching all products: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchProductInfo(int productId) async {
    try {
      final res = await _dio.get(_endpoint.productById(productId));
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('fetch product info error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> searchAndFilterProducts({
    int? serviceId,
    required String? query,
    required String? type,
    required int page,
    required int? startPrice,
    required int? endPrice,
    required bool includeInStockOnly,
  }) async {
    try {
      // Use product-search endpoint when "All Services" is selected
      final useProductSearchEndpoint = serviceId == null || serviceId == -1;

      final response = await _dio.get(
        useProductSearchEndpoint
            ? _endpoint.productSearch
            : _endpoint.productsRoot,
        queryParameters: {
          'page': page,
          if (query != null && query.isNotEmpty) ...{
            'search': query,
            'search_by':
                type, // Only send search_by when there's actual search text
          },
          if (!useProductSearchEndpoint && serviceId != -1)
            'shop_service_id': serviceId,
          // Send price range when specified
          if (startPrice != null) 'min_price': startPrice,
          if (endPrice != null) 'max_price': endPrice,
          // Always send in_stock_only param
          'in_stock_only': includeInStockOnly,
        },
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stackTrace) {
      log('Error fetching products: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<CustomResponseModel> getProductBookings({
    required int productId,
    required int page,
    String? status,
  }) async {
    try {
      final res = await _dio.get(
        _endpoint.productBookings(productId),
        queryParameters: {
          'page': page,
          if (status != null)
            'status': status, // 'all', 'upcoming', 'completed',
        },
      );
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('get product bookings error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchProductsPaginated({
    int? serviceId,
    required int page,
    required bool includeInStockOnly,
  }) async {
    try {
      final response = await _dio.get(
        _endpoint.productsRoot,
        queryParameters: {
          'page': page,
          // Don't send shop_service_id for "All Services" (-1 or null)
          if (serviceId != null && serviceId > 0) 'shop_service_id': serviceId,
          // Send in_stock_only when filtering
          'in_stock_only': includeInStockOnly,
        },
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stackTrace) {
      log('Error fetching products: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchAvailableProductsPaginated({
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
      final response = await _dio.get(
        nextPageUrl ?? _endpoint.availableProducts,
        queryParameters: nextPageUrl != null
            ? null
            : {
                if (serviceId != null) 'service_id': serviceId,
                'page': page,
                'event_date': pickupDate.parseToDateTime().format(
                  reverse: true,
                ),
                'return_date':
                    (returnTime != null &&
                        returnTime.hour == 23 &&
                        returnTime.minute == 59)
                    ? returnDate
                          .parseToDateTime()
                          .add(const Duration(days: 1))
                          .format(reverse: true)
                    : returnDate.parseToDateTime().format(reverse: true),
                if (pickupTime != null)
                  'event_time': pickupTime.formatToTime(
                    date: pickupDate.parseToDateTime(),
                  ),
                if (returnTime != null)
                  'return_time': returnTime.formatToTime(
                    date: returnDate.parseToDateTime(),
                  ),
                if (query != null && query.isNotEmpty) ...{
                  'search_value': query,
                  'search_field':
                      type, // "name","color","size","category","model"
                },
                if (startPrice != null) 'min_price': startPrice,
                if (endPrice != null) 'max_price': endPrice,
                if (bookingId != null) 'booking_id': bookingId,
                if (variantIds != null && variantIds.isNotEmpty)
                  'variant_ids': jsonEncode(
                    variantIds,
                  ), // Send as JSON array string
              },
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stackTrace) {
      log('Error fetching products: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchProductGrowthData(int productId) async {
    try {
      final res = await _dio.get(_endpoint.monthlySummary(productId));
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('fetch product growth data error: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Check availability of specific variant IDs for a given date range.
  /// Returns the raw API response which includes meta.not_found_ids.
  Future<CustomResponseModel> checkVariantAvailability({
    required String pickupDate,
    required String returnDate,
    required List<int> variantIds,
    int? bookingId,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
  }) async {
    try {
      final response = await _dio.get(
        _endpoint.availableProducts,
        queryParameters: {
          'page': 1,
          'event_date': pickupDate.parseToDateTime().format(reverse: true),
          'return_date':
              (returnTime != null &&
                  returnTime.hour == 23 &&
                  returnTime.minute == 59)
              ? returnDate
                    .parseToDateTime()
                    .add(const Duration(days: 1))
                    .format(reverse: true)
              : returnDate.parseToDateTime().format(reverse: true),
          if (pickupTime != null)
            'event_time': pickupTime.formatToTime(
              date: pickupDate.parseToDateTime(),
            ),
          if (returnTime != null)
            'return_time': returnTime.formatToTime(
              date: returnDate.parseToDateTime(),
            ),
          if (bookingId != null) 'booking_id': bookingId,
          'variant_ids': jsonEncode(variantIds),
        },
      );
      log('checkVariantAvailability url: ${response.realUri.toString()}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('checkVariantAvailability error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchMatchingProductsFromAnotherShop({
    required int fromVariantId,
    required int toShopId,
    int page = 1,
  }) async {
    try {
      final res = await _dio.post(
        _endpoint.matchProduct,
        queryParameters: {'page': page},
        data: {'from_variant_id': fromVariantId, 'to_shop_id': toShopId},
      );
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('Matching products error while fetching: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchTransferProductHistory({
    required int shopId,
    required int page,
  }) async {
    try {
      final response = await _dio.get(
        _endpoint.transferHistory,
        queryParameters: {'page': page, 'shop_id': shopId},
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching transfer product history: $e', stackTrace: stack);
      rethrow;
    }
  }
}
