// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SecuritySummaryModelImpl _$$SecuritySummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SecuritySummaryModelImpl(
      securityAmount: (json['security_amount'] as num?)?.toDouble() ?? 0.0,
      totalRefunded: (json['total_refunded'] as num?)?.toDouble() ?? 0.0,
      totalDeducted: (json['total_deducted'] as num?)?.toDouble() ?? 0.0,
      remainingBalance: (json['remaining_balance'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$SecuritySummaryModelImplToJson(
        _$SecuritySummaryModelImpl instance) =>
    <String, dynamic>{
      'security_amount': instance.securityAmount,
      'total_refunded': instance.totalRefunded,
      'total_deducted': instance.totalDeducted,
      'remaining_balance': instance.remainingBalance,
    };
