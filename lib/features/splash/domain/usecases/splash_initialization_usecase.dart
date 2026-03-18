import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/app_constants.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/route/app_router.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';
import 'package:bookie_buddy_web/features/auth/presentation/pages/login_screen.dart';
import 'package:bookie_buddy_web/features/auth/presentation/pages/onboarding_screen.dart';
import 'package:bookie_buddy_web/features/in_app_update/repository/in_app_update_repository.dart';
import 'package:bookie_buddy_web/core/app/bottom_bar_screen.dart';
import 'package:flutter/foundation.dart';

class SplashInitializationUseCase {
  Future<void> call() async {
    await Future.delayed(const Duration(seconds: 2));

    final onboarding =
        SharedPreferenceHelper.getBool(AppConstants.onboardingKey);
    log('onboarding: $onboarding');

    final initialScreen = !(onboarding ?? false)
        ? const OnboardingScreen()
        : TokenStorage.refreshToken != null && TokenStorage.accessToken != null
            ? const BottomBarScreen()
            : LoginScreen();

    navigatorKey.currentContext!.pushReplacement(initialScreen);
    if (!kDebugMode)
      InAppUpdateRepository.runInAppUpdate(); // only work in production
  }
}
