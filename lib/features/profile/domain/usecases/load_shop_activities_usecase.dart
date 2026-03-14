import 'package:bookie_buddy_web/features/profile/domain/models/shop_activity_list_model/shop_activity_list_model.dart';
import 'package:bookie_buddy_web/features/profile/domain/repositories/i_shop_activity_repository.dart';

class LoadShopActivitiesUseCase {
  final IShopActivityRepository _repository;

  LoadShopActivitiesUseCase(this._repository);

  Future<ShopActivityListModel> call({int page = 1}) async {
    return _repository.loadShopActivities(page: page);
  }
}
