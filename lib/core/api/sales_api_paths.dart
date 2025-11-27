import 'package:bookie_buddy_web/core/api/api_config.dart';

class SalesApiPaths {
  static const _rootV3 = '${ApiConfig.v3}/sales/';
  static const _rootV4 = '${ApiConfig.v4}/sales/';

  // v3 paths (legacy support for invoice only)
  static String downloadInvoice(int id) => '${_rootV3}sales/send-invoice/$id/';

  // v4 paths (new standard - all CRUD operations)
  static const sales = '${_rootV4}sales/'; // List endpoint (v4)
  static const salesV4 = '${_rootV4}sales/'; // Create endpoint (v4)
  static String salesDetailV4(int id) => '${salesV4}$id/'; // Get detail (v4)
  static String updateSaleV4(int id) => '${salesV4}$id/'; // Update (v4)
  static String deleteSaleV4(int id) => '${salesV4}$id/'; // Delete (v4)
}
