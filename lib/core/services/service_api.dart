import 'dart:developer';
import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ServiceApi {
  /// Fetches services with improved error handling and retry logic
  Future<CustomResponseModel> fetchServices() async {
    return await safeApiCall<CustomResponseModel>(() async {
      log('🔄 Fetching services from: ${ApiEndpoints.service.selected}');

      final response = await DioClient.dio.get(
        ApiEndpoints.service.selected,
        options: Options(
          // Add extra timeout for this specific request
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 15),
          // Add retry logic
          extra: {'retries': 3},
        ),
      );

      if (kDebugMode) {
        log('✅ Services fetched successfully. Status: ${response.statusCode}');
        log('📦 Response data type: ${response.data.runtimeType}');
      }

      return CustomResponseModel.fromJson(response.data);
    });
  }

  /// Alternative method for testing network connectivity
  Future<bool> checkApiConnectivity() async {
    try {
      final response = await DioClient.dio.get(
        '/api/v3/health/', // Assuming there's a health check endpoint
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 5),
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      log('❌ API connectivity check failed: $e');
      return false;
    }
  }
}
