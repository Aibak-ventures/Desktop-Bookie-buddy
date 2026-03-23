// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockSummaryModel _$StockSummaryModelFromJson(Map<String, dynamic> json) =>
    _StockSummaryModel(
      totalProducts: (json['total_products'] as num).toInt(),
      totalCategories: (json['total_categories'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategorySummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockSummaryModelToJson(_StockSummaryModel instance) =>
    <String, dynamic>{
      'total_products': instance.totalProducts,
      'total_categories': instance.totalCategories,
      'categories': instance.categories,
    };

_CategorySummary _$CategorySummaryFromJson(Map<String, dynamic> json) =>
    _CategorySummary(
      name: json['name'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$CategorySummaryToJson(_CategorySummary instance) =>
    <String, dynamic>{'name': instance.name, 'count': instance.count};
