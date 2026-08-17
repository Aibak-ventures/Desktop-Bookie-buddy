import 'package:bookie_buddy_web/core/constants/enums/shop_based_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_other_details_entity.freezed.dart';

@freezed
abstract class BookingOtherDetailsEntity with _$BookingOtherDetailsEntity {
  const factory BookingOtherDetailsEntity({
    String? locationStart,
    String? locationFrom,
    String? locationTo,
    String? end,
    CoolingPeriodMode? coolingPeriodType,
    int? totalProductCount,
  }) = _BookingOtherDetailsEntity;

  static BookingOtherDetailsEntity empty() => const BookingOtherDetailsEntity();
}
