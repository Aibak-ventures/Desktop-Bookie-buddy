import 'dart:developer';

import 'package:bookie_buddy_web/features/dashboard/domain/repositories/i_dashboard_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/core/common/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/dashboard_model/dashboard_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/desktop_dashboard_response.dart';
import 'package:bookie_buddy_web/features/dashboard/data/datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements IDashboardRepository {
  final DashboardRemoteDatasource _dashboardService;

  DashboardRepositoryImpl(this._dashboardService);

  /// Fetch new desktop dashboard data using v4 API
  @override
  Future<DesktopDashboardResponse> getDashboardDesktopData({
    int page = 1,
    UserModel? activeShop,
  }) async {
    try {
      return await _dashboardService.fetchDesktopDashboardData(
        page: page,
        activeShopId: activeShop?.id.toString(),
      );
    } catch (e, stack) {
      log('Error loading desktop dashboard data: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// [DEPRECATED] Legacy method - kept for compatibility during migration
  @Deprecated('Use loadDesktopDashboardData instead')
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
