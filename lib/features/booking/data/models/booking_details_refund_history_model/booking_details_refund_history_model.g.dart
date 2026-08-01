// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details_refund_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingDetailsRefundHistoryModel _$BookingDetailsRefundHistoryModelFromJson(
  Map<String, dynamic> json,
) => _BookingDetailsRefundHistoryModel(
  id: (json['id'] as num).toInt(),
  amount: (json['refunded_amount'] as num).toInt(),
  accountName: json['account_name'] as String?,
  accountId: (json['account_id'] as num?)?.toInt(),
  refundReason: json['refund_reason'] as String?,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$BookingDetailsRefundHistoryModelToJson(
  _BookingDetailsRefundHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'refunded_amount': instance.amount,
  'account_name': instance.accountName,
  'account_id': instance.accountId,
  'refund_reason': instance.refundReason,
  'created_at': instance.createdAt,
};
