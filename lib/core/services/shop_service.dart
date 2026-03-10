import 'dart:developer';

import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class ShopService {
  Future<CustomResponseModel> fetchShops() async {
    try {
      final response =
          await DioClient.dio.get(ApiEndpoints.shop.availableShops);
      // log("Fetch Shops Response: ${response.realUri.toString()} ,${response.data}");
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Fetch Shops Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updateShopPrivacySettings(
    List<UserPasswordSettingsModel> updatedPasswordSettings,
  ) async {
    try {
      final data = updatedPasswordSettings.toCustomJson();

      debugPrint('Update Shop Privacy Settings Request: $data');
      // throw 'Error: can\'t update shop privacy settings';
      final response = await DioClient.dio.patch(
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
      final response = await DioClient.dio.patch(
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

  Future<CustomResponseModel> getAllShopSummary({
    required int year,
    required int month,
    int? shopId,
  }) async {
    try {
      final response = await DioClient.dio.get(
        ApiEndpoints.shop.allShopSummary(
          year: year,
          month: month,
          shopId: shopId,
        ),
      );
      log(
        'Get All Shop Summary Response: ${response.realUri.toString()} ,${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Get All Shop Summary Error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
