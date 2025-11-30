import 'package:get_it/get_it.dart';
import 'modules/network_module.dart';
import 'modules/storage_module.dart';
import 'modules/auth_module.dart';

/// Global service locator instance
final getIt = GetIt.instance;

/// Dependency Injection configuration
/// 
/// This class handles the registration of all dependencies in a modular way.
/// Each module is responsible for registering its own dependencies.
/// 
/// Usage:
/// ```dart
/// void main() async {
///   await DependencyInjection.init();
///   runApp(MyApp());
/// }
/// ```
class DependencyInjection {
  /// Initialize all dependencies
  /// 
  /// Must be called before runApp() in main.dart
  static Future<void> init() async {
    // Initialize modules in order of dependency
    await StorageModule.init(getIt);
    await NetworkModule.init(getIt);
    await AuthModule.init(getIt);
    // Add more modules here as they are created
  }

  /// Reset all dependencies (useful for testing)
  static Future<void> reset() async {
    await getIt.reset();
  }
}
