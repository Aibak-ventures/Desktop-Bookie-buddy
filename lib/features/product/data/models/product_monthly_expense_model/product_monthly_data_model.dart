import 'package:bookie_buddy_web/features/product/domain/entities/product_monthly_data_entity/product_monthly_data_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_monthly_data_model.freezed.dart';
part 'product_monthly_data_model.g.dart';

@freezed
abstract class ProductMonthlyDataModel with _$ProductMonthlyDataModel {
  const factory ProductMonthlyDataModel({
    required int year,
    required int month,
    @JsonKey(name: 'total_expense') required double totalExpense,
    @JsonKey(name: 'total_earned') required double totalEarned,
  }) = _ProductMonthlyDataModel;

  factory ProductMonthlyDataModel.fromJson(Map<String, dynamic> json) =>
      _$ProductMonthlyDataModelFromJson(json);
}

extension ProductMonthlyDataModelMapper on ProductMonthlyDataModel {
  ProductMonthlyDataEntity toEntity() => ProductMonthlyDataEntity(
        year: year,
        month: month,
        totalExpense: totalExpense,
        totalEarned: totalEarned,
      );
}
