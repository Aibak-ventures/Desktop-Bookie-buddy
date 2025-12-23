import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/core/services/shop_service.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/models/all_shop_summary_model/all_shop_summary_model.dart';

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
      throw response.message;
    } catch (e, stack) {
      log('Get Shops Exception: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> updateShopPrivacySettings(
    List<UserPasswordSettingsModel> updatedPasswordSettings,
  ) async {
    try {
      final response = await safeApiCall(
        () => _service.updateShopPrivacySettings(updatedPasswordSettings),
      );

      if (response.status.isSuccess) {
        return;
      }
      log('Update Shop Privacy Settings Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Update Shop Privacy Settings Exception: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<AllShopSummaryModel> getAllShopSummary({
    required int year,
    required int month,
    int? shopId,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.getAllShopSummary(
          year: year,
          month: month,
          shopId: shopId,
        ),
      );

      if (response.status.isSuccess) {
        return AllShopSummaryModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      log('Get All Shop Summary Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Get All Shop Summary Exception: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> updateShopSettings({
    int? coolingPeriodDuration,
    AddButtonDefaultAction? addButtonDefaultAction,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.updateShopSettings(
          coolingPeriodDuration: coolingPeriodDuration,
          addButtonDefaultAction: addButtonDefaultAction,
        ),
      );

      if (response.status.isSuccess) {
        return;
      }
      log('Update Shop Privacy Settings Error: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Update Shop Privacy Settings Exception: $e', stackTrace: stack);
      rethrow;
    }
  }
}
