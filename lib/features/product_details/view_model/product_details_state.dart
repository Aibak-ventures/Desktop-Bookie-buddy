import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/features/product/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_details_state.freezed.dart';

@freezed
class ProductDetailsState with _$ProductDetailsState {
  const factory ProductDetailsState.initial() = _Initial;
  const factory ProductDetailsState.loading() = _Loading;
  const factory ProductDetailsState.loaded({
    required ProductModel product,
    @Default([]) List<BookingsModel> bookings,
    @Default([]) List<ProductMonthlyDataModel> monthlySummary,
    String? nextPageUrl,
    @Default(false) bool isPaginatingBookings,
  }) = _Loaded;
  const factory ProductDetailsState.error({
    required String message,
  }) = _Error;
}
