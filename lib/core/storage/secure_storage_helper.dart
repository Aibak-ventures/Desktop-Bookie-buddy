// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class SecureStorageHelper {
//   // Singleton setup
//   static final SecureStorageHelper _instance = SecureStorageHelper._internal();

//   factory SecureStorageHelper() => _instance;

//   SecureStorageHelper._internal();

//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   // Save data
//   Future<void> write(String key, String value) async {
//     await _secureStorage.write(key: key, value: value);
//   }

//   // Read data
//   Future<String?> read(String key) async {
//     return await _secureStorage.read(key: key);
//   }

//   // Delete specific key
//   Future<void> delete(String key) async {
//     await _secureStorage.delete(key: key);
//   }

//   // Clear all keys
//   Future<void> clearAll() async {
//     await _secureStorage.deleteAll();
//   }
// }
