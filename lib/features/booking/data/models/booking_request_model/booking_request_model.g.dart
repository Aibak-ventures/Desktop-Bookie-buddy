// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingRequestModel _$BookingRequestModelFromJson(Map<String, dynamic> json) =>
    _BookingRequestModel(
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
            (e) => AdditionalChargesModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      coolingPeriodType: json['cooling_period_type'] as String?,
      securityPaymentMethod: $enumDecodeNullable(
        _$PaymentMethodEnumMap,
        json['security_payment_method'],
      ),
    );

Map<String, dynamic> _$BookingRequestModelToJson(
  _BookingRequestModel instance,
) => <String, dynamic>{
  'client_id': ?instance.clientId,
  'staff_id': ?instance.staffId,
  'client': ?_clientToJson(instance.client),
  'client_address': ?instance.address,
  'booked_date': ?instance.bookedDate,
  'pickup_date': ?instance.pickupDate,
  'return_date': ?instance.returnDate,
  'cooling_period_end': ?instance.coolingPeriodDate,
  'advance_amount': ?instance.advanceAmount,
  'security_amount': ?instance.securityAmount,
  'discount_amount': ?instance.discountAmount,
  'purchase_mode': ?instance.purchaseMode,
  'description': ?instance.description,
  'payment_method': ?instance.paymentMethod,
  'delivery_status': ?DeliveryStatus.toJson(instance.deliveryStatus),
  'booking_status': ?BookingStatus.toJson(instance.bookingStatus),
  'variants': ?_productsToJson(instance.products),
  'details': ?instance.otherDetails,
  'additional_charges': ?instance.additionalCharges,
  'send_invoice': instance.sendPdfToWhatsApp,
  'cooling_period_type': ?instance.coolingPeriodType,
  'security_payment_method': ?instance.securityPaymentMethod,
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.upi: 'upi',
  PaymentMethod.cash: 'cash',
};

const _$DeliveryStatusEnumMap = {
  DeliveryStatus.booked: 'booked',
  DeliveryStatus.readyToDeliver: 'readyToDeliver',
  DeliveryStatus.delivered: 'delivered',
  DeliveryStatus.returned: 'returned',
  DeliveryStatus.cancelled: 'cancelled',
};

const _$BookingStatusEnumMap = {
  BookingStatus.upcoming: 'upcoming',
  BookingStatus.completed: 'completed',
  BookingStatus.cancelled: 'cancelled',
};
