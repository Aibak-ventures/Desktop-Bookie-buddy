import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Storage module for dependency injection
/// 
/// Registers:
/// - SharedPreferences for general app storage
/// - FlutterSecureStorage for sensitive data (tokens, passwords)
class StorageModule {
  static Future<void> init(GetIt getIt) async {
    // Register SharedPreferences as a singleton
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerSingleton<SharedPreferences>(sharedPreferences);

    // Register FlutterSecureStorage
    getIt.registerLazySingleton<FlutterSecureStorage>(
      () => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
      ),
    );
  }
}
