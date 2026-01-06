// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingsModelImpl _$$BookingsModelImplFromJson(Map<String, dynamic> json) =>
    _$BookingsModelImpl(
      id: (_idCustomRead(json, 'id') as num?)?.toInt(),
      clientName: _clientCustomRead(json, 'client') as String? ?? 'Unknown',
      bookingStatus: BookingStatus.fromString(
          _bookingStatusCustomRead(json, 'booking_status') as String),
      bookedDate: json['booking_date'] as String?,
      pickupDate: json['pickup_date'] as String?,
      returnDate: json['return_date'] as String?,
      deliveryStatus: json['delivery_status'] == null
          ? DeliveryStatus.booked
          : DeliveryStatus.fromString(json['delivery_status'] as String),
      paymentStatus: json['payment_status'] == null
          ? PaymentStatus.pending
          : PaymentStatus.fromBool(json['payment_status'] as bool?),
      shopBookingId: json['shop_booking_id'] as String?,
      staffName: json['staff_name'] as String?,
      createdAt: json['created_at'] as String?,
      bookedItems:
          (_bookedItemsCustomRead(json, 'booked_items') as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
      type: json['type'] as String?,
    );

Map<String, dynamic> _$$BookingsModelImplToJson(_$BookingsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.clientName,
      'booking_status': BookingStatus.toJson(instance.bookingStatus),
      'booking_date': instance.bookedDate,
      'pickup_date': instance.pickupDate,
      'return_date': instance.returnDate,
      'delivery_status': DeliveryStatus.toJson(instance.deliveryStatus),
      'payment_status': PaymentStatus.toJson(instance.paymentStatus),
      'shop_booking_id': instance.shopBookingId,
      'staff_name': instance.staffName,
      'created_at': instance.createdAt,
      'booked_items': instance.bookedItems,
      'type': instance.type,
    };
