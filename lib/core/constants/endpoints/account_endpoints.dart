import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class AccountEndpoints {
  const AccountEndpoints();

  static const _root = '${ApiConfig.v3}/finance/accounts/';

  final String accounts = _root;
  String accountById(int id) => '${_root}$id/';
  final String summary = '${_root}with-amounts/';
}
