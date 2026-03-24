import 'dart:developer';

import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_entity/desktop_dashboard_entity.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/repositories/i_dashboard_repository.dart';
import 'package:bookie_buddy_web/core/common/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/dashboard/data/models/desktop_dashboard_response/desktop_dashboard_response.dart';
import 'package:bookie_buddy_web/features/dashboard/data/datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements IDashboardRepository {
  final DashboardRemoteDatasource _dashboardService;

  DashboardRepositoryImpl(this._dashboardService);

  /// Fetch new desktop dashboard data using v4 API
  @override
  Future<DesktopDashboardEntity> getDashboardDesktopData({
    int page = 1,
    UserModel? activeShop,
  }) async {
    try {
      final response = await _dashboardService.fetchDesktopDashboardData(
        page: page,
        activeShopId: activeShop?.id.toString(),
      );
      return response.toEntity();
    } catch (e, stack) {
      log('Error loading desktop dashboard data: $e', stackTrace: stack);
      rethrow;
    }
  }
}
