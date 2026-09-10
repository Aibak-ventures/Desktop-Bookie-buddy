import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class SalesEndpoints {
  static const _root = '${ApiConfig.v5}/sales/';

  static String downloadInvoice(int id) => '${_root}sales/send-invoice/$id/';

  static const sales = '${_root}sales/';

  static String salesDetail(int id) => '${sales}$id/';

  static String updateSale(int id) => '${sales}update-sale/$id/';

  static String deleteSale(int id) => '${sales}$id/';
}
