import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_summary_model.freezed.dart';
part 'stock_summary_model.g.dart';

@freezed
class StockSummaryModel with _$StockSummaryModel {
  const factory StockSummaryModel({
    @JsonKey(name: 'total_products') required int totalProducts,
    @JsonKey(name: 'total_categories') required int totalCategories,
    @JsonKey(name: 'categories') required List<CategorySummary> categories,
  }) = _StockSummaryModel;

  factory StockSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$StockSummaryModelFromJson(json);
}

@freezed
class CategorySummary with _$CategorySummary {
  const factory CategorySummary({
    required String name,
    required int count,
  }) = _CategorySummary;

  factory CategorySummary.fromJson(Map<String, dynamic> json) =>
      _$CategorySummaryFromJson(json);
}
