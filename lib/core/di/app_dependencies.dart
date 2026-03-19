import 'package:bookie_buddy_web/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookie_buddy_web/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:bookie_buddy_web/features/booking/data/datasources/booking_remote_datasource.dart';
import 'package:bookie_buddy_web/features/booking/domain/repositories/i_booking_repository.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/add_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_sale_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/create_old_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_payment_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_partial_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/cancel_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_delivery_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/load_bookings_pagination_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/load_desktop_bookings_pagination_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/download_booking_invoice_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_payment_history_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/send_invoice_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_invoice_pdf_bytes_usecase.dart';
import 'package:bookie_buddy_web/features/client/data/datasources/client_remote_datasource.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';
import 'package:bookie_buddy_web/features/client/data/repositories/client_repository_impl.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/get_clients_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/add_client_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/update_client_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/delete_client_usecase.dart';
import 'package:bookie_buddy_web/features/product/data/repositories/product_repository_impl.dart';
import 'package:bookie_buddy_web/features/sales/data/repositories/sales_repository_impl.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/create_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/delete_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_details_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_invoice_pdf_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sales_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/update_sale_usecase.dart';
import 'package:bookie_buddy_web/features/shop/data/datasources/shop_remote_datasource.dart';
import 'package:bookie_buddy_web/features/shop/data/repositories/shop_repository_impl.dart';
import 'package:bookie_buddy_web/features/shop/domain/repositories/i_shop_repository.dart';
import 'package:bookie_buddy_web/features/shop/domain/usecases/get_shops_usecase.dart';
import 'package:bookie_buddy_web/features/shop/domain/usecases/get_shop_services_usecase.dart';
import 'package:bookie_buddy_web/core/common/usecases/launch_email_support_usecase.dart';
import 'package:bookie_buddy_web/core/common/usecases/launch_whatsapp_support_usecase.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/repositories/i_dashboard_repository.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/usecases/get_dashboard_desktop_data_usecase.dart';
import 'package:bookie_buddy_web/features/staff/data/repositories/staff_repository_impl.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/add_staff_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/delete_staff_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/edit_staff_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staff_analytics_report_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staff_monthly_bookings_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staff_monthly_sales_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staffs_usecase.dart';
import 'package:bookie_buddy_web/features/auth/data/datasources/user_remote_datasource.dart';
import 'package:bookie_buddy_web/features/auth/data/repositories/user_repository_impl.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/register_fcm_token_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/switch_shop_usecase.dart';
import 'package:bookie_buddy_web/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bookie_buddy_web/features/product/data/datasources/product_action_remote_datasource.dart';
import 'package:bookie_buddy_web/features/product/data/datasources/product_query_remote_datasource.dart';
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
import 'package:bookie_buddy_web/features/sales/data/datasources/sales_remote_datasource.dart';
import 'package:bookie_buddy_web/features/staff/data/datasources/staff_remote_datasource.dart';
import 'package:bookie_buddy_web/utils/shared_preference_helper.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_account_password_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_secret_password_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookie_buddy_web/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:bookie_buddy_web/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class AppDependencies {
  static final _registerLazy = getIt.registerLazySingleton;
  static final _get = getIt.get;

  /// register services
  static void _registerServices() {
    _registerLazy(SharedPreferenceHelper.new);
  }

  /// register repositories — kept empty, all moved to feature registrations
  static void _registerRepositories() {}

  /// register feature specific dependencies
  static void _registerFeatures() {
    _registerCommon();
    _registerShopFeature();
    _registerAuthFeature();
    _registerClientFeature();
    _registerStaffFeature();
    _registerDashboardFeature();
    _registerSalesFeature();
    _registerProductFeature();
    _registerBookingsFeature();
  }

  // ================== feature specific ==================

  static void _registerShopFeature() {
    _registerLazy(() => ShopRemoteDatasource(dio: DioClient.dio));
    _registerLazy<IShopRepository>(() => ShopRepositoryImpl(_get()));
    _registerLazy(() => GetShopsUseCase(_get<IShopRepository>()));
    _registerLazy(() => GetShopServicesUseCase(_get<IShopRepository>()));
  }

  static void _registerCommon() {
    _registerLazy(() => LaunchEmailSupportUsecase());
    _registerLazy(() => LaunchWhatsappSupportUsecase());
  }

  /// register auth use cases
  static void _registerAuthFeature() {
    // auth
    _registerLazy(() => AuthRemoteDatasource(dio: DioClient.dio));
    _registerLazy<IAuthRepository>(() => AuthRepositoryImpl(_get()));
    _registerLazy(() => LoginUseCase(_get<IAuthRepository>()));
    _registerLazy(() => ChangeAccountPasswordUseCase(_get<IAuthRepository>()));
    _registerLazy(() => ChangeSecretPasswordUseCase(_get<IAuthRepository>()));
    // user session
    _registerLazy(() => UserRemoteDatasource(dio: DioClient.dio));
    _registerLazy<IUserRepository>(
      () => UserRepositoryImpl(
        datasource: _get(),
        prefs: _get<SharedPreferenceHelper>(),
        authRepository: _get<IAuthRepository>(),
      ),
    );
    _registerLazy(() => GetUserUseCase(_get<IUserRepository>()));
    _registerLazy(() => LogoutUseCase(_get<IUserRepository>()));
    _registerLazy(() => SwitchShopUseCase(_get<IUserRepository>()));
    _registerLazy(() => RegisterFCMTokenUseCase(_get<IUserRepository>()));
  }

  static void _registerClientFeature() {
    _registerLazy(() => ClientRemoteDatasource(dio: DioClient.dio));
    _registerLazy<IClientRepository>(() => ClientRepositoryImpl(_get()));
    _registerLazy(() => GetClientsUseCase(_get<IClientRepository>()));
    _registerLazy(() => AddClientUseCase(_get<IClientRepository>()));
    _registerLazy(() => UpdateClientUseCase(_get<IClientRepository>()));
    _registerLazy(() => DeleteClientUseCase(_get<IClientRepository>()));
  }

  static void _registerStaffFeature() {
    _registerLazy(() => StaffRemoteDatasource(dio: DioClient.dio));
    _registerLazy<IStaffRepository>(() => StaffRepositoryImpl(_get()));
    _registerLazy(() => GetStaffsUseCase(_get<IStaffRepository>()));
    _registerLazy(() => AddStaffUseCase(_get<IStaffRepository>()));
    _registerLazy(() => EditStaffUseCase(_get<IStaffRepository>()));
    _registerLazy(() => DeleteStaffUseCase(_get<IStaffRepository>()));
    _registerLazy(
        () => GetStaffAnalyticsReportUseCase(_get<IStaffRepository>()));
    _registerLazy(
        () => GetStaffMonthlyBookingsUseCase(_get<IStaffRepository>()));
    _registerLazy(() => GetStaffMonthlySalesUseCase(_get<IStaffRepository>()));
  }

  static void _registerDashboardFeature() {
    _registerLazy(() => DashboardRemoteDatasource(dio: DioClient.dio));
    _registerLazy<IDashboardRepository>(() => DashboardRepositoryImpl(_get()));
    _registerLazy(
      () => GetDashboardDesktopDataUseCase(_get<IDashboardRepository>()),
    );
  }

  static void _registerSalesFeature() {
    _registerLazy(() => SalesRemoteDatasource(dio: DioClient.dio));
    _registerLazy<ISalesRepository>(() => SalesRepositoryImpl(service: _get()));
    _registerLazy(() => GetSalesUseCase(_get<ISalesRepository>()));
    _registerLazy(() => GetSaleDetailsUseCase(_get<ISalesRepository>()));
    _registerLazy(() => CreateSaleUseCase(_get<ISalesRepository>()));
    _registerLazy(() => UpdateSaleUseCase(_get<ISalesRepository>()));
    _registerLazy(() => DeleteSaleUseCase(_get<ISalesRepository>()));
    _registerLazy(() => GetSaleInvoicePdfUseCase(_get<ISalesRepository>()));
  }

  static void _registerProductFeature() {
    _registerLazy(() => ProductQueryRemoteDatasource(dio: DioClient.dio));
    _registerLazy(() => ProductActionRemoteDatasource(dio: DioClient.dio));
    _registerLazy<IProductRepository>(
      () => ProductRepositoryImpl(
        queryDatasource: _get(),
        actionDatasource: _get(),
      ),
    );
    _registerLazy(() => SaveProductUseCase(_get<IProductRepository>()));
    _registerLazy(() => DeleteProductUseCase(_get<IProductRepository>()));
    _registerLazy(() => UpdateVariantUseCase(_get<IProductRepository>()));
    _registerLazy(() => AddProductVariantsUseCase(_get<IProductRepository>()));
    _registerLazy(
        () => TransferProductToAnotherShopUseCase(_get<IProductRepository>()));
    _registerLazy(() => GetProductInfoUseCase(_get<IProductRepository>()));
    _registerLazy(
        () => GetProductsPaginatedUseCase(_get<IProductRepository>()));
    _registerLazy(
        () => GetAvailableProductsPaginatedUseCase(_get<IProductRepository>()));
    _registerLazy(
        () => SearchAndFilterProductsUseCase(_get<IProductRepository>()));
    _registerLazy(() => SearchAllProductsUseCase(_get<IProductRepository>()));
    _registerLazy(() => GetProductBookingsUseCase(_get<IProductRepository>()));
    _registerLazy(
        () => GetProductGrowthDataUseCase(_get<IProductRepository>()));
    _registerLazy(() =>
        GetMatchingProductsFromAnotherShopUseCase(_get<IProductRepository>()));
    _registerLazy(
        () => CheckVariantAvailabilityUseCase(_get<IProductRepository>()));
  }

  static void _registerBookingsFeature() {
    _registerLazy(() => BookingRemoteDatasource(dio: DioClient.dio));
    _registerLazy<IBookingRepository>(
      () => BookingRepositoryImpl(_get()),
    );
    _registerLazy(() => GetBookingUseCase(_get<IBookingRepository>()));
    _registerLazy(() => AddBookingUseCase(_get<IBookingRepository>()));
    _registerLazy(() => CreateSaleBookingUseCase(_get<IBookingRepository>()));
    _registerLazy(() => CreateOldBookingUseCase(_get<IBookingRepository>()));
    _registerLazy(() => UpdatePaymentUseCase(_get<IBookingRepository>()));
    _registerLazy(() => UpdateBookingUseCase(_get<IBookingRepository>()));
    _registerLazy(
        () => UpdateBookingPartialUseCase(_get<IBookingRepository>()));
    _registerLazy(() => DeleteBookingUseCase(_get<IBookingRepository>()));
    _registerLazy(() => CancelBookingUseCase(_get<IBookingRepository>()));
    _registerLazy(() => UpdateBookingStatusUseCase(_get<IBookingRepository>()));
    _registerLazy(
        () => UpdateDeliveryStatusUseCase(_get<IBookingRepository>()));
    _registerLazy(
        () => LoadBookingsPaginationUseCase(_get<IBookingRepository>()));
    _registerLazy(
        () => LoadDesktopBookingsPaginationUseCase(_get<IBookingRepository>()));
    _registerLazy(
        () => DownloadBookingInvoiceUseCase(_get<IBookingRepository>()));
    _registerLazy(() => GetPaymentHistoryUseCase(_get<IBookingRepository>()));
    _registerLazy(() => SendInvoiceUseCase(_get<IBookingRepository>()));
    _registerLazy(() => GetInvoicePdfBytesUseCase(_get<IBookingRepository>()));
  }

  // ================== end of feature specific ==================

  /// Initializes the dependencies for the application by registering
  /// the BookingController using Get.lazyPut for dependency injection.
  static void init() {
    _registerServices();
    _registerFeatures();
    _registerRepositories();
  }
}
