// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_security_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingSecurityPaymentModel _$BookingSecurityPaymentModelFromJson(
  Map<String, dynamic> json,
) => _BookingSecurityPaymentModel(
  id: (json['id'] as num?)?.toInt(),
  amount: (json['amount'] as num).toInt(),
  accountName: json['account_name'] as String?,
  accountId: (json['account_id'] as num?)?.toInt(),
  paidAt: json['paid_at'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$BookingSecurityPaymentModelToJson(
  _BookingSecurityPaymentModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'account_name': instance.accountName,
  'account_id': instance.accountId,
  'paid_at': instance.paidAt,
  'created_at': instance.createdAt,
};
