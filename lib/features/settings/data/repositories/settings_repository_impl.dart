import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:bookie_buddy_web/core/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:bookie_buddy_web/features/settings/domain/repositories/i_settings_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';

class SettingsRepositoryImpl implements ISettingsRepository {
  final SettingsRemoteDatasource _remoteDatasource;

  SettingsRepositoryImpl(this._remoteDatasource);

  @override
  Future<void> updateShopPrivacySettings(
    List<UserPasswordSettingsModel> updatedPasswordSettings,
  ) async {
    try {
      final response = await safeApiCall(
        () => _remoteDatasource
            .updateShopPrivacySettings(updatedPasswordSettings),
      );

      if (response.status.isSuccess) {
        return;
      }
      log('Update Shop Privacy Settings Error: ${response.devMessage}');
      throw response.message ?? 'Failed to update shop privacy settings';
    } catch (e, stack) {
      log('Update Shop Privacy Settings Exception: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> updateShopSettings({
    int? coolingPeriodDuration,
    AddButtonDefaultAction? addButtonDefaultAction,
  }) async {
    try {
      final response = await safeApiCall(
        () => _remoteDatasource.updateShopSettings(
          coolingPeriodDuration: coolingPeriodDuration,
          addButtonDefaultAction: addButtonDefaultAction,
        ),
      );

      if (response.status.isSuccess) {
        return;
      }
      log('Update Shop Settings Error: ${response.devMessage}');
      throw response.message ?? 'Failed to update shop settings';
    } catch (e, stack) {
      log('Update Shop Settings Exception: $e', stackTrace: stack);
      rethrow;
    }
  }
}
