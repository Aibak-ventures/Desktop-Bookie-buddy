// ignore_for_file: invalid_annotation_target

import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'desktop_booking_item_model.freezed.dart';
part 'desktop_booking_item_model.g.dart';

@freezed
class DesktopBookingItemModel with _$DesktopBookingItemModel {
  const factory DesktopBookingItemModel({
    required int id,
    @JsonKey(name: 'shop_booking_id') required String shopBookingId,
    required String client,
    @JsonKey(name: 'pickup_date') required String pickupDate,
    @JsonKey(name: 'return_date') required String returnDate,
    @JsonKey(
      name: 'payment_status',
      fromJson: _paymentStatusFromBool,
      toJson: _paymentStatusToBool,
    )
    required bool paymentStatus,
    @JsonKey(name: 'staff_name') String? staffName,
    @JsonKey(name: 'staff_color') String? staffColor,
    @JsonKey(
      name: 'delivery_status',
      fromJson: DeliveryStatus.fromString,
      toJson: DeliveryStatus.toJson,
    )
    DeliveryStatus? deliveryStatus,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'booked_items') required String bookedItems,
    @JsonKey(name: 'advance_amount') required int advanceAmount,
    @JsonKey(name: 'remaining_amount') required int remainingAmount,
  }) = _DesktopBookingItemModel;

  factory DesktopBookingItemModel.fromJson(Map<String, dynamic> json) =>
      _$DesktopBookingItemModelFromJson(json);
}

bool _paymentStatusFromBool(dynamic value) {
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  return false;
}

bool _paymentStatusToBool(bool value) => value;
