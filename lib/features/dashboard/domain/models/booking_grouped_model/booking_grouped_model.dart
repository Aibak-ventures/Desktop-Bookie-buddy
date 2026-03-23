import 'package:bookie_buddy_web/features/booking/domain/models/booking_model/booking_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_grouped_model.freezed.dart';

@freezed
abstract class BookingGroupedModel with _$BookingGroupedModel {
  const factory BookingGroupedModel({
    required String date,
    required List<BookingsModel> bookings,
  }) = _BookingGroupedModel;
}
