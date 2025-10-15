// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailySummaryModelImpl _$$DailySummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$DailySummaryModelImpl(
      date: json['date'] as String,
      payments: LedgerPaymentsSummaryModel.fromJson(
          json['payments'] as Map<String, dynamic>),
      expenses: (_readSummaryValue(json, 'expenses') as num).toInt(),
      pendings: (_readSummaryValue(json, 'pendings') as num).toInt(),
      securityAmount: (_readSummaryValue(json, 'security') as num).toInt(),
      bookingAmount: (_readSummaryValue(json, 'bookings') as num).toInt(),
      salesAmount: (_readSummaryValue(json, 'sales') as num).toInt(),
    );

Map<String, dynamic> _$$DailySummaryModelImplToJson(
        _$DailySummaryModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'payments': instance.payments,
      'expenses': instance.expenses,
      'pendings': instance.pendings,
      'security': instance.securityAmount,
      'bookings': instance.bookingAmount,
      'sales': instance.salesAmount,
    };
