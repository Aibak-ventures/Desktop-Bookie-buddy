import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_request_model.freezed.dart';
part 'expense_request_model.g.dart';

@freezed
class ExpenseRequestModel with _$ExpenseRequestModel {
  const factory ExpenseRequestModel({
    @JsonKey(
      includeToJson: true,
      includeIfNull: false,
    )
    int? expenseId,
    @JsonKey(
      name: 'product_variant',
      includeIfNull: false,
    )
    int? variantId,
    @JsonKey(
      includeIfNull: false,
    )
    String? date,
    @JsonKey(
      name: 'expense',
      includeIfNull: false,
    )
    int? amount,
    @JsonKey(
      includeIfNull: false,
    )
    String? type,
    @JsonKey(
      includeIfNull: false,
    )
    String? description,
  }) = _ExpenseRequestModel;

  factory ExpenseRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseRequestModelFromJson(json);
}
