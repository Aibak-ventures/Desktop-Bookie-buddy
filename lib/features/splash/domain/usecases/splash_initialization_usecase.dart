import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/app_constants.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/app/my_app.dart';
import 'package:bookie_buddy_web/utils/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/session/session_storage.dart';
import 'package:bookie_buddy_web/features/auth/presentation/pages/login_screen.dart';
import 'package:bookie_buddy_web/features/auth/presentation/pages/onboarding_screen.dart';
import 'package:bookie_buddy_web/core/app/bottom_bar_screen.dart';

class SplashInitializationUseCase {
  Future<void> call() async {
    await Future.delayed(const Duration(seconds: 2));

    final onboarding =
        SharedPreferenceHelper.getBool(AppConstants.onboardingKey);
    log('onboarding: $onboarding');

    final initialScreen = !(onboarding ?? false)
        ? const OnboardingScreen()
        : SessionStorage.refreshToken != null &&
                SessionStorage.accessToken != null
            ? const BottomBarScreen()
            : LoginScreen();

    navigatorKey.currentContext!.pushReplacement(initialScreen);
  }
}
