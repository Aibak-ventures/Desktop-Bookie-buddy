import 'package:bookie_buddy_web/features/shop/domain/models/shop_model/shop_model.dart';
import 'package:bookie_buddy_web/features/shop/domain/repositories/i_shop_repository.dart';

class GetShopsUseCase {
  final IShopRepository _repository;

  GetShopsUseCase(this._repository);

  Future<List<ShopModel>> call() => _repository.getShops();
}
