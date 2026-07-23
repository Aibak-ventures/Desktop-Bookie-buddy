import 'package:bookie_buddy_web/features/tax_and_compliance/domain/entities/tax_configuration_request_entity/tax_configuration_request_entity.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/repositories/i_tax_configuration_repository.dart';

class UpdateTaxConfigurationUseCase {
  final ITaxConfigurationRepository _repository;

  const UpdateTaxConfigurationUseCase(this._repository);

  Future<void> call({
    required int id,
    required TaxConfigurationRequestEntity taxConfiguration,
  }) => _repository.updateTaxConfiguration(
    id: id,
    taxConfiguration: taxConfiguration,
  );
}
