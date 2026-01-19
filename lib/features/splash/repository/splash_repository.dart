import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/navigation/navigations.dart';
import 'package:bookie_buddy_web/core/storage/shared_preference_helper.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';
import 'package:bookie_buddy_web/features/auth/view/login_screen.dart';
import 'package:bookie_buddy_web/features/auth/view/onboarding_screen.dart';
import 'package:bookie_buddy_web/features/in_app_update/repository/in_app_update_repository.dart';
import 'package:bookie_buddy_web/features/main/view/bottom_bar_screen.dart';
import 'package:flutter/foundation.dart';

class SplashRepository {
  static Future<void> initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    //!TODO: check onboarding

    final onboarding = SharedPreferenceHelper.getBool('onboarding');
    log('onboarding: $onboarding');

    final initialScreen = !(onboarding ?? false) || true
        ? const OnboardingScreen()
        : TokenStorage.refreshToken != null && TokenStorage.accessToken != null
            ? const BottomBarScreen()
            : LoginScreen();

    navigatorKey.currentContext!.pushReplacement(initialScreen);
    if (!kDebugMode)
      InAppUpdateRepository.runInAppUpdate(); // only work in production
  }
}
