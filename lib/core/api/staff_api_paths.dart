import 'package:bookie_buddy_web/core/api/api_config.dart';

class StaffApiPaths {
  static const _root = '${ApiConfig.v3}/shop/';
  static const String staff = '${_root}staff/';
  static const String staffAnalyticsReport =
      '${_root}staff-earnings/earnings-report/';
  static const String staffMonthlyBookingsOrSales =
      '${_root}staff-earnings/monthly-transactions/';
  static String staffById(int id) => '${staff}$id/';
  static String staffAnalyticsReportById(int id) =>
      '${staffAnalyticsReport}$id/';
}
