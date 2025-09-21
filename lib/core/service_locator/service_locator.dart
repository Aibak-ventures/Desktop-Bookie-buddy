import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/client/dio_client.dart';
import '../services/shared_preference_service.dart';
import '../services/device_info_service.dart';
import '../../features/auth/application/iauth_service.dart';
import '../../features/auth/application/auth_service.dart';
import '../../features/auth/data/api/iauth_api_service.dart';
import '../../features/auth/data/api/auth_api_service.dart';
import '../../features/auth/data/repository/iauth_repository.dart';
import '../../features/auth/data/repository/auth_repository.dart';
import '../../features/auth/presentation/state/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {
  // * =====[ Core Services ]=====
  
  // Shared Preferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferenceService>(
    () => SharedPreferenceService(prefs),
  );

  // Device Info Service
  getIt.registerLazySingleton<DeviceInfoService>(() => DeviceInfoService());

  // * =====[ Network ]=====
  
  // Initialize DioClient
  DioClient.init();
  getIt.registerLazySingleton<Dio>(() => DioClient.dio);

  // * =====[ Auth Feature ]=====
  
  // Auth API Service
  getIt.registerLazySingleton<IAuthApiService>(
    () => AuthApiService(getIt<Dio>()),
  );

  // Auth Repository
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepository(getIt<IAuthApiService>()),
  );

  // Auth Service
  getIt.registerLazySingleton<IAuthService>(
    () => AuthService(getIt<IAuthRepository>()),
  );

  // Auth Bloc
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      getIt<IAuthService>(),
      getIt<SharedPreferenceService>(),
      getIt<DeviceInfoService>(),
    ),
  );
}
