import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_entity/desktop_dashboard_entity.dart';

abstract interface class IDashboardRepository {
  Future<DesktopDashboardEntity> getDashboardDesktopData({
    int page = 1,
    UserEntity? activeShop,
  });
}
