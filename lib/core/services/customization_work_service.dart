import 'dart:developer';

import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';

/// Service class for Customization Work API operations
class CustomizationWorkService {
  Dio get _dio => DioClient.dio;

  /// Get paginated list of customization works with optional filtering
  Future<CustomResponseModel> getCustomizationWorks({
    int page = 1,
    String? search,
    String? status,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      log('🔄 Fetching customization works - Page: $page, Search: $search, Status: $status');

      final response = await _dio.get(
        ApiEndpoints.customizationWork.customizationWorks,
        queryParameters: {
          'page': page,
          if (search != null && search.isNotEmpty) 'search': search,
          if (status != null && status.isNotEmpty) 'status': status,
          if (fromDate != null && fromDate.isNotEmpty) 'from': fromDate,
          if (toDate != null && toDate.isNotEmpty) 'to': toDate,
        },
      );

      log('✅ Customization Works API Response: ${response.realUri}');
      log('📊 Status Code: ${response.statusCode}');
      log('📦 Data Count: ${(response.data['data'] as Map?)?['count'] ?? 0}');

      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error fetching customization works: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Get details of a specific customization work
  Future<CustomResponseModel> getCustomizationWorkDetails(int id) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.customizationWork.customizationWorkDetail(id),
      );
      log('✅ Customization Work details response: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error getting customization work details: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Create a new customization work
  Future<CustomResponseModel> createCustomizationWork(
      Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.customizationWork.customizationWorks,
        data: data,
      );
      log('✅ Customization Work created: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error creating customization work: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Update an existing customization work
  Future<CustomResponseModel> updateCustomizationWork(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.customizationWork.updateCustomizationWork(id),
        data: data,
      );
      log('✅ Customization Work updated: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error updating customization work: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Delete a customization work
  Future<CustomResponseModel> deleteCustomizationWork(int id) async {
    try {
      final response = await _dio.delete(
        ApiEndpoints.customizationWork.deleteCustomizationWork(id),
      );
      log('✅ Customization Work deleted: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error deleting customization work: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Mark customization work as completed
  Future<CustomResponseModel> markAsCompleted(int id) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.customizationWork.markAsCompleted(id),
      );
      log('✅ Customization Work marked as completed: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error marking as completed: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Mark customization work as pending
  Future<CustomResponseModel> markAsPending(int id) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.customizationWork.markAsPending(id),
      );
      log('✅ Customization Work marked as pending: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error marking as pending: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Mark customization work as in progress
  Future<CustomResponseModel> markAsInProgress(int id) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.customizationWork.markAsInProgress(id),
      );
      log('✅ Customization Work marked as in progress: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error marking as in progress: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Search customization works
  Future<CustomResponseModel> searchCustomizationWorks({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.customizationWork.searchCustomizationWorks,
        queryParameters: {
          'q': query,
          'page': page,
        },
      );
      log('✅ Customization Works search results: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error searching customization works: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Filter customization works by status
  Future<CustomResponseModel> filterByStatus({
    required String status,
    int page = 1,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.customizationWork.filterByStatus,
        queryParameters: {
          'status': status,
          'page': page,
        },
      );
      log('✅ Customization Works filtered by status: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('❌ Error filtering by status: $e', stackTrace: stack);
      rethrow;
    }
  }
}
