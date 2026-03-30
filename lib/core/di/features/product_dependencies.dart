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
    if (!getIt.isRegistered<ProductQueryRemoteDatasource>()) {
      getIt.registerLazySingleton(() => ProductQueryRemoteDatasource(dio: DioClient.dio));
    }
    if (!getIt.isRegistered<ProductActionRemoteDatasource>()) {
      getIt.registerLazySingleton(() => ProductActionRemoteDatasource(dio: DioClient.dio));
    }
    if (!getIt.isRegistered<ProductRepositoryImpl>()) {
      getIt.registerLazySingleton(
        () => ProductRepositoryImpl(
          queryDatasource: getIt(),
          actionDatasource: getIt(),
        ),
      );
    }
    if (!getIt.isRegistered<IProductRepository>()) {
      getIt.registerLazySingleton<IProductRepository>(() => getIt<ProductRepositoryImpl>());
    }
    if (!getIt.isRegistered<SaveProductUseCase>()) {
      getIt.registerLazySingleton(() => SaveProductUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<DeleteProductUseCase>()) {
      getIt.registerLazySingleton(() => DeleteProductUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<UpdateVariantUseCase>()) {
      getIt.registerLazySingleton(() => UpdateVariantUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<AddProductVariantsUseCase>()) {
      getIt.registerLazySingleton(() => AddProductVariantsUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<TransferProductToAnotherShopUseCase>()) {
      getIt.registerLazySingleton(() => TransferProductToAnotherShopUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<GetProductInfoUseCase>()) {
      getIt.registerLazySingleton(() => GetProductInfoUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<GetProductsPaginatedUseCase>()) {
      getIt.registerLazySingleton(() => GetProductsPaginatedUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<GetAvailableProductsPaginatedUseCase>()) {
      getIt.registerLazySingleton(() => GetAvailableProductsPaginatedUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<SearchAndFilterProductsUseCase>()) {
      getIt.registerLazySingleton(() => SearchAndFilterProductsUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<SearchAllProductsUseCase>()) {
      getIt.registerLazySingleton(() => SearchAllProductsUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<GetProductBookingsUseCase>()) {
      getIt.registerLazySingleton(() => GetProductBookingsUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<GetProductGrowthDataUseCase>()) {
      getIt.registerLazySingleton(() => GetProductGrowthDataUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<GetMatchingProductsFromAnotherShopUseCase>()) {
      getIt.registerLazySingleton(() => GetMatchingProductsFromAnotherShopUseCase(getIt<IProductRepository>()));
    }
    if (!getIt.isRegistered<CheckVariantAvailabilityUseCase>()) {
      getIt.registerLazySingleton(() => CheckVariantAvailabilityUseCase(getIt<IProductRepository>()));
    }
  }
}
