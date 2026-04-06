import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_monthly_data_entity/product_monthly_data_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_details_state.freezed.dart';

@freezed
abstract class ProductDetailsState with _$ProductDetailsState {
  const factory ProductDetailsState.initial() = _Initial;
  const factory ProductDetailsState.loading() = _Loading;
  const factory ProductDetailsState.loaded({
    required ProductEntity product,
    @Default([]) List<BookingEntity> bookings,
    @Default([]) List<ProductMonthlyDataEntity> monthlySummary,
    String? nextPageUrl,
    @Default(false) bool isPaginatingBookings,
  }) = _Loaded;
  const factory ProductDetailsState.error({required String message}) = _Error;
}
