import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:bookie_buddy_web/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/add_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/cancel_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_old_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_sale_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_booking_usecase.dart';
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
    getIt.registerLazySingleton(
        () => BookingRemoteDatasource(dio: DioClient.dio));
    getIt.registerLazySingleton<IBookingRepository>(
      () => BookingRepositoryImpl(getIt()),
    );
    getIt.registerLazySingleton(
        () => GetBookingUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => AddBookingUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => CreateSaleBookingUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => CreateOldBookingUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => UpdatePaymentUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => UpdateBookingUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => UpdateBookingPartialUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => DeleteBookingUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => CancelBookingUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => UpdateBookingStatusUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => UpdateDeliveryStatusUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => LoadBookingsPaginationUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => LoadDesktopBookingsPaginationUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => DownloadBookingInvoiceUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => GetPaymentHistoryUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => SendInvoiceUseCase(getIt<IBookingRepository>()));
    getIt.registerLazySingleton(
        () => GetBookingInvoicePdfBytesUseCase(getIt<IBookingRepository>()));
  }
}
