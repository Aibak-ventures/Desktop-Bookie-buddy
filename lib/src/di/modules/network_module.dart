import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

/// Network module for dependency injection
/// 
/// Registers:
/// - Dio client with interceptors
/// - Logger for network requests
class NetworkModule {
  static Future<void> init(GetIt getIt) async {
    // Register Logger
    getIt.registerLazySingleton<Logger>(
      () => Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 80,
          colors: true,
          printEmojis: true,
        ),
      ),
    );

    // Register Dio
    getIt.registerLazySingleton<Dio>(() {
      final dio = Dio(
        BaseOptions(
          baseUrl: 'https://dev.bookiebuddy.in',
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      // Add interceptors
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => getIt<Logger>().d(obj),
        ),
      );

      return dio;
    });
  }
}
