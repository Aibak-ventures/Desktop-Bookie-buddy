import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class StaffEndpoints {
  const StaffEndpoints();

  static const _root = '${ApiConfig.v3}/shop/';

  final String staff = '${_root}staff/';
  final String staffAnalyticsReport =
      '${_root}staff-earnings/earnings-report/';
  final String staffMonthlyBookingsOrSales =
      '${_root}staff-earnings/monthly-transactions/';

  String staffById(int id) => '${staff}$id/';
  String staffAnalyticsReportById(int id) => '${staffAnalyticsReport}$id/';

  // Staff Management
  String restoreStaff(int id) => '${staff}$id/restore/';
  String deactivateStaff(int id) => '${staff}$id/deactivate/';
}
