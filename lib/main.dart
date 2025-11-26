import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/storage/token_manager.dart';
import 'package:bookie_buddy_web/my_app.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioClient.init(); // Initialize DioClient
  await SharedPreferenceHelper.init(); // Initialize
  AppDependencies.init(); // Initialize AppDependencies
  TokenManager.startProactiveRefresh();
  FilePicker.platform;
  runApp(
    const _MyEntryPoint(),
  );
}

class _MyEntryPoint extends StatelessWidget {
  const _MyEntryPoint();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = _isTablet(constraints.maxWidth);
        final isDesktop = _isDesktop(constraints.maxWidth);

        final Size designSize;
        if (isDesktop) {
          designSize = const Size(1920, 1080); // Desktop design size
        } else if (isTablet) {
          designSize = const Size(700, 1000); // Tablet design size
        } else {
          designSize = const Size(393, 751); // Mobile design size
        }

        return ScreenUtilInit(
          designSize: designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => const MyApp(),
        );
      },
    );
  }

  bool _isTablet(double maxWidth) {
    return maxWidth >= 600 && maxWidth < 1200;
  }

  bool _isDesktop(double maxWidth) {
    return maxWidth >= 1200;
  }
}
