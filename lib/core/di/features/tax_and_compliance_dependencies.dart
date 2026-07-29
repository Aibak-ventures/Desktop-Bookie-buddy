import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/data/datasources/tax_configuration_remote_datasource.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/data/repositories/tax_configuration_repository_impl.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/repositories/i_tax_configuration_repository.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/usecases/create_tax_configuration_usecase.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/usecases/get_tax_configurations_usecase.dart';
import 'package:bookie_buddy_web/features/tax_and_compliance/domain/usecases/update_tax_configuration_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class TaxAndComplianceDependencies {
  static void register() {
    getIt
      ..registerLazySingleton(
        () => TaxConfigurationRemoteDatasource(DioClient.dio),
      )
      ..registerLazySingleton<ITaxConfigurationRepository>(
        () => TaxConfigurationRepositoryImpl(getIt()),
      )
      ..registerLazySingleton(() => GetTaxConfigurationsUseCase(getIt()))
      ..registerLazySingleton(() => CreateTaxConfigurationUseCase(getIt()))
      ..registerLazySingleton(() => UpdateTaxConfigurationUseCase(getIt()));
  }
}
