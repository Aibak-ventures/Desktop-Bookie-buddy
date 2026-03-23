part of 'product_search_cubit.dart';

@freezed
abstract class ProductSearchState with _$ProductSearchState {
  const factory ProductSearchState({
    required List<ProductModel> suggestions,
    required ProductModel? selectedProduct,
    required String searchQuery,
    String? nextPageUrl,
    @Default(false) bool isLoading,
  }) = _ProductSearchState;
}
