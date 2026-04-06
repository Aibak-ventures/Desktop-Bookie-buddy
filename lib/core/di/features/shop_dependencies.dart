import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:bookie_buddy_web/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:bookie_buddy_web/features/shop/domain/repositories/i_shop_repository.dart';
import 'package:bookie_buddy_web/features/shop/domain/usecases/get_shops_usecase.dart';
import 'package:bookie_buddy_web/features/shop/domain/usecases/get_shop_services_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class ShopDependencies {
  static void register() {
    getIt.registerLazySingleton(() => ShopRemoteDatasource(dio: DioClient.dio));
    getIt.registerLazySingleton<IShopRepository>(
        () => ShopRepositoryImpl(getIt()));
    getIt.registerLazySingleton(
        () => GetShopsUseCase(getIt<IShopRepository>()));
    getIt.registerLazySingleton(
        () => GetShopServicesUseCase(getIt<IShopRepository>()));
  }
}
