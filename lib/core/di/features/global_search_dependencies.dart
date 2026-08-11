import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/global_search/data/datasources/global_search_remote_datasource.dart';
import 'package:bookie_buddy_web/features/global_search/data/repositories/global_search_repository_impl.dart';
import 'package:bookie_buddy_web/features/global_search/domain/repositories/i_global_search_repository.dart';
import 'package:bookie_buddy_web/features/global_search/domain/usecases/get_global_search_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class GlobalSearchDependencies {
  static void register() {
    getIt
      ..registerLazySingleton(() => GlobalSearchRemoteDatasource(DioClient.dio))
      ..registerLazySingleton<IGlobalSearchRepository>(
        () => GlobalSearchRepositoryImpl(getIt()),
      )
      ..registerLazySingleton(() => GetGlobalSearchUseCase(getIt()));
  }
}
