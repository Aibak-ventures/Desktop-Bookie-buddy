import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookie_buddy_web/core/session/token_refresh_manager.dart';
import 'package:bookie_buddy_web/core/app/my_app.dart';
import 'package:bookie_buddy_web/utils/network/dio_client/dio_config.dart';
import 'package:feedback/feedback.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Suppress known Flutter keyboard errors on Windows
  FlutterError.onError = (FlutterErrorDetails details) {
    // Filter out the RawKeyboard assertion error which is a known framework issue
    final isKeyboardError =
        details.exception.toString().contains('RawKeyDownEvent') ||
            details.exception.toString().contains('_keysPressed.isNotEmpty');

    if (!isKeyboardError) {
      // Report all other errors normally
      FlutterError.presentError(details);
    }
    // Silently ignore keyboard errors as they don't affect functionality
  };

  final prefs = await SharedPreferences.getInstance();
  AppDependencies.init(prefs);
  DioClient.init();
  if (!kIsWeb) {
    getIt<TokenRefreshManager>().startProactiveRefresh();
    FilePicker.platform;
  }

  runApp(
    BetterFeedback(
      theme: FeedbackThemeData(
        background: Colors.grey.shade900,
        feedbackSheetColor: Colors.grey.shade800,
        drawColors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.purple,
        ],
      ),
      child: const _MyEntryPoint(),
    ),
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
          designSize = const Size(1920, 1080);
        } else if (isTablet) {
          designSize = const Size(700, 1000);
        } else {
          designSize = const Size(393, 751);
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
