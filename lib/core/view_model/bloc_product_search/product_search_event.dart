part of 'product_search_bloc.dart';

@freezed
class ProductSearchEvent with _$ProductSearchEvent {
  const factory ProductSearchEvent.searchQueryChanged(String query) =
      _SearchQueryChanged;
  const factory ProductSearchEvent.loadNextData() = _LoadNextData;

  const factory ProductSearchEvent.productSelected(
      ProductModel selectedProduct) = _ProductSelected;
  const factory ProductSearchEvent.clearSelected() = _ClearSelected;
}
