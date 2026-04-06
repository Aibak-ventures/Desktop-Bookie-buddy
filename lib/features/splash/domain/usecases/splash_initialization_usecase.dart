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
  SplashInitializationUseCase({
    required SharedPreferenceHelper prefs,
    required SessionStorage sessionStorage,
  })  : _prefs = prefs,
        _sessionStorage = sessionStorage;

  final SharedPreferenceHelper _prefs;
  final SessionStorage _sessionStorage;

  Future<void> call() async {
    await Future.delayed(const Duration(seconds: 2));

    final onboarding = _prefs.instance.getBool(AppConstants.onboardingKey);
    log('onboarding: $onboarding');

    final initialScreen = !(onboarding ?? false)
        ? const OnboardingScreen()
        : _sessionStorage.refreshToken != null &&
                _sessionStorage.accessToken != null
            ? const BottomBarScreen()
            : const LoginScreen();

    navigatorKey.currentContext!.pushReplacement(initialScreen);
  }
}
