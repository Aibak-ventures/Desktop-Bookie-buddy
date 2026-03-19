import 'package:bookie_buddy_web/features/shop/domain/entities/service_entity/service_entity.dart';
import 'package:bookie_buddy_web/features/shop/domain/repositories/i_shop_repository.dart';

class GetShopServicesUseCase {
  final IShopRepository _repository;

  GetShopServicesUseCase(this._repository);

  Future<List<ServiceEntity>> call() => _repository.getShopServices();
}
