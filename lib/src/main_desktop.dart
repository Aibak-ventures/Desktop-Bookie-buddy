import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'di/injection.dart';
import 'app.dart';

/// Desktop application entrypoint
/// 
/// This is the main entry for the desktop (Windows/Mac/Linux) version.
/// It initializes desktop-specific configurations and dependencies.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await DependencyInjection.init();

  // TODO: Add desktop-specific initialization
  // - Window configuration (size, title, etc.)
  // - Desktop-specific services
  // - File system access setup

  runApp(const DesktopApp());
}

/// Desktop application wrapper
/// 
/// Configures desktop-specific screen sizes and responsive behavior
class DesktopApp extends StatelessWidget {
  const DesktopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Desktop design size (1920x1080 full HD)
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) => const App(),
    );
  }
}
