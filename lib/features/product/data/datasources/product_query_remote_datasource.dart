import 'dart:convert';
import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/booking/data/models/check_availability_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductQueryRemoteDatasource {
  final Dio _dio;

  ProductQueryRemoteDatasource({required Dio dio}) : _dio = dio;

  Future<CustomResponseModel> searchAllProducts({
    required String? query,
    required int page,
    bool includeInStockOnly = false,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.service.productSearch,
        queryParameters: {
          'page': page,
          'search_by': 'name',
          'search': query,
          'in_stock_only': includeInStockOnly,
        },
      );
      log('Search all product url: ${response.realUri.toString()}');
      // log('Search all products response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error searching all products: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchProductInfo(int productId) async {
    try {
      final res =
          await _dio.get(ApiEndpoints.service.productById('$productId'));
      // log("Fetch product info: ${res.realUri.toString()}, data: ${res.data}");
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
            ? ApiEndpoints.service.productSearch
            : ApiEndpoints.service.productsRoot,
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
      // log('Fetch products paginated response: ${response.realUri.toString()}, data: ${response.data}');
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
        '${ApiEndpoints.service.productsRoot}product-bookings/$productId/',
        queryParameters: {
          'page': page,
          if (status != null)
            'status': status, // 'all', 'upcoming', 'completed',
        },
      );
      // log("Product bookings: ${res.realUri.toString()}, data: ${res.data}");
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('get product bookings error: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Checks the availability of a list of products for a given event date and return date.
  ///
  /// Returns a [CheckAvailabilityModel] which contains the status of the availability check
  /// and a list of unavailable products.
  ///
  /// Throws a string error message if the request fails.
  // Future<CheckAvailabilityModel> checkAvailability({
  //   required String eventDate,
  //   required String returnDate,
  //   required List<int> productIds,
  // }) async {
  //   try {
  //     final res = await _dio.post(
  //       "/api/check_product_availability",
  //       data: {
  //         "event_date": eventDate,
  //         "return_date": returnDate,
  //         "sub_service_ids": productIds
  //       },
  //     );

  //     log("Product availability: ${res}");
  //     if (res.statusCode != 200) {
  //       throw 'Failed to check availability';
  //     }

  //     return CheckAvailabilityModel.fromMap(res.data);
  //   } on DioException catch (e, stack) {
  //     log("Dio error: $e", stackTrace: stack);
  //     throw e.response?.data['message'] ?? "Failed to check availability";
  //   } catch (e, stack) {
  //     log("Unexpected error: $e", stackTrace: stack);
  //     throw "Error checking availability: $e";
  //   }
  // }

  Future<CustomResponseModel> fetchProductsPaginated({
    int? serviceId,
    required int page,
    required bool includeInStockOnly,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.service.productsRoot,
        queryParameters: {
          'page': page,
          // Don't send shop_service_id for "All Services" (-1 or null)
          if (serviceId != null && serviceId > 0) 'shop_service_id': serviceId,
          // Send in_stock_only when filtering
          'in_stock_only': includeInStockOnly,
        },
      );
      // log('Fetch products paginated response: ${response.realUri.toString()}, data: ${response.data}');
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
        nextPageUrl ?? ApiEndpoints.bookings.availableProducts,
        queryParameters: nextPageUrl != null
            ? null
            : {
                if (serviceId != null) 'service_id': serviceId,
                'page': page,
                'event_date': pickupDate.parseToDateTime().format(
                      reverse: true,
                    ),
                'return_date': (returnTime != null &&
                        returnTime.hour == 23 &&
                        returnTime.minute == 59)
                    ? returnDate
                        .parseToDateTime()
                        .add(const Duration(days: 1))
                        .format(
                          reverse: true,
                        )
                    : returnDate.parseToDateTime().format(
                          reverse: true,
                        ),
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
                  'variant_ids':
                      jsonEncode(variantIds), // Send as JSON array string
              },
      );
      // log('Fetch available products response: ${response.realUri.toString()} ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stackTrace) {
      log('Error fetching products: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchProductGrowthData(int productId) async {
    try {
      final res =
          await _dio.get(ApiEndpoints.service.monthlySummary('$productId'));
      // log("Product growth data: ${res.realUri.toString()}, data: ${res.data}");
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
        ApiEndpoints.bookings.availableProducts,
        queryParameters: {
          'page': 1,
          'event_date': pickupDate.parseToDateTime().format(reverse: true),
          'return_date': (returnTime != null &&
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
        ApiEndpoints.service.matchProduct,
        queryParameters: {'page': page},
        data: {'from_variant_id': fromVariantId, 'to_shop_id': toShopId},
      );
      // log("Matching products response: ${res.realUri.toString()}, data: ${res.data}");
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
        ApiEndpoints.service.transferHistory,
        queryParameters: {'page': page, 'shop_id': shopId},
      );
      // log("Transfer product history response: ${response.realUri.toString()}, data: ${response.data}");
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching transfer product history: $e', stackTrace: stack);
      rethrow;
    }
  }
}
