import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';

class ShopRemoteDatasource {
  final Dio _dio;

  ShopRemoteDatasource({required Dio dio}) : _dio = dio;

  Future<CustomResponseModel> fetchShops() async {
    try {
      final response = await _dio.get(ApiEndpoints.shop.availableShops);
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Fetch Shops Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> getAllShopSummary({
    required int year,
    required int month,
    int? shopId,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.shop.allShopSummary(
          year: year,
          month: month,
          shopId: shopId,
        ),
      );
      log('Get All Shop Summary Response: ${response.realUri} ,${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Get All Shop Summary Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchServices() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.service.selected,
        options: Options(
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 15),
          extra: {'retries': 3},
        ),
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Fetch Services Error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
