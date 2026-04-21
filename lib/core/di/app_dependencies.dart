import 'package:bookie_buddy_web/core/common/usecases/launch_email_support_usecase.dart';
import 'package:bookie_buddy_web/core/common/usecases/launch_whatsapp_support_usecase.dart';
import 'package:bookie_buddy_web/core/di/features/account_dependencies.dart';
import 'package:bookie_buddy_web/core/di/features/auth_dependencies.dart';
import 'package:bookie_buddy_web/core/di/features/booking_dependencies.dart';
import 'package:bookie_buddy_web/core/di/features/client_dependencies.dart';
import 'package:bookie_buddy_web/core/di/features/dashboard_dependencies.dart';
import 'package:bookie_buddy_web/core/di/features/product_dependencies.dart';
import 'package:bookie_buddy_web/core/di/features/sales_dependencies.dart';
import 'package:bookie_buddy_web/core/di/features/shop_dependencies.dart';
import 'package:bookie_buddy_web/core/di/features/staff_dependencies.dart';
import 'package:bookie_buddy_web/core/session/session_storage.dart';
import 'package:bookie_buddy_web/core/session/token_refresh_manager.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:bookie_buddy_web/features/splash/domain/usecases/splash_initialization_usecase.dart';
import 'package:bookie_buddy_web/utils/shared_preference_helper.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

class AppDependencies {
  /// Initializes the dependencies for the application
  static void init(SharedPreferences prefs) {
    _registerFeatures(prefs);
  }

  /// register feature specific dependencies
  static void _registerFeatures(SharedPreferences prefs) {
    _registerCommon(prefs);
    ShopDependencies.register();
    AuthDependencies.register();
    ClientDependencies.register();
    StaffDependencies.register();
    DashboardDependencies.register();
    SalesDependencies.register();
    ProductDependencies.register();
    BookingDependencies.register();
    AccountDependencies.register();
  }

  // ================== common ==================
  static void _registerCommon(SharedPreferences prefs) {
    getIt.registerLazySingleton(() => SharedPreferenceHelper(prefs));
    getIt.registerLazySingleton(
      () => SessionStorage(getIt<SharedPreferenceHelper>()),
    );
    getIt.registerLazySingleton<TokenRefreshManager>(
      () => TokenRefreshManager(
        refreshCallback: () => getIt<IAuthRepository>().refreshToken(),
        sessionStorage: getIt<SessionStorage>(),
      ),
    );
    getIt.registerLazySingleton(() => LaunchEmailSupportUsecase());
    getIt.registerLazySingleton(() => LaunchWhatsappSupportUsecase());
    getIt.registerLazySingleton(
      () => SplashInitializationUseCase(
        prefs: getIt<SharedPreferenceHelper>(),
        sessionStorage: getIt<SessionStorage>(),
      ),
    );
  }
}
