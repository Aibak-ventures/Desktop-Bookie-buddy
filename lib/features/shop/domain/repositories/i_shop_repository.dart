import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';

abstract class IShopRepository {
  Future<List<ShopModel>> getShops();

  Future<List<ServicesModel>> getShopServices();
}
