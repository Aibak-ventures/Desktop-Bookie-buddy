import 'dart:developer';

import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
// import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/home/models/dashboard_model/dashboard_model.dart';
import 'package:bookie_buddy_web/features/home/services/dashboard_service.dart';

class DashboardRepository {
  final DashboardService _dashboardService;

  DashboardRepository(this._dashboardService);

  /// Fetch dashboard data
  Future<DashboardModel> loadDashboardData({
    int page = 1,
    bool isOngoing = false,
  }) async {
    try {
      final response = await safeApiCall(
        () => _dashboardService.fetchDashboardData(
         page,
          isOngoing: isOngoing,
        ),
      );
      if (response.status.isSuccess) {
        return DashboardModel.fromJson(response.data);
      }
      log('Failed to load dashboard data: ${response.devMessage}');
      throw response.message ?? 'Failed to complete operation';
    } catch (e, stack) {
      log('Error loading dashboard data: $e', stackTrace: stack);
      rethrow;
    }
  }
}
