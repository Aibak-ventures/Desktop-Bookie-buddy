import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';
import 'package:dio/dio.dart';

class TailorService {
  Dio get dio => DioClient.dio;

  /// Get all tailors
  Future<CustomResponseModel> fetchTailors({required int page}) async {
    try {
      final response = await dio.get(
        ApiEndpoints.tailor.tailors,
        queryParameters: {'page': page},
      );
      log(response.realUri.toString());
      log(response.data.toString());
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching tailors: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Get tailor by ID
  Future<CustomResponseModel> fetchTailorById(int id) async {
    try {
      final response = await dio.get(ApiEndpoints.tailor.tailorById(id));
      log('Fetch tailor details response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching tailor details: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Get tailor monthly summary
  Future<CustomResponseModel> fetchTailorMonthlySummary(int id) async {
    try {
      final response =
          await dio.get(ApiEndpoints.tailor.tailorMonthlySummary(id));
      log('Fetch tailor monthly summary response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching tailor monthly summary: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Create new tailor
  Future<CustomResponseModel> addTailor(Map<String, dynamic> tailorData) async {
    try {
      final response = await dio.post(
        ApiEndpoints.tailor.tailors,
        data: tailorData,
      );
      log('Add tailor response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error adding tailor: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Update tailor
  Future<CustomResponseModel> updateTailor(
      int id, Map<String, dynamic> tailorData) async {
    try {
      final response = await dio.put(
        ApiEndpoints.tailor.tailorById(id),
        data: tailorData,
      );
      log('Update tailor response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating tailor: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Delete tailor
  Future<CustomResponseModel> deleteTailor(int id) async {
    try {
      final response = await dio.delete(ApiEndpoints.tailor.tailorById(id));
      log('Delete tailor response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error deleting tailor: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Restore deleted tailor
  Future<CustomResponseModel> restoreDeletedTailor(int id) async {
    try {
      final response = await dio.post(
        ApiEndpoints.tailor.restoreDeletedTailor(id),
        data: {},
      );
      log('Restore tailor response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error restoring tailor: $e', stackTrace: stack);
      rethrow;
    }
  }
}
