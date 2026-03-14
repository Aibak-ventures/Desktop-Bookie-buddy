import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:bookie_buddy_web/features/profile/domain/models/shop_activity_list_model/shop_activity_list_model.dart';

class ShopActivityRemoteDatasource {
  final Dio _dio;

  ShopActivityRemoteDatasource(this._dio);

  Future<ShopActivityListModel> loadShopActivities({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/api/v1/shop/activities/',
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        return ShopActivityListModel.fromJson(response.data['data']);
      } else {
        throw 'Failed to load shop activities: ${response.statusMessage}';
      }
    } catch (e) {
      log('Error in ShopActivityRemoteDatasource.loadShopActivities: $e');
      rethrow;
    }
  }

  Future<ShopActivityListModel> loadNextPage(String nextPageUrl) async {
    try {
      final response = await _dio.get(nextPageUrl);

      if (response.statusCode == 200) {
        return ShopActivityListModel.fromJson(response.data['data']);
      } else {
        throw 'Failed to load next page: ${response.statusMessage}';
      }
    } catch (e) {
      log('Error in ShopActivityRemoteDatasource.loadNextPage: $e');
      rethrow;
    }
  }
}
