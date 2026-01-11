part of 'select_product_bloc.dart';

@freezed
class SelectProductEvent with _$SelectProductEvent {
  const factory SelectProductEvent.loadProducts({
    int? serviceId,
    required String pickupDate,
    required String returnDate,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
    @Default(true) bool useAvailableProductsApi,
    @Default(false) bool isSales,
  }) = _LoadProducts;
  const factory SelectProductEvent.loadNextPageProducts() =
      _LoadNextPageProducts;

  const factory SelectProductEvent.searchProducts({
    int? serviceId,
    required String pickupDate,
    required String returnDate,
    String? query,
    @Default('name') String? type,
    int? startPrice,
    int? endPrice,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
    @Default(true) bool useAvailableProductsApi,
    @Default(false) bool isSales,
  }) = _SearchProducts;

  const factory SelectProductEvent.loadNextSearchResults() =
      _LoadNextSearchResults;
}
