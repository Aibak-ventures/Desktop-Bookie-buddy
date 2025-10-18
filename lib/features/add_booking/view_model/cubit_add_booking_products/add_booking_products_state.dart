part of 'add_booking_products_cubit.dart';

@freezed
class AddBookingProductsState with _$AddBookingProductsState {
  const factory AddBookingProductsState(List<ProductSelectedModel> products) =
      _AddBookingProductsState;
}
