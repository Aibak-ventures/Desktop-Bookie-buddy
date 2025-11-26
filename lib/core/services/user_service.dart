import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/api/api_paths.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';

class UserService {
  Future<CustomResponseModel> fetchUserData() async {
    try {
      final response = await DioClient.dio.get(ApiPaths.auth.profile);
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
        ApiPaths.notifications.register,
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
        ApiPaths.notifications.remove,
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
        ApiPaths.notifications.updateShop,
        data: {'token': token, 'shop_id': shopId},
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error in updateFCMTokenWhenShopSwitching: $e', stackTrace: stack);
      rethrow;
    }
  }
}
