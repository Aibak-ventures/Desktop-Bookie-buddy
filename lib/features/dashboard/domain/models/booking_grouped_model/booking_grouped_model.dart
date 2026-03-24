import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_grouped_model.freezed.dart';

@freezed
abstract class BookingGroupedModel with _$BookingGroupedModel {
  const factory BookingGroupedModel({
    required String date,
    required List<BookingEntity> bookings,
  }) = _BookingGroupedModel;
}
