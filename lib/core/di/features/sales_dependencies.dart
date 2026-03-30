import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/sales/data/datasources/sales_remote_datasource.dart';
import 'package:bookie_buddy_web/features/sales/data/repositories/sales_repository_impl.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/create_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/delete_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_details_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_invoice_pdf_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sales_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/send_sale_invoice_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/update_sale_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class SalesDependencies {
  static void register() {
    if (!getIt.isRegistered<SalesRemoteDatasource>()) {
      getIt.registerLazySingleton(() => SalesRemoteDatasource(dio: DioClient.dio));
    }
    if (!getIt.isRegistered<SalesRepositoryImpl>()) {
      getIt.registerLazySingleton(() => SalesRepositoryImpl(service: getIt()));
    }
    if (!getIt.isRegistered<ISalesRepository>()) {
      getIt.registerLazySingleton<ISalesRepository>(() => getIt<SalesRepositoryImpl>());
    }
    if (!getIt.isRegistered<GetSalesUseCase>()) {
      getIt.registerLazySingleton(() => GetSalesUseCase(getIt<ISalesRepository>()));
    }
    if (!getIt.isRegistered<GetSaleDetailsUseCase>()) {
      getIt.registerLazySingleton(() => GetSaleDetailsUseCase(getIt<ISalesRepository>()));
    }
    if (!getIt.isRegistered<CreateSaleUseCase>()) {
      getIt.registerLazySingleton(() => CreateSaleUseCase(getIt<ISalesRepository>()));
    }
    if (!getIt.isRegistered<UpdateSaleUseCase>()) {
      getIt.registerLazySingleton(() => UpdateSaleUseCase(getIt<ISalesRepository>()));
    }
    if (!getIt.isRegistered<DeleteSaleUseCase>()) {
      getIt.registerLazySingleton(() => DeleteSaleUseCase(getIt<ISalesRepository>()));
    }
    if (!getIt.isRegistered<GetSaleInvoicePdfUseCase>()) {
      getIt.registerLazySingleton(() => GetSaleInvoicePdfUseCase(getIt<ISalesRepository>()));
    }
    if (!getIt.isRegistered<SendSaleInvoiceUsecase>()) {
      getIt.registerLazySingleton(() => SendSaleInvoiceUsecase(getIt<ISalesRepository>()));
    }
  }
}
