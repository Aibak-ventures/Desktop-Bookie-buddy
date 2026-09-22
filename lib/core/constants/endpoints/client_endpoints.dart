import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class ClientEndpoints {
  const ClientEndpoints();

  static const _root = '${ApiConfig.v4}/bookings/clients/';

  final clients = _root;

  String clientById(int id) => '$_root$id/';
}
