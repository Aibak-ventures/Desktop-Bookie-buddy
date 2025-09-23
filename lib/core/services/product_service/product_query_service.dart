import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/check_availability_model.dart';
import 'package:bookie_buddy_web/features/product/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProductQueryService {
  static final Dio _dio = DioClient.dio;

  Future<PaginationModel<ProductModel>> searchAllProducts({
    required String? query,
    required int page,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v1/service/product-search/',
        queryParameters: {
          'page': page,
          'search_by': 'name',
          'search': query,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        log('status code: ${response.statusCode}, results length: ${results.length}, next page url: ${data['next']}');
        return PaginationModel<ProductModel>(
          data: results.map((json) => ProductModel.fromJson(json)).toList(),
          totalData: data['count'],
          nextPageUrl: data['next'],
        );
      } else {
        throw response.data['error'] ??
            response.data['message'] ??
            "Failed to fetch data";
      }
    } catch (e, stack) {
      log("Unexpected error: $e", stackTrace: stack);
      rethrow;
    }
  }

  Future<PaginationModel<ProductModel>> searchAndFilterProducts({
    required int serviceId,
    required String? query,
    required String? type,
    required int page,
    required int? startPrice,
    required int? endPrice,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v1/service/products/',
        queryParameters: {
          'page': page,
          if (query != null) "search": query,
          "shop_service_id": serviceId,
          if (query != null)
            "search_by": type, // "name","color","size","category","model"
          if (startPrice != null && endPrice != null) "min_price": startPrice,
          if (endPrice != null) "max_price": endPrice,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        log('status code: ${response.statusCode}, results length: ${results.length}');
        return PaginationModel<ProductModel>(
          data: results.map((json) => ProductModel.fromJson(json)).toList(),
          totalData: data['count'],
          nextPageUrl: data['next'],
        );
      } else if (response.statusCode == 404) {
        throw 'Data not found';
      } else if (response.statusCode == 400) {
        throw response.data['error'] ??
            'Something went wrong!, please try again';
      } else {
        throw response.statusMessage ??
            'Something went wrong!, please try again';
      }
    } catch (e, stackTrace) {
      log('Error fetching products: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<PaginationModel<BookingsModel>> getProductBookings({
    required int productId,
    required int page,
    String? status,
  }) async {
    try {
      final res = await _dio.get(
        '/api/v1/service/products/product-bookings/$productId/',
        queryParameters: {
          'page': page,
          if (status != null)
            'status': status, // 'all', 'upcoming', 'completed',
        },
      );

      if (res.statusCode == 200) {
        final data = (res.data['results'] as List)
            .map(
              (e) => BookingsModel.fromJson(e),
            )
            .toList();
        return PaginationModel<BookingsModel>(
          data: data,
          totalData: res.data['count'],
          nextPageUrl: res.data['next'],
        );
      }

      throw "Failed to fetch booked dates";
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.response?.data['message'] ?? "Failed to fetch booked dates";
    } catch (e, stack) {
      log("Unexpected error: $e", stackTrace: stack);
      throw "Error fetching booked dates: $e";
    }
  }

  /// Checks the availability of a list of products for a given event date and return date.
  ///
  /// Returns a [CheckAvailabilityModel] which contains the status of the availability check
  /// and a list of unavailable products.
  ///
  /// Throws a string error message if the request fails.
  Future<CheckAvailabilityModel> checkAvailability({
    required String eventDate,
    required String returnDate,
    required List<int> productIds,
  }) async {
    try {
      final d = {
        "event_date": eventDate,
        "return_date": returnDate,
        "sub_service_ids": productIds
      };

      log(d.toString());
      final res = await _dio.post(
        "/api/check_product_availability",
        data: d,
      );

      log("Product availability: ${res}");
      if (res.statusCode != 200) {
        throw 'Failed to check availability';
      }

      return CheckAvailabilityModel.fromMap(res.data);
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.response?.data['message'] ?? "Failed to check availability";
    } catch (e, stack) {
      log("Unexpected error: $e", stackTrace: stack);
      throw "Error checking availability: $e";
    }
  }

  Future<PaginationModel<ProductModel>> fetchProductsPaginated(
    int serviceId, {
    required int page,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v1/service/products/',
        queryParameters: {
          'page': page,
          'shop_service_id': serviceId,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        log('status code: ${response.statusCode}, results length: ${results.length}');
        return PaginationModel<ProductModel>(
          data: results.map((json) => ProductModel.fromJson(json)).toList(),
          totalData: data['count'],
          nextPageUrl: data['next'],
        );
      } else if (response.statusCode == 404) {
        throw 'Data not found';
      } else if (response.statusCode == 400) {
        throw response.data['error'] ??
            'Something went wrong!, please try again';
      } else {
        log('Error fetching products:  ${response.statusCode}, data: ${response.data}');
        throw response.data['error'] ??
            'Something went wrong!, please try again';
      }
    } catch (e, stackTrace) {
      log('Error fetching products: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<PaginationModel<ProductModel>> fetchAvailableProductsPaginated({
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
      final response = await _dio.get(
        nextPageUrl ?? "/api/v2/bookings/bookings/available-products/",
        queryParameters: nextPageUrl != null
            ? null
            : {
                'service_id': serviceId,
                'page': page,
                'event_date':
                    pickupDate.parseToDateTime().format(reverse: true),
                'return_date':
                    returnDate.parseToDateTime().format(reverse: true),
                if (pickupTime != null)
                  'event_time': pickupTime.formatToTime(
                    date: pickupDate.parseToDateTime(),
                  ),
                if (returnTime != null)
                  'return_time': returnTime.formatToTime(
                    date: returnDate.parseToDateTime(),
                  ),
                if (query != null && type != null)
                  'search_field':
                      type, // "name","color","size","category","model"
                if (query != null) 'search_value': query,
                if (startPrice != null && endPrice != null)
                  "min_price": startPrice,
                if (endPrice != null) "max_price": endPrice,
              },
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results']['products'] as List<dynamic>;
        log('status code: ${response.statusCode}, results length: ${results.length}, next page: ${data['next']}');
        final mainServiceName = data['results']['main_service_name'];
        return PaginationModel<ProductModel>(
          data: results.map(
            (json) {
              return ProductModel.fromJson(
                (json as Map<String, dynamic>)
                  ..['main_service_name'] = mainServiceName,
              );
            },
          ).toList(),
          totalData: data['count'] ?? 0,
          nextPageUrl: data['next'],
        );
      } else if (response.statusCode == 404) {
        throw 'Data not found';
      } else {
        throw response.statusMessage ?? 'Something went wrong!';
      }
    } catch (e, stackTrace) {
      log('Error fetching products: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<List<ProductMonthlyDataModel>> fetchProductGrowthData(
      int productId) async {
    try {
      final res = await _dio.get(
        '/api/v1/service/products/monthly-summary/$productId/',
      );
      if (res.statusCode == 200) {
        return (res.data as List)
            .map((e) => ProductMonthlyDataModel.fromJson(e))
            .toList();
      }
      log("Product bookings ${res.statusCode}, data: ${res.data}");
      throw res.data['error'] ??
          res.data['message'] ??
          "Failed to fetch product bookings";
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.response?.data['message'] ?? "Failed to fetch data";
    } catch (e, stack) {
      log("Unexpected error: $e", stackTrace: stack);
      throw "Error fetching data: $e";
    }
  }

  Future<PaginationModel<ProductModel>> fetchMatchingProductsFromAnotherShop({
    required int fromVariantId,
    required int toShopId,
    int page = 1,
  }) async {
    try {
      final res = await _dio.post(
        '/api/v1/service/transfer-product/match-product/',
        queryParameters: {
          'page': page,
        },
        data: {
          'from_variant_id': fromVariantId,
          'to_shop_id': toShopId,
        },
      );
      log(res.realUri.toString());
      log("status code: ${res.statusCode}, data: ${res.data}");
      if (res.statusCode == 200) {
        final data = (res.data['results']['matching_products'] as List)
            .map(
              (e) => ProductModel.fromJson(e),
            )
            .toList();
        return PaginationModel<ProductModel>(
          data: data,
          totalData: res.data['count'],
          nextPageUrl: res.data['next'],
        );
      }

      throw res.data['error'] ??
          res.data['message'] ??
          "Failed to fetch matching product";
    } on DioException catch (e, stack) {
      log("Dio error: $e", stackTrace: stack);
      throw e.response?.data['message'] ?? "Failed to fetch data";
    } catch (e, stack) {
      log("Matching products error while fetching: $e", stackTrace: stack);
      rethrow;
    }
  }
}
