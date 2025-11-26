import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_model.freezed.dart';
part 'expense_model.g.dart';

@freezed
class ExpenseModel with _$ExpenseModel {
  const factory ExpenseModel({
    @JsonKey(
      name: 'id',
      includeToJson: false,
    )
    required int id,
    @JsonKey(name: 'service_id') int? serviceId,
    @JsonKey(name: 'product_id') int? productId,
    @JsonKey(name: 'variant_id') int? variantId,
    @JsonKey(name: 'created_at', defaultValue: '') required String date,
    // @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(
      name: 'user',
      defaultValue: 'Unknown',
    )
    required String userName,
    @JsonKey(name: 'expense', defaultValue: 0) required int expense,
    String? type,
    String? description,
    @JsonKey(
      name: 'is_deleted',
      defaultValue: false,
    )
    @JsonKey(name: 'is_deleted')
    required bool? isDeleted,
  }) = _ExpenseModel;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);
}
