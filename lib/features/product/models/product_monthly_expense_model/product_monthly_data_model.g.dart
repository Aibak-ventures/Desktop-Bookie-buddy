// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_monthly_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductMonthlyDataModelImpl _$$ProductMonthlyDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductMonthlyDataModelImpl(
      year: (json['year'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      totalExpense: (json['total_expense'] as num).toDouble(),
      totalEarned: (json['total_earned'] as num).toDouble(),
    );

Map<String, dynamic> _$$ProductMonthlyDataModelImplToJson(
        _$ProductMonthlyDataModelImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'total_expense': instance.totalExpense,
      'total_earned': instance.totalEarned,
    };
