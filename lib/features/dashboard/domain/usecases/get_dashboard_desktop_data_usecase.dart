import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_entity/desktop_dashboard_entity.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/repositories/i_dashboard_repository.dart';

class GetDashboardDesktopDataUseCase {
  final IDashboardRepository _repository;

  GetDashboardDesktopDataUseCase(this._repository);

  Future<DesktopDashboardEntity> call({
    int page = 1,
    String? nextPageUrl,
    UserEntity? activeShop,
  }) async {
    return await _repository.getDashboardDesktopData(
      page: page,
      nextPageUrl: nextPageUrl,
      activeShop: activeShop,
    );
  }
}
