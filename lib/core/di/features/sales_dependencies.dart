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
    getIt.registerLazySingleton(
        () => SalesRemoteDatasource(dio: DioClient.dio));
    getIt.registerLazySingleton<ISalesRepository>(
        () => SalesRepositoryImpl(service: getIt()));
    getIt.registerLazySingleton(
        () => GetSalesUseCase(getIt<ISalesRepository>()));
    getIt.registerLazySingleton(
        () => GetSaleDetailsUseCase(getIt<ISalesRepository>()));
    getIt.registerLazySingleton(
        () => CreateSaleUseCase(getIt<ISalesRepository>()));
    getIt.registerLazySingleton(
        () => UpdateSaleUseCase(getIt<ISalesRepository>()));
    getIt.registerLazySingleton(
        () => DeleteSaleUseCase(getIt<ISalesRepository>()));
    getIt.registerLazySingleton(
        () => GetSaleInvoicePdfUseCase(getIt<ISalesRepository>()));
    getIt.registerLazySingleton(
        () => SendSaleInvoiceUsecase(getIt<ISalesRepository>()));
  }
}
