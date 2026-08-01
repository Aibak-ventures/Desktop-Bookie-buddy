// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details_security_refund_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingDetailsSecurityRefundHistoryModel
_$BookingDetailsSecurityRefundHistoryModelFromJson(Map<String, dynamic> json) =>
    _BookingDetailsSecurityRefundHistoryModel(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      accountName: json['account_name'] as String?,
      accountId: (json['account_id'] as num?)?.toInt(),
      note: json['reason'] as String,
      type: SecurityPaymentHistoryType.fromJson(json['type'] as String?),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$BookingDetailsSecurityRefundHistoryModelToJson(
  _BookingDetailsSecurityRefundHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'account_name': instance.accountName,
  'account_id': instance.accountId,
  'reason': instance.note,
  'created_at': instance.createdAt,
};
