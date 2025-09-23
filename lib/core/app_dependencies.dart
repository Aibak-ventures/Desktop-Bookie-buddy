import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/core/repositories/expense_repository.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/core/repositories/service_repository.dart';
import 'package:bookie_buddy_web/core/repositories/shop_repository.dart';
import 'package:bookie_buddy_web/core/repositories/user_repository.dart';
import 'package:bookie_buddy_web/core/services/booking_search_service.dart';
import 'package:bookie_buddy_web/core/services/booking_service.dart';
import 'package:bookie_buddy_web/core/services/client_services.dart';
import 'package:bookie_buddy_web/core/services/expense_service.dart';
import 'package:bookie_buddy_web/core/services/product_service/product_action_service.dart';
import 'package:bookie_buddy_web/core/services/product_service/product_query_service.dart';
import 'package:bookie_buddy_web/core/services/shop_service.dart';
import 'package:bookie_buddy_web/core/services/user_service.dart';
import 'package:bookie_buddy_web/features/auth/repository/auth_repository.dart';
import 'package:bookie_buddy_web/features/change_password/repository/change_password_repository.dart';
import 'package:bookie_buddy_web/features/home/repository/dashboard_repository.dart';
import 'package:bookie_buddy_web/features/home/services/dashboard_service.dart';
import 'package:bookie_buddy_web/features/wallet/repository/ledger_repository.dart';
import 'package:bookie_buddy_web/features/wallet/services/ledger_service.dart';
import 'package:bookie_buddy_web/features/wallet/services/payment_service.dart';
import 'package:bookie_buddy_web/features/wallet/services/pending_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class AppDependencies {
  static final _registerLazy = getIt.registerLazySingleton;
  static final _get = getIt.get;
  static void setupServices() {
    _registerLazy(UserService.new);
    _registerLazy(DashboardService.new);
    _registerLazy(BookingSearchService.new);
    _registerLazy(BookingService.new);
    _registerLazy(ProductQueryService.new);
    _registerLazy(ProductActionService.new);
    _registerLazy(ExpenseService.new);
    _registerLazy(PendingService.new);
    _registerLazy(PaymentService.new);
    _registerLazy(LedgerService.new);
    _registerLazy(ShopService.new);
    _registerLazy(ClientServices.new);
  }

  static void setupRepositories() {
    _registerLazy(
      () => UserRepository(_get<UserService>()),
    );

    _registerLazy(AuthRepository.new);

    _registerLazy(
      () => DashboardRepository(
        _get<DashboardService>(),
        // _get<BookingSearchService>(),
      ),
    );

    _registerLazy(
      () => BookingRepository(
        _get<BookingService>(),
        _get<BookingSearchService>(),
      ),
    );

    _registerLazy(
      ChangePasswordRepository.new,
    );
    _registerLazy(
      ServiceRepository.new,
    );
    _registerLazy(
      () => ShopRepository(
        service: _get<ShopService>(),
      ),
    );
    _registerLazy(
      () => ClientRepository(
        service: _get<ClientServices>(),
      ),
    );
    _registerLazy(
      () => ExpenseRepository(_get<ExpenseService>()),
    );

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

  /// Initializes the dependencies for the application by registering
  /// the BookingController using Get.lazyPut for dependency injection.
  static void init() {
    setupServices();
    setupRepositories();
  }
}
