import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/entities/shop_entity/shop_entity.dart';

abstract interface class IShopRepository {
  Future<List<ShopEntity>> getShops();

  Future<List<ServiceEntity>> getShopServices();
}
