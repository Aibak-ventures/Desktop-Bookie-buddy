import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/storage/token_manager.dart';
import 'package:bookie_buddy_web/core/app/my_app.dart';
import 'package:feedback/feedback.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_manager/window_manager.dart';

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

  // Initialize window manager for Windows desktop
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(1280, 720), // Initial window size
      minimumSize: Size(1100,
          750), // Minimum window size (cannot resize smaller) - prevents UI breaking
      center: true, // Center window on screen
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();

      // Additional window manager options (uncomment as needed):

      // 1. Disable minimize button:
      // await windowManager.setMinimizable(false);

      // 2. Completely disable resizing:
      // await windowManager.setResizable(false);

      // 3. Set maximum size (if needed):
      // await windowManager.setMaximumSize(const Size(1920, 1080));

      // 4. Always on top:
      // await windowManager.setAlwaysOnTop(true);

      // 5. Fullscreen mode:
      // await windowManager.setFullScreen(true);
    });
  }

  DioClient.init();
  await SharedPreferenceHelper.init();
  AppDependencies.init();
  if (!kIsWeb) {
    TokenManager.startProactiveRefresh();
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
