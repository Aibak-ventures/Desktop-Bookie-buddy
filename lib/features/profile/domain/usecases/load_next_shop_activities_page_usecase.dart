import 'package:bookie_buddy_web/features/profile/domain/models/shop_activity_list_model/shop_activity_list_model.dart';
import 'package:bookie_buddy_web/features/profile/domain/repositories/i_shop_activity_repository.dart';

class LoadNextShopActivitiesPageUseCase {
  final IShopActivityRepository _repository;

  LoadNextShopActivitiesPageUseCase(this._repository);

  Future<ShopActivityListModel> call(String nextPageUrl) async {
    return _repository.loadNextPage(nextPageUrl);
  }
}
