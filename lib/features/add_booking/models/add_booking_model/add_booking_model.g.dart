// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddBookingModelImpl _$$AddBookingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$AddBookingModelImpl(
      serviceId: (json['service_id'] as num?)?.toInt(),
      advanceAmount: (json['advance_amount'] as num?)?.toInt(),
      securityAmount: (json['security_amount'] as num?)?.toInt(),
      discountAmount: (json['discount_amount'] as num?)?.toInt(),
      products: (json['sub_services'] as List<dynamic>?)
          ?.map((e) => ProductSelectedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      bookedDate: json['booked_date'] as String?,
      pickupDate: json['event_date'] as String?,
      returnDate: json['return_date'] as String?,
      paymentMethod: json['payment_method'] as String?,
      purchaseMode: json['purchase_mode'] as String?,
      deliveryStatus: json['delivery_status'] as String?,
      staffName: json['staff_name'] as String?,
      locationStart: json['location_start'] as String?,
      locationFrom: json['location_from'] as String?,
      locationTo: json['location_to'] as String?,
      address: json['client_address'] as String?,
      clientId: (json['client_id'] as num?)?.toInt(),
      bookingStatus: json['booking_status'] as String?,
    );

Map<String, dynamic> _$$AddBookingModelImplToJson(
        _$AddBookingModelImpl instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'advance_amount': instance.advanceAmount,
      'security_amount': instance.securityAmount,
      'discount_amount': instance.discountAmount,
      'sub_services': instance.products,
      'description': instance.description,
      'booked_date': instance.bookedDate,
      'event_date': instance.pickupDate,
      'return_date': instance.returnDate,
      'payment_method': instance.paymentMethod,
      'purchase_mode': instance.purchaseMode,
      'delivery_status': instance.deliveryStatus,
      'staff_name': instance.staffName,
      'location_start': instance.locationStart,
      'location_from': instance.locationFrom,
      'location_to': instance.locationTo,
      'client_address': instance.address,
      'client_id': instance.clientId,
      'booking_status': instance.bookingStatus,
    };
