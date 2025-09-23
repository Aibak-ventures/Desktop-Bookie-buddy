part of 'product_search_bloc.dart';

@freezed
class ProductSearchState with _$ProductSearchState {
  const factory ProductSearchState.initial({
    required List<ProductModel> suggestions,
    required ProductModel? selectedProduct,
    required String searchQuery,
    String? nextPageUrl,
    @Default(false) bool isLoading,
  }) = _Initial;
}
