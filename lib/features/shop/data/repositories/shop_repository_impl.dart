import 'dart:developer';

import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:bookie_buddy_web/features/shop/domain/repositories/i_shop_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';

class ShopRepositoryImpl implements IShopRepository {
  final ShopRemoteDatasource _datasource;

  ShopRepositoryImpl(this._datasource);

  @override
  Future<List<ShopModel>> getShops() async {
    try {
      final response = await safeApiCall(_datasource.fetchShops);
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

  @override
  Future<List<ServicesModel>> getShopServices() async {
    try {
      final response = await safeApiCall(_datasource.fetchServices);
      if (response.status.isSuccess) {
        return (response.data as List)
            .map((json) => ServicesModel.fromJson(json))
            .toList();
      }
      log('Failed to fetch services: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Get Shop Services Exception: $e', stackTrace: stack);
      rethrow;
    }
  }
}
