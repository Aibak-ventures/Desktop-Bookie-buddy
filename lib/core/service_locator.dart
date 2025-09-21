import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'network/api_service.dart';
import 'network/network_info.dart';
import 'network/interceptors/global_dio_interceptor.dart';
import 'services/token_refresh_service.dart';
import 'env/env_config.dart';

// Auth feature imports
import '../feature/auth/data/datasources/auth_remote_data_source.dart';
import '../feature/auth/data/repositories/auth_repository_impl.dart';
import '../feature/auth/domain/repositories/auth_repository.dart';
import '../feature/auth/domain/usecases/auth_usecases.dart';
import '../feature/auth/presentation/bloc/auth_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  print('🔧 Initializing dependencies...');

  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  
  // Environment configuration
  // EnvConfig doesn't need initialize, it uses dotenv
  
  // Dio configuration
  final dio = Dio();
  dio.options.baseUrl = EnvConfig.apiBaseUrl;
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  sl.registerSingleton<Dio>(dio);
  
  // Network Info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl<Connectivity>()),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl<Dio>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RefreshTokenUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => SecretLoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));

  // BLoCs
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl<LoginUseCase>(),
    refreshTokenUseCase: sl<RefreshTokenUseCase>(),
    getUserProfileUseCase: sl<GetUserProfileUseCase>(),
    logoutUseCase: sl<LogoutUseCase>(),
  ));
  
  // Services
  sl.registerLazySingleton<TokenRefreshService>(
    () => TokenRefreshServiceImpl(dio: sl<Dio>()),
  );
  
  // Interceptors
  sl.registerLazySingleton<GlobalDioInterceptor>(
    () => GlobalDioInterceptor(),
  );
  
  // Add interceptor to Dio
  dio.interceptors.add(sl<GlobalDioInterceptor>());
  
  // API Service (singleton factory pattern)
  sl.registerLazySingleton<ApiService>(
    () => ApiService(),
  );
  
  print('✅ Dependencies initialized successfully');
}

// Auth dependencies are now registered above in configureDependencies()


