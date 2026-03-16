part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;

  const factory ProductState.loaded({
    required List<ProductModel> products,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    @Default(false) bool isSearching,
    String? searchQuery,
    String? searchType,
    int? startPrice,
    int? endPrice,
  }) = _Loaded;

  const factory ProductState.error(String error) = _Error;
}
