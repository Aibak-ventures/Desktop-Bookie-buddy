part of 'matching_product_bloc.dart';

@freezed
class MatchingProductEvent with _$MatchingProductEvent {
  const factory MatchingProductEvent.loadMatchingProducts({
    required int fromVariantId,
    required int toShopId,
  }) = _LoadMatchingProducts;
  const factory MatchingProductEvent.loadNextPageMatchingProducts() =
      _LoadNextPageMatchingProducts;
}
