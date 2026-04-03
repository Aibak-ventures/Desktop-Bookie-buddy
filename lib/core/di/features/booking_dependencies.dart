import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:bookie_buddy_web/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/add_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/cancel_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_old_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_sale_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_payment_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/download_booking_invoice_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_booking_invoice_pdf_bytes_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_payment_history_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/load_bookings_pagination_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/load_desktop_bookings_pagination_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/send_invoice_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_partial_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_delivery_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_payment_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';

class BookingDependencies {
  static void register() {
    if (!getIt.isRegistered<BookingRemoteDatasource>()) {
      getIt.registerLazySingleton(() => BookingRemoteDatasource(dio: DioClient.dio));
    }
    if (!getIt.isRegistered<BookingRepositoryImpl>()) {
      getIt.registerLazySingleton(() => BookingRepositoryImpl(getIt()));
    }
    if (!getIt.isRegistered<IBookingRepository>()) {
      getIt.registerLazySingleton<IBookingRepository>(() => getIt<BookingRepositoryImpl>());
    }
    if (!getIt.isRegistered<GetBookingUseCase>()) {
      getIt.registerLazySingleton(() => GetBookingUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<AddBookingUseCase>()) {
      getIt.registerLazySingleton(() => AddBookingUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<CreateSaleBookingUseCase>()) {
      getIt.registerLazySingleton(() => CreateSaleBookingUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<CreateOldBookingUseCase>()) {
      getIt.registerLazySingleton(() => CreateOldBookingUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<UpdatePaymentUseCase>()) {
      getIt.registerLazySingleton(() => UpdatePaymentUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<UpdateBookingUseCase>()) {
      getIt.registerLazySingleton(() => UpdateBookingUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<UpdateBookingPartialUseCase>()) {
      getIt.registerLazySingleton(() => UpdateBookingPartialUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<DeleteBookingUseCase>()) {
      getIt.registerLazySingleton(() => DeleteBookingUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<DeletePaymentUseCase>()) {
      getIt.registerLazySingleton(() => DeletePaymentUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<CancelBookingUseCase>()) {
      getIt.registerLazySingleton(() => CancelBookingUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<UpdateBookingStatusUseCase>()) {
      getIt.registerLazySingleton(() => UpdateBookingStatusUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<UpdateDeliveryStatusUseCase>()) {
      getIt.registerLazySingleton(() => UpdateDeliveryStatusUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<LoadBookingsPaginationUseCase>()) {
      getIt.registerLazySingleton(() => LoadBookingsPaginationUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<LoadDesktopBookingsPaginationUseCase>()) {
      getIt.registerLazySingleton(() => LoadDesktopBookingsPaginationUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<DownloadBookingInvoiceUseCase>()) {
      getIt.registerLazySingleton(() => DownloadBookingInvoiceUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<GetPaymentHistoryUseCase>()) {
      getIt.registerLazySingleton(() => GetPaymentHistoryUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<SendInvoiceUseCase>()) {
      getIt.registerLazySingleton(() => SendInvoiceUseCase(getIt<IBookingRepository>()));
    }
    if (!getIt.isRegistered<GetBookingInvoicePdfBytesUseCase>()) {
      getIt.registerLazySingleton(() => GetBookingInvoicePdfBytesUseCase(getIt<IBookingRepository>()));
    }
  }
}
