import 'dart:developer';

import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/services/shop_service.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';

class ShopRepository {
  final ShopService _service;

  ShopRepository({required ShopService service}) : _service = service;

  Future<List<ShopModel>> getShops() async {
    try {
      final response = await safeApiCall(_service.fetchShops);

      if (response.status.isSuccess) {
        return (response.data as List)
            .map((e) => ShopModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      log('Get Shops Error: ${response.devMessage}');
      throw response.message ?? 'Failed to get shops';
    } catch (e, stack) {
      log('Get Shops Exception: $e', stackTrace: stack);
      rethrow;
    }
  }
}
