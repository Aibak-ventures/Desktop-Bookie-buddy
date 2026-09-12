// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingDetailsModel _$BookingDetailsModelFromJson(
  Map<String, dynamic> json,
) => _BookingDetailsModel(
  id: (json['id'] as num).toInt(),
  invoiceId: json['shop_booking_id'] as String,
  pickupDate: json['pickup_date'] as String?,
  returnDate: json['return_date'] as String,
  pickupTime: json['pickup_time'] as String?,
  returnTime: json['return_time'] as String?,
  coolingPeriodDate: json['cooling_period_end'] as String?,
  coolingPeriodType: json['cooling_period_type'] as String?,
  totalAmount: (json['total_amount'] as num).toInt(),
  totalPayable: (json['total_payable'] as num?)?.toInt(),
  balanceAmount: (json['balance'] as num?)?.toInt() ?? 0,
  discountAmount: (json['discount_amount'] as num?)?.toInt(),
  paidAmount: (json['advance_amount'] as num).toInt(),
  totalAmountWithSecurity: (json['total_amount_with_security'] as num?)
      ?.toInt(),
  paidAmountWithSecurity: (json['advance_amount_with_security'] as num?)
      ?.toInt(),
  securityAmount: (json['security_amount'] as num?)?.toInt(),
  purchaseMode: json['purchase_mode'] == null
      ? PurchaseMode.normal
      : PurchaseMode.fromJson(json['purchase_mode'] as String?),
  bookingStatus: json['booking_status'] == null
      ? BookingStatus.upcoming
      : BookingStatus.fromJson(json['booking_status'] as String?),
  paymentStatus: json['payment_status'] == null
      ? PaymentStatus.pending
      : PaymentStatus.fromBool(json['payment_status'] as bool?),
  deliveryStatus: json['delivery_status'] == null
      ? DeliveryStatus.booked
      : DeliveryStatus.fromJson(json['delivery_status'] as String?),
  staffName: json['staff_name'] as String?,
  staffId: (json['staff_id'] as num?)?.toInt(),
  otherDetails: json['details'] == null
      ? BookingOtherDetailsModel.empty()
      : BookingOtherDetailsModel.fromJson(
          json['details'] as Map<String, dynamic>,
        ),
  bookedDate: json['created_at'] as String,
  bookingCompletedDate: json['completed_at'] as String?,
  address: json['client_address'] as String?,
  client: ClientModel.fromJson(json['client'] as Map<String, dynamic>),
  description: json['description'] as String?,
  documents: json['documents'] as List<dynamic>? ?? const [],
  bookedItems: (json['booked_items'] as List<dynamic>)
      .map((e) => ProductInfoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  additionalCharges:
      (json['additional_charges'] as List<dynamic>?)
          ?.map(
            (e) => AdditionalChargesModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  payments:
      (json['payments'] as List<dynamic>?)
          ?.map(
            (e) => BookingDetailsPaymentHistoryModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const [],
  refunds: json['refunds'] == null
      ? const []
      : _refundsFromJson(json['refunds'] as List?),
  totalRefunded: (json['total_refunded'] as num?)?.toDouble() ?? 0.0,
  refundableBalance: (json['refundable_balance'] as num?)?.toDouble() ?? 0.0,
  securitySummary: json['security_summary'] == null
      ? SecuritySummaryModel.empty
      : SecuritySummaryModel.fromJson(
          json['security_summary'] as Map<String, dynamic>,
        ),
  securityTransactionHistory:
      (json['security_adjustments'] as List<dynamic>?)
          ?.map(
            (e) => BookingDetailsSecurityRefundHistoryModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      const [],
  isSecurityPaid: json['security_amount_is_paid'] as bool? ?? false,
  securityPayment: json['security'] == null
      ? null
      : BookingSecurityPaymentModel.fromJson(
          json['security'] as Map<String, dynamic>,
        ),
  securityAccountName: json['security_account_name'] as String?,
  securityAccountId: (json['security_account_id'] as num?)?.toInt(),
  appliedTaxes: json['tax'] == null
      ? const []
      : AppliedTaxModel.listFromJson(json['tax']),
);

Map<String, dynamic> _$BookingDetailsModelToJson(
  _BookingDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'shop_booking_id': instance.invoiceId,
  'pickup_date': instance.pickupDate,
  'return_date': instance.returnDate,
  'pickup_time': instance.pickupTime,
  'return_time': instance.returnTime,
  'cooling_period_end': instance.coolingPeriodDate,
  'cooling_period_type': instance.coolingPeriodType,
  'total_amount': instance.totalAmount,
  'total_payable': instance.totalPayable,
  'balance': instance.balanceAmount,
  'discount_amount': instance.discountAmount,
  'advance_amount': instance.paidAmount,
  'total_amount_with_security': instance.totalAmountWithSecurity,
  'advance_amount_with_security': instance.paidAmountWithSecurity,
  'security_amount': instance.securityAmount,
  'purchase_mode': PurchaseMode.toJson(instance.purchaseMode),
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
  'security_summary': instance.securitySummary,
  'security_adjustments': instance.securityTransactionHistory,
  'security_amount_is_paid': instance.isSecurityPaid,
  'security': instance.securityPayment,
  'security_account_name': instance.securityAccountName,
  'security_account_id': instance.securityAccountId,
  'tax': instance.appliedTaxes,
};
