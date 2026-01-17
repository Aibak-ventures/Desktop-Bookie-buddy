// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StockSummaryModelImpl _$$StockSummaryModelImplFromJson(
        Map<String, dynamic> json) =>
    _$StockSummaryModelImpl(
      totalProducts: (json['total_products'] as num).toInt(),
      totalCategories: (json['total_categories'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategorySummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StockSummaryModelImplToJson(
        _$StockSummaryModelImpl instance) =>
    <String, dynamic>{
      'total_products': instance.totalProducts,
      'total_categories': instance.totalCategories,
      'categories': instance.categories,
    };

_$CategorySummaryImpl _$$CategorySummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$CategorySummaryImpl(
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$CategorySummaryImplToJson(
        _$CategorySummaryImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
    };
