import 'package:bookie_buddy_web/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/features/client/data/datasources/client_remote_datasource.dart';
import 'package:bookie_buddy_web/features/client/domain/repositories/i_client_repository.dart';
import 'package:bookie_buddy_web/features/client/data/repositories/client_repository_impl.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/get_clients_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/add_client_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/update_client_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/delete_client_usecase.dart';
import 'package:bookie_buddy_web/features/expense/data/repositories/expense_repository_impl.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/features/sales/data/repositories/sales_repository_impl.dart';
import 'package:bookie_buddy_web/features/sales/domain/repositories/i_sales_repository.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/create_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/delete_sale_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_details_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sale_invoice_pdf_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/get_sales_usecase.dart';
import 'package:bookie_buddy_web/features/sales/domain/usecases/update_sale_usecase.dart';
import 'package:bookie_buddy_web/core/repositories/service_repository.dart';
import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/repositories/shop_repository.dart';
import 'package:bookie_buddy_web/core/common/domain/usecases/launch_email_support_usecase.dart';
import 'package:bookie_buddy_web/core/common/domain/usecases/launch_whatsapp_support_usecase.dart';
import 'package:bookie_buddy_web/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:bookie_buddy_web/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:bookie_buddy_web/features/settings/domain/repositories/i_settings_repository.dart';
import 'package:bookie_buddy_web/features/settings/domain/usecases/update_shop_privacy_settings_usecase.dart';
import 'package:bookie_buddy_web/features/settings/domain/usecases/update_shop_settings_usecase.dart';
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
import 'package:bookie_buddy_web/core/repositories/user_repository.dart';
import 'package:bookie_buddy_web/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bookie_buddy_web/core/services/booking_service.dart';
import 'package:bookie_buddy_web/features/expense/data/datasources/expense_remote_datasources.dart';
import 'package:bookie_buddy_web/features/expense/domain/usecases/save_expense_usecase.dart';
import 'package:bookie_buddy_web/features/expense/domain/usecases/save_product_expense_usecase.dart';
import 'package:bookie_buddy_web/features/expense/domain/usecases/delete_expense_usecase.dart';
import 'package:bookie_buddy_web/features/expense/domain/repositories/i_expense_repository.dart';
import 'package:bookie_buddy_web/core/services/product_service/product_action_service.dart';
import 'package:bookie_buddy_web/core/services/product_service/product_query_service.dart';
import 'package:bookie_buddy_web/features/sales/data/datasources/sales_remote_datasource.dart';
import 'package:bookie_buddy_web/core/services/service_api.dart';
import 'package:bookie_buddy_web/core/services/shop_service.dart';
import 'package:bookie_buddy_web/features/staff/data/datasources/staff_remote_datasource.dart';
import 'package:bookie_buddy_web/core/services/user_service.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_account_password_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_secret_password_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookie_buddy_web/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:bookie_buddy_web/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:bookie_buddy_web/features/ledger/repository/ledger_repository.dart';
import 'package:bookie_buddy_web/features/ledger/services/ledger_service.dart';
import 'package:bookie_buddy_web/features/ledger/services/payment_service.dart';
import 'package:bookie_buddy_web/features/ledger/services/pending_service.dart';
import 'package:bookie_buddy_web/features/search/data/datasources/search_remote_datasource.dart';
import 'package:bookie_buddy_web/features/search/data/repositories/search_repository_impl.dart';
import 'package:bookie_buddy_web/features/search/domain/repositories/i_search_repository.dart';
import 'package:bookie_buddy_web/features/search/domain/usecases/search_usecase.dart';
import 'package:bookie_buddy_web/features/profile/data/datasources/bug_report_remote_datasource.dart';
import 'package:bookie_buddy_web/features/profile/data/datasources/shop_activity_remote_datasource.dart';
import 'package:bookie_buddy_web/features/profile/data/repositories/bug_report_repository_impl.dart';
import 'package:bookie_buddy_web/features/profile/data/repositories/shop_activity_repository_impl.dart';
import 'package:bookie_buddy_web/features/profile/domain/repositories/i_bug_report_repository.dart';
import 'package:bookie_buddy_web/features/profile/domain/repositories/i_shop_activity_repository.dart';
import 'package:bookie_buddy_web/features/profile/domain/usecases/submit_bug_report_usecase.dart';
import 'package:bookie_buddy_web/features/profile/domain/usecases/load_shop_activities_usecase.dart';
import 'package:bookie_buddy_web/features/profile/domain/usecases/load_next_shop_activities_page_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class AppDependencies {
  static final _registerLazy = getIt.registerLazySingleton;
  static final _get = getIt.get;

  /// register services
  static void _registerServices() {
    _registerLazy(UserService.new);
    _registerLazy(ProductQueryService.new);
    _registerLazy(ProductActionService.new);
    _registerLazy(PendingService.new);
    _registerLazy(PaymentService.new);
    _registerLazy(LedgerService.new);
    _registerLazy(ShopService.new);
    _registerLazy(BookingService.new);
    _registerLazy(SharedPreferenceHelper.new);
    _registerLazy(ServiceApi.new);
  }

  /// register repositories
  static void _registerRepositories() {
    _registerLazy(
      () => UserRepository(
        userService: _get<UserService>(),
        prefs: _get<SharedPreferenceHelper>(),
        authRepository: _get<IAuthRepository>(),
      ),
    );

    _registerLazy(
        () => DashboardRepositoryImpl(_get<DashboardRemoteDatasource>()));

    _registerLazy(() => BookingRepository(_get<BookingService>()));

    _registerLazy(() => ServiceRepository(serviceApi: _get<ServiceApi>()));

    _registerLazy(() => ShopRepository(service: _get<ShopService>()));
    _registerLazy(
      () => ProductRepository(
        queryService: _get<ProductQueryService>(),
        actionService: _get<ProductActionService>(),
      ),
    );
    _registerLazy(
      () => LedgerRepository(
        ledgerService: _get<LedgerService>(),
        balanceService: _get<PendingService>(),
        paymentService: _get<PaymentService>(),
      ),
    );
  }

  /// register feature specific dependencies
  static void _registerFeatures() {
    _registerCommon();
    _registerAuthFeature();
    _registerSearchFeature();
    _registerExpenseFeature();
    _registerClientFeature();
    _registerStaffFeature();
    _registerDashboardFeature();
    _registerSettingsFeature();
    _registerProfileFeature();
    _registerSalesFeature();
  }

  // ================== feature specific ==================

  static void _registerCommon() {
    _registerLazy(() => LaunchEmailSupportUsecase());
    _registerLazy(() => LaunchWhatsappSupportUsecase());
  }

  /// register auth use cases
  static void _registerAuthFeature() {
    _registerLazy(AuthRemoteDatasource.new);
    _registerLazy<IAuthRepository>(
        () => AuthRepositoryImpl(_get<AuthRemoteDatasource>()));
    _registerLazy(
      () => LoginUseCase(_get<IAuthRepository>()),
    );
    _registerLazy(() => ChangeAccountPasswordUseCase(_get<IAuthRepository>()));
    _registerLazy(() => ChangeSecretPasswordUseCase(_get<IAuthRepository>()));
  }

  /// register global search use cases
  static void _registerSearchFeature() {
    _registerLazy(SearchRemoteDatasource.new);
    _registerLazy<ISearchRepository>(
        () => SearchRepositoryImpl(_get<SearchRemoteDatasource>()));
    _registerLazy(
      () => SearchUseCase(_get<ISearchRepository>()),
    );
  }

  static void _registerExpenseFeature() {
    _registerLazy(ExpenseRemoteDataSource.new);
    _registerLazy<IExpenseRepository>(
        () => ExpenseRepositoryImpl(_get<ExpenseRemoteDataSource>()));
    _registerLazy(() => SaveExpenseUsecase(_get<IExpenseRepository>()));
    _registerLazy(() => SaveProductExpenseUsecase(_get<IExpenseRepository>()));
    _registerLazy(() => DeleteExpenseUsecase(_get<IExpenseRepository>()));
  }

  static void _registerClientFeature() {
    _registerLazy(ClientRemoteDatasource.new);
    _registerLazy<IClientRepository>(
        () => ClientRepositoryImpl(_get<ClientRemoteDatasource>()));
    _registerLazy(() => GetClientsUseCase(_get<IClientRepository>()));
    _registerLazy(() => AddClientUseCase(_get<IClientRepository>()));
    _registerLazy(() => UpdateClientUseCase(_get<IClientRepository>()));
    _registerLazy(() => DeleteClientUseCase(_get<IClientRepository>()));
  }

  static void _registerStaffFeature() {
    _registerLazy(StaffRemoteDatasource.new);
    _registerLazy<IStaffRepository>(
        () => StaffRepositoryImpl(_get<StaffRemoteDatasource>()));
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
    _registerLazy(DashboardRemoteDatasource.new);
    _registerLazy<IDashboardRepository>(
        () => DashboardRepositoryImpl(_get<DashboardRemoteDatasource>()));
    _registerLazy(
      () => GetDashboardDesktopDataUseCase(_get<IDashboardRepository>()),
    );
  }

  static void _registerSettingsFeature() {
    _registerLazy(SettingsRemoteDatasource.new);
    _registerLazy<ISettingsRepository>(
        () => SettingsRepositoryImpl(_get<SettingsRemoteDatasource>()));
    _registerLazy(
      () => UpdateShopPrivacySettingsUseCase(_get<ISettingsRepository>()),
    );
    _registerLazy(
      () => UpdateShopSettingsUseCase(_get<ISettingsRepository>()),
    );
  }

  static void _registerProfileFeature() {
    _registerLazy(() => BugReportRemoteDatasource(DioClient.dio));
    _registerLazy(() => ShopActivityRemoteDatasource(DioClient.dio));

    _registerLazy<IBugReportRepository>(
        () => BugReportRepositoryImpl(_get<BugReportRemoteDatasource>()));
    _registerLazy<IShopActivityRepository>(
        () => ShopActivityRepositoryImpl(_get<ShopActivityRemoteDatasource>()));

    _registerLazy(() => SubmitBugReportUseCase(_get<IBugReportRepository>()));
    _registerLazy(
        () => LoadShopActivitiesUseCase(_get<IShopActivityRepository>()));
    _registerLazy(() =>
        LoadNextShopActivitiesPageUseCase(_get<IShopActivityRepository>()));
  }

  static void _registerSalesFeature() {
    _registerLazy(SalesRemoteDatasource.new);
    _registerLazy<ISalesRepository>(
        () => SalesRepositoryImpl(service: _get<SalesRemoteDatasource>()));
    _registerLazy(() => GetSalesUseCase(_get<ISalesRepository>()));
    _registerLazy(() => GetSaleDetailsUseCase(_get<ISalesRepository>()));
    _registerLazy(() => CreateSaleUseCase(_get<ISalesRepository>()));
    _registerLazy(() => UpdateSaleUseCase(_get<ISalesRepository>()));
    _registerLazy(() => DeleteSaleUseCase(_get<ISalesRepository>()));
    _registerLazy(() => GetSaleInvoicePdfUseCase(_get<ISalesRepository>()));
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
