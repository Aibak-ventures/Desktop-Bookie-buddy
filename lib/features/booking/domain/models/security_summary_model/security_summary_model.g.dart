// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SecuritySummaryModel _$SecuritySummaryModelFromJson(
  Map<String, dynamic> json,
) => _SecuritySummaryModel(
  securityAmount: (json['security_amount'] as num?)?.toDouble() ?? 0.0,
  totalRefunded: (json['total_refunded'] as num?)?.toDouble() ?? 0.0,
  totalDeducted: (json['total_deducted'] as num?)?.toDouble() ?? 0.0,
  remainingBalance: (json['remaining_balance'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$SecuritySummaryModelToJson(
  _SecuritySummaryModel instance,
) => <String, dynamic>{
  'security_amount': instance.securityAmount,
  'total_refunded': instance.totalRefunded,
  'total_deducted': instance.totalDeducted,
  'remaining_balance': instance.remainingBalance,
};
