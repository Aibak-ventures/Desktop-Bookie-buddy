import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'desktop_booking_item_entity.freezed.dart';

@freezed
abstract class DesktopBookingItemEntity with _$DesktopBookingItemEntity {
  const factory DesktopBookingItemEntity({
    required int id,
    required String shopBookingId,
    required String client,
    required String pickupDate,
    required String returnDate,
    required bool paymentStatus,
    String? staffName,
    String? staffColor,
    DeliveryStatus? deliveryStatus,
    required String createdAt,
    required String bookedItems,
    required int advanceAmount,
    required int remainingAmount,
  }) = _DesktopBookingItemEntity;
}
