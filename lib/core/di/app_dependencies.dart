import 'package:bookie_buddy_web/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/core/repositories/expense_repository.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/repositories/sales_repository.dart';
import 'package:bookie_buddy_web/core/repositories/service_repository.dart';
import 'package:bookie_buddy_web/core/repositories/shop_repository.dart';
import 'package:bookie_buddy_web/core/repositories/staff_repository.dart';
import 'package:bookie_buddy_web/core/repositories/user_repository.dart';
import 'package:bookie_buddy_web/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bookie_buddy_web/core/services/booking_service.dart';
import 'package:bookie_buddy_web/core/services/client_services.dart';
import 'package:bookie_buddy_web/core/services/expense_service.dart';
import 'package:bookie_buddy_web/core/services/product_service/product_action_service.dart';
import 'package:bookie_buddy_web/core/services/product_service/product_query_service.dart';
import 'package:bookie_buddy_web/core/services/sales_service.dart';
import 'package:bookie_buddy_web/core/services/service_api.dart';
import 'package:bookie_buddy_web/core/services/shop_service.dart';
import 'package:bookie_buddy_web/core/services/staff_service.dart';
import 'package:bookie_buddy_web/core/services/user_service.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_account_password_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_secret_password_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookie_buddy_web/features/home/repository/dashboard_repository.dart';
import 'package:bookie_buddy_web/features/home/services/dashboard_service.dart';
import 'package:bookie_buddy_web/features/ledger/repository/ledger_repository.dart';
import 'package:bookie_buddy_web/features/ledger/services/ledger_service.dart';
import 'package:bookie_buddy_web/features/ledger/services/payment_service.dart';
import 'package:bookie_buddy_web/features/ledger/services/pending_service.dart';
import 'package:bookie_buddy_web/features/search/data/datasources/search_remote_datasource.dart';
import 'package:bookie_buddy_web/features/search/data/repositories/search_repository_impl.dart';
import 'package:bookie_buddy_web/features/search/domain/repositories/i_search_repository.dart';
import 'package:bookie_buddy_web/features/search/domain/usecases/search_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class AppDependencies {
  static final _registerLazy = getIt.registerLazySingleton;
  static final _get = getIt.get;

  /// register services
  static void _registerServices() {
    _registerLazy(UserService.new);
    _registerLazy(DashboardService.new);
    _registerLazy(BookingService.new);
    _registerLazy(ProductQueryService.new);
    _registerLazy(ProductActionService.new);
    _registerLazy(ExpenseService.new);
    _registerLazy(PendingService.new);
    _registerLazy(PaymentService.new);
    _registerLazy(LedgerService.new);
    _registerLazy(ShopService.new);
    _registerLazy(ClientServices.new);
    _registerLazy(SharedPreferenceHelper.new);
    _registerLazy(ServiceApi.new);
    _registerLazy(SalesService.new);
    _registerLazy(StaffService.new);
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

    _registerLazy(() => DashboardRepository(_get<DashboardService>()));

    _registerLazy(() => BookingRepository(_get<BookingService>()));

    _registerLazy(() => ServiceRepository(serviceApi: _get<ServiceApi>()));

    _registerLazy(() => ShopRepository(service: _get<ShopService>()));

    _registerLazy(() => ClientRepository(service: _get<ClientServices>()));

    _registerLazy(() => ExpenseRepository(_get<ExpenseService>()));

    _registerLazy(() => SalesRepository(service: _get<SalesService>()));

    _registerLazy(() => StaffRepository(_get<StaffService>()));

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
    _registerAuthFeature();
    _registerSearchFeature();
  }

  // ================== feature specific ==================

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

  // ================== end of feature specific ==================

  /// Initializes the dependencies for the application by registering
  /// the BookingController using Get.lazyPut for dependency injection.
  static void init() {
    _registerServices();
    _registerFeatures();
    _registerRepositories();
  }
}
