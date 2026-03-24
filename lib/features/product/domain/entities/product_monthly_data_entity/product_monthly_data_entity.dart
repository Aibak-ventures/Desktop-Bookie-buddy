import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_monthly_data_entity.freezed.dart';

@freezed
abstract class ProductMonthlyDataEntity with _$ProductMonthlyDataEntity {
  const factory ProductMonthlyDataEntity({
    required int year,
    required int month,
    required double totalExpense,
    required double totalEarned,
  }) = _ProductMonthlyDataEntity;
}
