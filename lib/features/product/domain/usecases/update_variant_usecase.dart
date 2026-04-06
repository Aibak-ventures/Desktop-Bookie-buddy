import 'package:bookie_buddy_web/features/product/domain/repositories/i_product_repository.dart';

class UpdateVariantUseCase {
  final IProductRepository _repository;
  UpdateVariantUseCase(this._repository);

  Future<void> call({
    required int productId,
    required int variantId,
    required String? updatedAttribute,
    required int? updatedStock,
    String? externalQrCode,
  }) =>
      _repository.updateVariant(
        productId: productId,
        variantId: variantId,
        updatedAttribute: updatedAttribute,
        updatedStock: updatedStock,
        externalQrCode: externalQrCode,
      );
}
