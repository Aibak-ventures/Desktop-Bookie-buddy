import 'package:bookie_buddy_web/features/shop/domain/entities/shop_entity/shop_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/repositories/i_shop_repository.dart';

class GetShopsUseCase {
  final IShopRepository _repository;

  GetShopsUseCase(this._repository);

  Future<List<ShopEntity>> call() => _repository.getShops();
}
