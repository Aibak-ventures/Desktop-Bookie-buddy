// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_sales_grouped_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerSalesGroupedModelImpl _$$LedgerSalesGroupedModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerSalesGroupedModelImpl(
      dailySales: (json['dailySales'] as List<dynamic>)
          .map((e) => LedgerSaleDailyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LedgerSalesGroupedModelImplToJson(
        _$LedgerSalesGroupedModelImpl instance) =>
    <String, dynamic>{
      'dailySales': instance.dailySales,
    };

_$LedgerSaleDailyModelImpl _$$LedgerSaleDailyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerSaleDailyModelImpl(
      date: json['date'] as String,
      total: (json['total'] as num?)?.toInt() ?? 0,
      sales: (json['sales'] as List<dynamic>)
          .map((e) => LedgerSaleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LedgerSaleDailyModelImplToJson(
        _$LedgerSaleDailyModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'total': instance.total,
      'sales': instance.sales,
    };
