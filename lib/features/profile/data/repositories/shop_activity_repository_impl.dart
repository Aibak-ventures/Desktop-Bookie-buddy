import 'package:bookie_buddy_web/features/profile/data/datasources/shop_activity_remote_datasource.dart';
import 'package:bookie_buddy_web/features/profile/domain/models/shop_activity_list_model/shop_activity_list_model.dart';
import 'package:bookie_buddy_web/features/profile/domain/repositories/i_shop_activity_repository.dart';

class ShopActivityRepositoryImpl implements IShopActivityRepository {
  final ShopActivityRemoteDatasource _remoteDatasource;

  ShopActivityRepositoryImpl(this._remoteDatasource);

  @override
  Future<ShopActivityListModel> loadShopActivities({int page = 1}) async {
    return _remoteDatasource.loadShopActivities(page: page);
  }

  @override
  Future<ShopActivityListModel> loadNextPage(String nextPageUrl) async {
    return _remoteDatasource.loadNextPage(nextPageUrl);
  }
}
