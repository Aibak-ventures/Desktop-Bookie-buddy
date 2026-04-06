import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_other_details_entity.freezed.dart';

@freezed
abstract class BookingOtherDetailsEntity with _$BookingOtherDetailsEntity {
  const factory BookingOtherDetailsEntity({
    String? locationStart,
    String? locationFrom,
    String? locationTo,
    String? end,
  }) = _BookingOtherDetailsEntity;

  static BookingOtherDetailsEntity empty() => const BookingOtherDetailsEntity();
}
