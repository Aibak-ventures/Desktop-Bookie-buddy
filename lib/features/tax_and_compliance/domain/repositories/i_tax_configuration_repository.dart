import 'package:bookie_buddy_web/core/common/entities/tax_configuration_entity/tax_configuration_entity.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/entities/tax_configuration_request_entity/tax_configuration_request_entity.dart';

abstract interface class ITaxConfigurationRepository {
  Future<List<TaxConfigurationEntity>> getTaxConfigurations();

  Future<void> createTaxConfiguration({
    required TaxConfigurationRequestEntity taxConfiguration,
  });

  Future<void> updateTaxConfiguration({
    required int id,
    required TaxConfigurationRequestEntity taxConfiguration,
  });
}
