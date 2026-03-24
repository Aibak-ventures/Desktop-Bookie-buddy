part of 'selected_products_cubit.dart';

@freezed
abstract class SelectedProductsState with _$SelectedProductsState {
  const factory SelectedProductsState.selected(
      List<ProductSelectedEntity> selectedProductsWithAmount) = _Selected;
}
