import 'package:bookie_buddy_web/core/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/core/services/shop_service.dart';

class ShopRepository {
  final ShopService _service;

  ShopRepository({required ShopService service}) : _service = service;

  Future<List<ShopModel>> getShops() => _service.fetchShops();
}
