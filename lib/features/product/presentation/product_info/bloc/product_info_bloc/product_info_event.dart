part of 'product_info_bloc.dart';

@freezed
class ProductInfoEvent with _$ProductInfoEvent {
  const factory ProductInfoEvent.loadProductInfo(int productId) =
      _LoadProductInfo;

  // const factory ProductInfoEvent.deleteExpense({
  //   required int productId,
  //   required int expenseId,
  // }) = _DeleteExpense;

  const factory ProductInfoEvent.deleteProduct({
    required int productId,
    int? variantId,
  }) = _DeleteProduct;

  const factory ProductInfoEvent.updateVariant({
    required int productId,
    required int variantId,
    required String? updatedAttribute,
    required int? updatedStock,
  }) = _UpdateVariant;

  const factory ProductInfoEvent.addProductVariant({
    required int productId,
    required String attribute,
    required int stock,
  }) = _AddProductVariants;
}
