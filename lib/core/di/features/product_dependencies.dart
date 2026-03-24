import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/product/data/datasources/product_action_remote_datasource.dart';
import 'package:bookie_buddy_web/features/product/data/datasources/product_query_remote_datasource.dart';
import 'package:bookie_buddy_web/features/product/data/repositories/product_repository_impl.dart';
import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/add_product_variants_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/check_variant_availability_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/delete_product_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_available_products_paginated_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_matching_products_from_another_shop_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_product_bookings_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_product_growth_data_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_product_info_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/get_products_paginated_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/save_product_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/search_all_products_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/search_and_filter_products_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/transfer_product_to_another_shop_usecase.dart';
import 'package:bookie_buddy_web/features/product/domain/usecases/update_variant_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class ProductDependencies {
  static void register() {
    getIt.registerLazySingleton(
        () => ProductQueryRemoteDatasource(dio: DioClient.dio));
    getIt.registerLazySingleton(
        () => ProductActionRemoteDatasource(dio: DioClient.dio));
    getIt.registerLazySingleton<IProductRepository>(
      () => ProductRepositoryImpl(
        queryDatasource: getIt(),
        actionDatasource: getIt(),
      ),
    );
    getIt.registerLazySingleton(
        () => SaveProductUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => DeleteProductUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => UpdateVariantUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => AddProductVariantsUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => TransferProductToAnotherShopUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => GetProductInfoUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => GetProductsPaginatedUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => GetAvailableProductsPaginatedUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => SearchAndFilterProductsUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => SearchAllProductsUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => GetProductBookingsUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => GetProductGrowthDataUseCase(getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => GetMatchingProductsFromAnotherShopUseCase(
            getIt<IProductRepository>()));
    getIt.registerLazySingleton(
        () => CheckVariantAvailabilityUseCase(getIt<IProductRepository>()));
  }
}
