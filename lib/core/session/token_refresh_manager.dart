import 'dart:async';
import 'dart:developer';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/session/session_storage.dart';
import 'package:bookie_buddy_web/features/auth/domain/repositories/i_auth_repository.dart';

class TokenRefreshManager {
  static Timer? _refreshTimer;
  static bool _isRefreshing = false; // To prevent concurrent refreshes

  static bool get isTokenValid =>
      (SessionStorage.accessToken != null &&
          SessionStorage.accessToken!.isNotEmpty) &&
      (SessionStorage.refreshToken != null &&
          SessionStorage.refreshToken!.isNotEmpty);

  static void startProactiveRefresh() async {
    await SessionStorage.loadTokenExpiry();
    log('Proactive token refresh started');
    _refreshTimer?.cancel();
    await _checkTokenExpiry();
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 5), // Check every 5 minutes
      (_) async {
        await _checkTokenExpiry();
      },
    );
  }

  static Future<void> _checkTokenExpiry() async {
    if (_isRefreshing) {
      log('Proactive token refresh is already in progress');
      return;
    }

    log('Proactive token refresh checking...');

    if (SessionStorage.refreshToken == null) {
      log('No refresh token available, skipping proactive refresh');
      return;
    }
    if (SessionStorage.isTokenExpiringSoon) {
      _isRefreshing = true;
      log('Proactive token refresh triggered');
      try {
        await getIt.get<IAuthRepository>().refreshToken();
        log('Proactive token refresh completed successfully');
      } catch (e) {
        log('Proactive token refresh failed: $e');
      } finally {
        _isRefreshing = false;
      }
    } else {
      log('Proactive token refresh is not expiring soon');
    }
  }

  static void stopProactiveRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }
}
