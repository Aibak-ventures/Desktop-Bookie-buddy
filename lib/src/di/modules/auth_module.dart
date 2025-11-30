import 'package:get_it/get_it.dart';

/// Auth module for dependency injection
/// 
/// Registers:
/// - Auth data sources
/// - Auth repositories
/// - Auth use cases
/// - Auth BLoC
class AuthModule {
  static Future<void> init(GetIt getIt) async {
    // TODO: Register auth dependencies
    // Example:
    // getIt.registerLazySingleton<AuthRemoteDataSource>(
    //   () => AuthRemoteDataSourceImpl(dio: getIt()),
    // );
    //
    // getIt.registerLazySingleton<AuthRepository>(
    //   () => AuthRepositoryImpl(remoteDataSource: getIt()),
    // );
    //
    // getIt.registerLazySingleton(
    //   () => LoginUseCase(repository: getIt()),
    // );
    //
    // getIt.registerFactory(
    //   () => AuthBloc(loginUseCase: getIt(), logoutUseCase: getIt()),
    // );
  }
}
