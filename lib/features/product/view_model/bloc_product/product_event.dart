part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.loadProducts(int serviceId) = _LoadProducts;
  const factory ProductEvent.loadNextPageProducts(int serviceId) =
      _LoadNextPageProducts;

  const factory ProductEvent.searchProducts({
    required int serviceId,
    String? query,
    @Default('name') String? type,
    int? startPrice,
    int? endPrice,
  }) = _SearchProducts;
}
