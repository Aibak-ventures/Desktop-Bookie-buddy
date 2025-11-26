import 'package:bookie_buddy_web/core/api/api_config.dart';

class AuthApiPaths {
  const AuthApiPaths();

  static const _rootV3 = '${ApiConfig.v3}/auth/';
  static const _rootV4 = '${ApiConfig.v4}/auth/';
  static const login = '${_rootV3}login/';
  static const walletLogin = '${_rootV3}wallet-login/';
  static const changePassword = '${_rootV3}change-password/';
  static const changeSecondaryPassword = '${_rootV3}update-secondary-password/';
  static const refresh = '${ApiConfig.v}/token/refresh/';
  static const profile = '${_rootV4}profile/';
}
