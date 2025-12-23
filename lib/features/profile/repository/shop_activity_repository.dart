import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/features/profile/models/shop_activity_list_model/shop_activity_list_model.dart';

class ShopActivityRepository {
  static final Dio _dio = DioClient.dio;

  Future<ShopActivityListModel> loadShopActivities({int page = 1}) async {
    try {
      log('Loading shop activities - page: $page');
      
      // TODO: Replace with actual API endpoint when available
      final response = await _dio.get(
        '/api/v1/shop/activities/',
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        return ShopActivityListModel.fromJson(response.data['data']);
      } else {
        throw 'Failed to load shop activities: ${response.statusMessage}';
      }
    } catch (e, stack) {
      log('Error loading shop activities: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<ShopActivityListModel> loadNextPage(String nextPageUrl) async {
    try {
      log('Loading next page: $nextPageUrl');
      
      final response = await _dio.get(nextPageUrl);

      if (response.statusCode == 200) {
        return ShopActivityListModel.fromJson(response.data['data']);
      } else {
        throw 'Failed to load next page: ${response.statusMessage}';
      }
    } catch (e, stack) {
      log('Error loading next page: $e', stackTrace: stack);
      rethrow;
    }
  }
}
