import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class AuthEndpoints {
  const AuthEndpoints();

  static const _rootV3 = '${ApiConfig.v3}/auth/';
  static const _rootV5 = '${ApiConfig.v5}/auth/';

  final login = '${_rootV3}login/';
  final walletLogin = '${_rootV3}wallet-login/';
  final changePassword = '${_rootV3}change-password/';
  final changeSecondaryPassword = '${_rootV3}update-secondary-password/';
  final refresh = '${ApiConfig.v}/token/refresh/';
  final profile = '${_rootV5}profile/';
}
