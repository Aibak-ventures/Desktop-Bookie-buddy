// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MonthlySummaryModelImpl _$$MonthlySummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$MonthlySummaryModelImpl(
      month: json['month'] as String,
      totalBookings: (json['total_bookings'] as num?)?.toInt() ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$MonthlySummaryModelImplToJson(
        _$MonthlySummaryModelImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'total_bookings': instance.totalBookings,
      'revenue': instance.revenue,
    };
