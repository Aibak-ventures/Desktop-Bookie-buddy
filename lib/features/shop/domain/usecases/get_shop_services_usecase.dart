import 'package:bookie_buddy_web/features/shop/domain/models/services_model/services_model.dart';
import 'package:bookie_buddy_web/features/shop/domain/repositories/i_shop_repository.dart';

class GetShopServicesUseCase {
  final IShopRepository _repository;

  GetShopServicesUseCase(this._repository);

  Future<List<ServicesModel>> call() => _repository.getShopServices();
}
