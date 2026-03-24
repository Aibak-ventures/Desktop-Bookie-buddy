import 'package:bookie_buddy_web/core/common/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_entity/desktop_dashboard_entity.dart';

abstract interface class IDashboardRepository {
  Future<DesktopDashboardEntity> getDashboardDesktopData({
    int page = 1,
    UserModel? activeShop,
  });
}
