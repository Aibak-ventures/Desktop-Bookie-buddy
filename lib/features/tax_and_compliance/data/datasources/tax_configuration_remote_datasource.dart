import 'dart:developer';

import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/data/models/tax_configuration_request_model/tax_configuration_request_model.dart';
import 'package:dio/dio.dart';

class TaxConfigurationRemoteDatasource {
  final Dio _dio;

  const TaxConfigurationRemoteDatasource(this._dio);

  /// Fetch all tax configuration rules for the shop
  Future<CustomResponseModel> getTaxConfigurations() async {
    try {
      final response = await _dio.get(
        ApiEndpoints.taxConfiguration.taxConfigurations,
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching tax configurations: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Create a new tax configuration rule
  Future<CustomResponseModel> createTaxConfiguration({
    required TaxConfigurationRequestModel taxConfiguration,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.taxConfiguration.taxConfigurations,
        data: taxConfiguration.toJson(),
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error creating tax configuration: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Update an existing tax configuration rule
  Future<CustomResponseModel> updateTaxConfiguration({
    required int id,
    required TaxConfigurationRequestModel taxConfiguration,
  }) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.taxConfiguration.taxConfigurationById(id),
        data: taxConfiguration.toJson(),
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating tax configuration: $e', stackTrace: stack);
      rethrow;
    }
  }
}
