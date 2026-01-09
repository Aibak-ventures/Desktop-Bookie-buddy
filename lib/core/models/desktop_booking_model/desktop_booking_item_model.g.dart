// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desktop_booking_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DesktopBookingItemModelImpl _$$DesktopBookingItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DesktopBookingItemModelImpl(
      id: (json['id'] as num).toInt(),
      shopBookingId: json['shop_booking_id'] as String,
      client: json['client'] as String,
      pickupDate: json['pickup_date'] as String,
      returnDate: json['return_date'] as String,
      paymentStatus: _paymentStatusFromBool(json['payment_status']),
      staffName: json['staff_name'] as String?,
      staffColor: json['staff_color'] as String?,
      deliveryStatus:
          DeliveryStatus.fromString(json['delivery_status'] as String),
      createdAt: json['created_at'] as String,
      bookedItems: json['booked_items'] as String,
      advanceAmount: (json['advance_amount'] as num).toInt(),
      remainingAmount: (json['remaining_amount'] as num).toInt(),
    );

Map<String, dynamic> _$$DesktopBookingItemModelImplToJson(
        _$DesktopBookingItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_booking_id': instance.shopBookingId,
      'client': instance.client,
      'pickup_date': instance.pickupDate,
      'return_date': instance.returnDate,
      'payment_status': _paymentStatusToBool(instance.paymentStatus),
      'staff_name': instance.staffName,
      'staff_color': instance.staffColor,
      'delivery_status': DeliveryStatus.toJson(instance.deliveryStatus),
      'created_at': instance.createdAt,
      'booked_items': instance.bookedItems,
      'advance_amount': instance.advanceAmount,
      'remaining_amount': instance.remainingAmount,
    };
