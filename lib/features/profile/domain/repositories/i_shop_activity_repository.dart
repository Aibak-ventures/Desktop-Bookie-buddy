import 'package:bookie_buddy_web/features/profile/domain/models/shop_activity_list_model/shop_activity_list_model.dart';

abstract class IShopActivityRepository {
  Future<ShopActivityListModel> loadShopActivities({int page = 1});
  Future<ShopActivityListModel> loadNextPage(String nextPageUrl);
}
