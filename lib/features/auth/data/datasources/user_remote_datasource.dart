import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/auth_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/notifications_endpoints.dart';
import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:dio/dio.dart';

class UserRemoteDatasource {
  final Dio _dio;

  UserRemoteDatasource({required Dio dio}) : _dio = dio;

  AuthEndpoints get _authEndpoint => ApiEndpoints.auth;
  NotificationsEndpoints get _notificationsEndpoint =>
      ApiEndpoints.notifications;

  Future<CustomResponseModel> fetchUserData() async {
    try {
      final response = await _dio.get(_authEndpoint.profile);
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Fetch user data error: $e', stackTrace: stack);
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
        'platform': Platform.operatingSystem,
        'shop_id': shopId,
      };
      log('Registering FCM token with body: $body');
      final response = await _dio.post(
        _notificationsEndpoint.register,
        data: body,
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Register FCM token error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> removeFCMToken(String token) async {
    try {
      final response = await _dio.post(
        _notificationsEndpoint.remove,
        data: {'token': token},
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Remove FCM token error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updateFCMTokenWhenShopSwitching({
    required String token,
    required int shopId,
  }) async {
    try {
      final response = await _dio.post(
        _notificationsEndpoint.updateShop,
        data: {'token': token, 'shop_id': shopId},
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Update FCM token error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
