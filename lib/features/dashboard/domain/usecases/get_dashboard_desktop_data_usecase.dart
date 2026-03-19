import 'package:bookie_buddy_web/core/common/models/user_model/user_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/desktop_dashboard_response.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/repositories/i_dashboard_repository.dart';

class GetDashboardDesktopDataUseCase {
  final IDashboardRepository _repository;

  GetDashboardDesktopDataUseCase(this._repository);

  Future<DesktopDashboardResponse> call({
    int page = 1,
    UserModel? activeShop,
  }) async {
    return await _repository.getDashboardDesktopData(
      page: page,
      activeShop: activeShop,
    );
  }
}
