import 'package:bookie_buddy_web/core/common/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/desktop_dashboard_response.dart';

abstract interface class IDashboardRepository {
  Future<DesktopDashboardResponse> getDashboardDesktopData({
    int page = 1,
    UserModel? activeShop,
  });
}
