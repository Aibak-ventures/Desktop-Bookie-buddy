import 'dart:async';
import 'dart:developer';
import 'package:bookie_buddy_web/core/services/auth_service.dart';
import 'package:bookie_buddy_web/core/storage/token_storage.dart';

class TokenManager {
  static Timer? _refreshTimer;

  static void startProactiveRefresh() async {
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
    log('Proactive token refresh checking...');
    if (TokenStorage.isTokenExpiringSoon) {
      log('Proactive token refresh triggered');
      try {
        await AuthService.refreshToken();
        log('Proactive token refresh completed successfully');
      } catch (e) {
        log('Proactive token refresh failed: $e');
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
