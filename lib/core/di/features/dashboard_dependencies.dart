import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:bookie_buddy_web/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/repositories/i_dashboard_repository.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/usecases/get_dashboard_desktop_data_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class DashboardDependencies {
  static void register() {
    getIt.registerLazySingleton(
        () => DashboardRemoteDatasource(dio: DioClient.dio));
    getIt.registerLazySingleton<IDashboardRepository>(
        () => DashboardRepositoryImpl(getIt()));
    getIt.registerLazySingleton(
      () => GetDashboardDesktopDataUseCase(getIt<IDashboardRepository>()),
    );
  }
}
