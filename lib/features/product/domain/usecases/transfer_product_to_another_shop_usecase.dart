import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class TransferProductToAnotherShopUseCase {
  final IProductRepository _repository;
  TransferProductToAnotherShopUseCase(this._repository);

  Future<void> call({
    required int fromVariantId,
    required int toShopId,
    required int transferQuantity,
    int? toProductId,
  }) =>
      _repository.transferProductToAnotherShop(
        fromVariantId: fromVariantId,
        toShopId: toShopId,
        transferQuantity: transferQuantity,
        toProductId: toProductId,
      );
}
