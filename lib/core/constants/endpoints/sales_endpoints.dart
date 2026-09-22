import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class SalesEndpoints {
  const SalesEndpoints();

  static const _root = '${ApiConfig.v5}/sales/';

  final sales = '${_root}sales/';

  String downloadInvoice(int id) => '${_root}sales/send-invoice/$id/';
  String salesDetail(int id) => '${sales}$id/';
  String updateSale(int id) => '${sales}update-sale/$id/';
  String deleteSale(int id) => '${sales}$id/';
}
