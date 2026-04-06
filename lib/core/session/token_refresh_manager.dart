import 'dart:async';
import 'dart:developer';
import 'package:bookie_buddy_web/core/session/session_storage.dart';

class TokenRefreshManager {
  TokenRefreshManager({
    required Future<bool> Function() refreshCallback,
    required SessionStorage sessionStorage,
  })  : _refreshCallback = refreshCallback,
        _sessionStorage = sessionStorage;

  final Future<bool> Function() _refreshCallback;
  final SessionStorage _sessionStorage;
  Timer? _refreshTimer;
  bool _isRefreshing = false;

  bool get isTokenValid =>
      (_sessionStorage.accessToken != null &&
          _sessionStorage.accessToken!.isNotEmpty) &&
      (_sessionStorage.refreshToken != null &&
          _sessionStorage.refreshToken!.isNotEmpty);

  void startProactiveRefresh() async {
    await _sessionStorage.loadTokenExpiry();
    log('Proactive token refresh started');
    _refreshTimer?.cancel();
    await _checkTokenExpiry();
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) async {
        await _checkTokenExpiry();
      },
    );
  }

  Future<void> _checkTokenExpiry() async {
    if (_isRefreshing) {
      log('Proactive token refresh is already in progress');
      return;
    }

    log('Proactive token refresh checking...');

    if (_sessionStorage.refreshToken == null) {
      log('No refresh token available, skipping proactive refresh');
      return;
    }
    if (_sessionStorage.isTokenExpiringSoon) {
      _isRefreshing = true;
      log('Proactive token refresh triggered');
      try {
        await _refreshCallback();
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

  void stopProactiveRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }
}
