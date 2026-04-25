// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details_payment_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingDetailsPaymentHistoryModel _$BookingDetailsPaymentHistoryModelFromJson(
  Map<String, dynamic> json,
) => _BookingDetailsPaymentHistoryModel(
  id: (json['id'] as num?)?.toInt(),
  amount: (json['amount'] as num).toInt(),
  accountName: json['account_name'] as String?,
  accountId: (json['account_id'] as num?)?.toInt(),
  createdAt: json['created_at'] as String,
  paymentType: json['type'] == null
      ? BookingPaymentHistoryPaymentType.payment
      : BookingPaymentHistoryPaymentType.fromJson(json['type'] as String?),
);

Map<String, dynamic> _$BookingDetailsPaymentHistoryModelToJson(
  _BookingDetailsPaymentHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'account_name': instance.accountName,
  'account_id': instance.accountId,
  'created_at': instance.createdAt,
  'type': BookingPaymentHistoryPaymentType.toJson(instance.paymentType),
};
