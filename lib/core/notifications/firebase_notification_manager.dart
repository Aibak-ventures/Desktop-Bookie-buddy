import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/app_constants.dart';
import 'package:bookie_buddy_web/core/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

/// Centralized FCM token + refresh handling. Permission is requested in main.
class FirebaseNotificationManager {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static bool _refreshListenerBound = false;

  static Future<String?> get getFcmToken async {
    // Ensure APNs token is requested (must call registerForRemoteNotifications in AppDelegate)
    await _ensureApnsToken(maxWait: const Duration(seconds: 4));

    try {
      return await _firebaseMessaging.getToken(
        vapidKey: AppConstants.fcmVapidKey,
      );
    } on FirebaseException catch (e, stack) {
      if (e.code == 'apns-token-not-set' && Platform.isIOS) {
        debugPrint('APNs token not yet set - will wait and retry');
        await _ensureApnsToken(maxWait: const Duration(seconds: 20));
        try {
          return await _firebaseMessaging.getToken(
            vapidKey: AppConstants.fcmVapidKey,
          );
        } catch (_) {
          log('FCM getToken still failing after waiting for APNs token');
        }
      } else {
        log('FCM getToken error: ${e.code} ${e.message}', stackTrace: stack);
      }
      return null;
    } catch (e, stack) {
      log('Unexpected getToken error: $e', stackTrace: stack);
      return null;
    }
  }

  static Future<void> _ensureApnsToken({
    Duration maxWait = const Duration(seconds: 8),
  }) async {
    if (defaultTargetPlatform != TargetPlatform.iOS) return;
    try {
      final start = DateTime.now();
      Duration delay = const Duration(milliseconds: 400);
      String? apnsToken = await _firebaseMessaging.getAPNSToken();
      while (apnsToken == null && DateTime.now().difference(start) < maxWait) {
        await Future.delayed(delay);
        apnsToken = await _firebaseMessaging.getAPNSToken();
        // Exponential backoff capped
        delay = Duration(
          milliseconds: (delay.inMilliseconds * 1.6).clamp(400, 2500).toInt(),
        );
      }
      if (apnsToken == null) {
        debugPrint(
          '⚠️ APNs token still null after waiting ${DateTime.now().difference(start).inSeconds}s',
        );
      } else {
        debugPrint('✅ APNs token acquired (len=${apnsToken.length})');
      }
    } catch (e, stack) {
      log('Error while waiting for APNs token: $e', stackTrace: stack);
    }
  }

  /// Bind refresh listener (idempotent).
  static Future<void> initTokenHandling() async {
    try {
      final token = await getFcmToken;
      debugPrint('Fetched current FCM token for registration: $token');
    } catch (e) {
      debugPrint('Error fetching FCM token during init: $e');
    }
    if (_refreshListenerBound) return;
    _refreshListenerBound = true;

    _firebaseMessaging.onTokenRefresh.listen((token) async {
      await _registerTokenWithBackend(token: token);
    }, onError: (e) => debugPrint('FCM onTokenRefresh error: $e'));
  }

  /// Register current token with backend after successful authentication.
  static Future<void> registerCurrentTokenWithBackend() async {
    try {
      final token = await getFcmToken;
      debugPrint('Fetched current FCM token for registration: $token');
      await _registerTokenWithBackend(token: token);
    } catch (e) {
      debugPrint('Error fetching current FCM token: $e');
    }
  }

  static Future<void> _registerTokenWithBackend({String? token}) async {
    try {
      final t = token?.trim();
      if (t == null || t.isEmpty) {
        debugPrint('Skipping FCM token registration: token empty');
        return;
      }
      await getIt<UserRepository>().registerFCMToken(t);
      // final masked = t.length > 6 ? '***${t.substring(t.length - 6)}' : t;
      debugPrint('FCM token registered');
    } catch (e) {
      debugPrint('Error registering FCM token: $e');
    }
  }
}
