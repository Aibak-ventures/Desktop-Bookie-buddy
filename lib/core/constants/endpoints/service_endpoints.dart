import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class ServiceEndpoints {
  const ServiceEndpoints();

  static const _root = '${ApiConfig.v3}/service/';

  final selected = '${_root}selected/';
}
