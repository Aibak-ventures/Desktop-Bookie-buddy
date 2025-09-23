// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailySummaryModelImpl _$$DailySummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailySummaryModelImpl(
      date: json['date'] as String,
      payments:
          PaymentsSummary.fromJson(json['payments'] as Map<String, dynamic>),
      expenses: (_readValue(json, 'expenses') as num).toInt(),
      pendings: (_readValue(json, 'pendings') as num).toInt(),
      securityAmount: (_readValue(json, 'security') as num).toInt(),
    );

Map<String, dynamic> _$$DailySummaryModelImplToJson(
        _$DailySummaryModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'payments': instance.payments,
      'expenses': instance.expenses,
      'pendings': instance.pendings,
      'security': instance.securityAmount,
    };

_$PaymentsSummaryImpl _$$PaymentsSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$PaymentsSummaryImpl(
      gpay: (json['gpay'] as num).toInt(),
      cash: (json['cash'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$PaymentsSummaryImplToJson(
        _$PaymentsSummaryImpl instance) =>
    <String, dynamic>{
      'gpay': instance.gpay,
      'cash': instance.cash,
      'total': instance.total,
    };
