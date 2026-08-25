import 'package:bookie_buddy_core/core/common/entities/tax_configuration_entity/tax_configuration_entity.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/repositories/i_tax_configuration_repository.dart';

class GetTaxConfigurationsUseCase {
  final ITaxConfigurationRepository _repository;

  const GetTaxConfigurationsUseCase(this._repository);

  Future<List<TaxConfigurationEntity>> call() =>
      _repository.getTaxConfigurations();
}
