part of 'select_product_bloc.dart';

@freezed
abstract class SelectProductEvent with _$SelectProductEvent {
  const factory SelectProductEvent.loadProducts({
    int? serviceId,
    required String pickupDate,
    required String returnDate,
    TimeOfDay? pickupTime,
    TimeOfDay? returnTime,
    @Default(true) bool useAvailableProductsApi,
    @Default(false) bool isSales,
    int? bookingId, // For edit mode - to check availability excluding current booking
    List<int>? variantIds, // For edit mode - variants already in bookie
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
    int? bookingId, // For edit mode
    List<int>? variantIds, // For edit mode
  }) = _SearchProducts;

  const factory SelectProductEvent.loadNextSearchResults() =
      _LoadNextSearchResults;
}
