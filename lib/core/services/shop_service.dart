import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/api/api_paths.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:flutter/material.dart';

class ShopService {
  Future<CustomResponseModel> fetchShops() async {
    try {
      final response = await DioClient.dio.get(ApiPaths.shop.availableShops);
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
        ApiPaths.shop.privacySettings,
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
        ApiPaths.shop.updateSettings,
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
