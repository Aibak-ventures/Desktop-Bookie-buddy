part of 'matching_product_bloc.dart';

@freezed
class MatchingProductState with _$MatchingProductState {
  const factory MatchingProductState.loading() = _Loading;
  const factory MatchingProductState.loaded({
    required List<ProductModel> products,
    required int fromVariantId,
    required int toShopId,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
  }) = _Loaded;
  const factory MatchingProductState.error(String error) = _Error;
}
