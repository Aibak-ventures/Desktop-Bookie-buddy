import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/client/data/datasources/client_remote_datasource.dart';
import 'package:bookie_buddy_web/features/client/data/repositories/client_repository_impl.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/add_client_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/delete_client_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/get_clients_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/update_client_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class ClientDependencies {
  static void register() {
    getIt.registerLazySingleton(
        () => ClientRemoteDatasource(dio: DioClient.dio));
    getIt.registerLazySingleton<IClientRepository>(
        () => ClientRepositoryImpl(getIt()));
    getIt.registerLazySingleton(
        () => GetClientsUseCase(getIt<IClientRepository>()));
    getIt.registerLazySingleton(
        () => AddClientUseCase(getIt<IClientRepository>()));
    getIt.registerLazySingleton(
        () => UpdateClientUseCase(getIt<IClientRepository>()));
    getIt.registerLazySingleton(
        () => DeleteClientUseCase(getIt<IClientRepository>()));
  }
}
