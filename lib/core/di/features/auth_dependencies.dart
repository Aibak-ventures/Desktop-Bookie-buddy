import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/session/session_storage.dart';
import 'package:bookie_buddy_web/core/session/token_refresh_manager.dart';
import 'package:bookie_buddy_web/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bookie_buddy_web/features/auth/data/datasources/user_remote_datasource.dart';
import 'package:bookie_buddy_web/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookie_buddy_web/features/auth/data/repositories/user_repository_impl.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_user_repository.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_account_password_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/change_secret_password_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/logout_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/register_fcm_token_usecase.dart';
import 'package:bookie_buddy_web/features/auth/domain/usecases/switch_shop_usecase.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/utils/shared_preference_helper.dart';

class AuthDependencies {
  static void register() {
    // auth
    getIt.registerLazySingleton(() => AuthRemoteDatasource(
          dio: DioClient.dio,
          prefs: getIt<SharedPreferenceHelper>(),
          tokenRefreshManager: getIt<TokenRefreshManager>(),
          sessionStorage: getIt<SessionStorage>(),
        ));
    getIt.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(
          datasource: getIt(),
          prefs: getIt<SharedPreferenceHelper>(),
          sessionStorage: getIt<SessionStorage>(),
        ));
    getIt.registerLazySingleton(
        () => LoginUseCase(getIt<IAuthRepository>()));
    getIt.registerLazySingleton(
        () => ChangeAccountPasswordUseCase(getIt<IAuthRepository>()));
    getIt.registerLazySingleton(
        () => ChangeSecretPasswordUseCase(getIt<IAuthRepository>()));
    // user session
    getIt.registerLazySingleton(
        () => UserRemoteDatasource(dio: DioClient.dio));
    getIt.registerLazySingleton<IUserRepository>(
      () => UserRepositoryImpl(
        datasource: getIt(),
        prefs: getIt<SharedPreferenceHelper>(),
        authRepository: getIt<IAuthRepository>(),
        sessionStorage: getIt<SessionStorage>(),
      ),
    );
    getIt.registerLazySingleton(
        () => GetUserUseCase(getIt<IUserRepository>()));
    getIt.registerLazySingleton(
        () => LogoutUseCase(getIt<IUserRepository>()));
    getIt.registerLazySingleton(
        () => SwitchShopUseCase(getIt<IUserRepository>()));
    getIt.registerLazySingleton(
        () => RegisterFCMTokenUseCase(getIt<IUserRepository>()));
  }
}
