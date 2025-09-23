import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';

class ShopService {
  Future<List<ShopModel>> fetchShops() async {
    try {
      final response = await DioClient.dio.get(
        '/api/v1/shop/available-shops/',
      );

      if (response.statusCode != 200) {
        throw response.data['error'] ?? 'Failed to fetch shops';
      }

      final shops = response.data['shops'] as List;
      return shops.map((e) => ShopModel.fromJson(e)).toList();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
