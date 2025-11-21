// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestBookingModelImpl _$$RequestBookingModelImplFromJson(
  Map<String, dynamic> json,
) =>
    _$RequestBookingModelImpl(
      clientId: (json['client_id'] as num?)?.toInt(),
      staffId: (json['staff_id'] as num?)?.toInt(),
      client: json['client'] == null
          ? null
          : ClientRequestModel.fromJson(json['client'] as Map<String, dynamic>),
      address: json['client_address'] as String?,
      bookedDate: json['booked_date'] as String?,
      pickupDate: json['pickup_date'] as String?,
      returnDate: json['return_date'] as String?,
      coolingPeriodDate: json['cooling_period_end'] as String?,
      advanceAmount: (json['advance_amount'] as num?)?.toInt(),
      securityAmount: (json['security_amount'] as num?)?.toInt(),
      discountAmount: (json['discount_amount'] as num?)?.toInt(),
      purchaseMode: json['purchase_mode'] as String?,
      description: json['description'] as String?,
      paymentMethod: $enumDecodeNullable(
        _$PaymentMethodEnumMap,
        json['payment_method'],
      ),
      deliveryStatus: $enumDecodeNullable(
        _$DeliveryStatusEnumMap,
        json['delivery_status'],
      ),
      bookingStatus: $enumDecodeNullable(
        _$BookingStatusEnumMap,
        json['booking_status'],
      ),
      products: (json['variants'] as List<dynamic>?)
          ?.map((e) => ProductSelectedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      otherDetails: json['details'] == null
          ? null
          : BookingOtherDetailsModel.fromJson(
              json['details'] as Map<String, dynamic>,
            ),
      additionalCharges: (json['additional_charges'] as List<dynamic>?)
          ?.map(
              (e) => AdditionalChargesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RequestBookingModelImplToJson(
  _$RequestBookingModelImpl instance,
) =>
    <String, dynamic>{
      if (instance.clientId case final value?) 'client_id': value,
      if (instance.staffId case final value?) 'staff_id': value,
      if (_clientToJson(instance.client) case final value?) 'client': value,
      if (instance.address case final value?) 'client_address': value,
      if (instance.bookedDate case final value?) 'booked_date': value,
      if (instance.pickupDate case final value?) 'pickup_date': value,
      if (instance.returnDate case final value?) 'return_date': value,
      if (instance.coolingPeriodDate case final value?)
        'cooling_period_end': value,
      if (instance.advanceAmount case final value?) 'advance_amount': value,
      if (instance.securityAmount case final value?) 'security_amount': value,
      if (instance.discountAmount case final value?) 'discount_amount': value,
      if (instance.purchaseMode case final value?) 'purchase_mode': value,
      if (instance.description case final value?) 'description': value,
      if (PaymentMethod.toJson(instance.paymentMethod) case final value?)
        'payment_method': value,
      if (DeliveryStatus.toJson(instance.deliveryStatus) case final value?)
        'delivery_status': value,
      if (BookingStatus.toJson(instance.bookingStatus) case final value?)
        'booking_status': value,
      if (_productsToJson(instance.products) case final value?)
        'variants': value,
      if (instance.otherDetails case final value?) 'details': value,
      if (instance.additionalCharges case final value?)
        'additional_charges': value,
      'send_invoice': instance.sendPdfToWhatsApp,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.gPay: 'gPay',
  PaymentMethod.cash: 'cash',
};

const _$DeliveryStatusEnumMap = {
  DeliveryStatus.booked: 'booked',
  DeliveryStatus.readyToDeliver: 'readyToDeliver',
  DeliveryStatus.delivered: 'delivered',
  DeliveryStatus.returned: 'returned',
};

const _$BookingStatusEnumMap = {
  BookingStatus.upcoming: 'upcoming',
  BookingStatus.completed: 'completed',
};
