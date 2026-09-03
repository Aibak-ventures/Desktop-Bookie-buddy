import 'dart:developer';

import 'package:bookie_buddy_shared/core/core/common/entities/tax_configuration_entity/tax_configuration_entity.dart';
import 'package:bookie_buddy_web/core/common/models/tax_configuration_model/tax_configuration_model.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/data/datasources/tax_configuration_remote_datasource.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/data/models/tax_configuration_request_model/tax_configuration_request_model.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/entities/tax_configuration_request_entity/tax_configuration_request_entity.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/repositories/i_tax_configuration_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';

class TaxConfigurationRepositoryImpl implements ITaxConfigurationRepository {
  final TaxConfigurationRemoteDatasource _datasource;

  TaxConfigurationRepositoryImpl(this._datasource);

  @override
  Future<List<TaxConfigurationEntity>> getTaxConfigurations() async {
    try {
      final response = await safeApiCall(
        () => _datasource.getTaxConfigurations(),
      );
      if (response.status.isSuccess) {
        return (response.data as List)
            .map(
              (data) => TaxConfigurationModel.fromJson(
                data as Map<String, dynamic>,
              ).toEntity(),
            )
            .toList();
      }
      log('Error fetching tax configurations: ${response.devMessage}');
      throw response.message ?? 'Error fetching tax configurations';
    } catch (e, stack) {
      log('Error fetching tax configurations: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> createTaxConfiguration({
    required TaxConfigurationRequestEntity taxConfiguration,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.createTaxConfiguration(
          taxConfiguration: TaxConfigurationRequestModel.fromEntity(
            taxConfiguration,
          ),
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error creating tax configuration: ${response.devMessage}');
      throw response.message ?? 'Error creating tax configuration';
    } catch (e, stack) {
      log('Error creating tax configuration: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> updateTaxConfiguration({
    required int id,
    required TaxConfigurationRequestEntity taxConfiguration,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updateTaxConfiguration(
          id: id,
          taxConfiguration: TaxConfigurationRequestModel.fromEntity(
            taxConfiguration,
          ),
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error updating tax configuration: ${response.devMessage}');
      throw response.message ?? 'Error updating tax configuration';
    } catch (e, stack) {
      log('Error updating tax configuration: $e', stackTrace: stack);
      rethrow;
    }
  }
}
