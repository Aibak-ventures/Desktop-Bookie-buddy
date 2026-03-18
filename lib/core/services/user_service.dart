import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class UserService {
  Future<CustomResponseModel> fetchUserData() async {
    try {
      final response = await DioClient.dio.get(ApiEndpoints.auth.profile);
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error in userLogin: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> registerFCMToken({
    required String token,
    required int? shopId,
  }) async {
    try {
      final body = {
        'token': token,
        'platform': Platform.operatingSystem, // current platform
        'shop_id': shopId,
      };
      log('Registering FCM token with body: $body');
      final response = await DioClient.dio.post(
        ApiEndpoints.notifications.register,
        data: body,
      );
      log('FCM token registration response: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error in registerFCMToken: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> removeFCMToken(String token) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.notifications.remove,
        data: {'token': token},
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error in removeFCMToken: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updateFCMTokenWhenShopSwitching({
    required String token,
    required int shopId,
  }) async {
    try {
      final response = await DioClient.dio.post(
        ApiEndpoints.notifications.updateShop,
        data: {'token': token, 'shop_id': shopId},
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error in updateFCMTokenWhenShopSwitching: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchAvailableShops() async {
    try {
      final response = await DioClient.dio.get('/api/v3/shop/available-shops/');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error in fetchAvailableShops: $e', stackTrace: stack);
      rethrow;
    }
  }
}
