// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingDetailsModelImpl _$$BookingDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BookingDetailsModelImpl(
      id: (json['id'] as num).toInt(),
      invoiceId: json['shop_booking_id'] as String,
      pickupDate: json['pickup_date'] as String?,
      returnDate: json['return_date'] as String,
      coolingPeriodDate: json['cooling_period_end'] as String?,
      totalAmount: (json['total_amount'] as num).toInt(),
      discountAmount: (json['discount_amount'] as num?)?.toInt(),
      paidAmount: (json['advance_amount'] as num).toInt(),
      securityAmount: (json['security_amount'] as num?)?.toInt(),
      purchaseMode: json['purchase_mode'] == null
          ? PurchaseMode.normal
          : PurchaseMode.fromString(json['purchase_mode'] as String?),
      bookingStatus: json['booking_status'] == null
          ? BookingStatus.upcoming
          : BookingStatus.fromString(json['booking_status'] as String),
      paymentStatus: json['payment_status'] == null
          ? PaymentStatus.pending
          : PaymentStatus.fromBool(json['payment_status'] as bool?),
      deliveryStatus: json['delivery_status'] == null
          ? DeliveryStatus.booked
          : DeliveryStatus.fromString(json['delivery_status'] as String),
      staffName: json['staff_name'] as String?,
      staffId: (json['staff_id'] as num?)?.toInt(),
      otherDetails: json['details'] == null
          ? BookingOtherDetailsModel.empty()
          : BookingOtherDetailsModel.fromJson(
              json['details'] as Map<String, dynamic>),
      bookedDate: json['created_at'] as String,
      bookingCompletedDate: json['completed_at'] as String?,
      address: json['client_address'] as String?,
      client: ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      description: json['description'] as String?,
      documents: json['documents'] as List<dynamic>? ?? const [],
      bookedItems: (json['booked_items'] as List<dynamic>)
          .map((e) => ProductInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      additionalCharges: (json['additional_charges'] as List<dynamic>?)
              ?.map((e) =>
                  AdditionalChargesModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      payments: (json['payments'] as List<dynamic>?)
              ?.map((e) => BookingDetailsPaymentHistoryModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      refunds: json['refunds'] as List<dynamic>? ?? const [],
      totalRefunded: (json['total_refunded'] as num?)?.toDouble() ?? 0.0,
      refundableBalance:
          (json['refundable_balance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$BookingDetailsModelImplToJson(
        _$BookingDetailsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_booking_id': instance.invoiceId,
      'pickup_date': instance.pickupDate,
      'return_date': instance.returnDate,
      'cooling_period_end': instance.coolingPeriodDate,
      'total_amount': instance.totalAmount,
      'discount_amount': instance.discountAmount,
      'advance_amount': instance.paidAmount,
      'security_amount': instance.securityAmount,
      'purchase_mode': _$PurchaseModeEnumMap[instance.purchaseMode]!,
      'booking_status': BookingStatus.toJson(instance.bookingStatus),
      'payment_status': PaymentStatus.toJson(instance.paymentStatus),
      'delivery_status': DeliveryStatus.toJson(instance.deliveryStatus),
      'staff_name': instance.staffName,
      'staff_id': instance.staffId,
      'details': instance.otherDetails,
      'created_at': instance.bookedDate,
      'completed_at': instance.bookingCompletedDate,
      'client_address': instance.address,
      'client': instance.client,
      'description': instance.description,
      'documents': instance.documents,
      'booked_items': instance.bookedItems,
      'additional_charges': instance.additionalCharges,
      'payments': instance.payments,
      'refunds': instance.refunds,
      'total_refunded': instance.totalRefunded,
      'refundable_balance': instance.refundableBalance,
    };

const _$PurchaseModeEnumMap = {
  PurchaseMode.normal: 'normal',
  PurchaseMode.package: 'package',
};
