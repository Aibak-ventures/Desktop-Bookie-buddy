import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SettingsRemoteDatasource {
  final Dio _dio;
  SettingsRemoteDatasource({required Dio dio}) : _dio = dio;

  Future<CustomResponseModel> updateShopPrivacySettings(
    List<UserPasswordSettingsModel> updatedPasswordSettings,
  ) async {
    try {
      final data = updatedPasswordSettings.toCustomJson();

      debugPrint('Update Shop Privacy Settings Request: $data');
      final response = await _dio.patch(
        ApiEndpoints.shop.privacySettings,
        data: data,
      );
      log(
        'Update Shop Privacy Settings Response: ${response.realUri.toString()} ,${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Update Shop Privacy Settings Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updateShopSettings({
    int? coolingPeriodDuration,
    AddButtonDefaultAction? addButtonDefaultAction,
  }) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.shop.updateSettings,
        data: {
          'cooling_days': coolingPeriodDuration,
          'default_action': addButtonDefaultAction?.toJson(),
        },
      );
      log(
        'Update Shop Settings Response: ${response.realUri.toString()} ,${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Update Shop Settings Error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
