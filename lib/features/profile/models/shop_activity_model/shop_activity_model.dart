import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_activity_model.freezed.dart';
part 'shop_activity_model.g.dart';

@freezed
class ShopActivityModel with _$ShopActivityModel {
  const factory ShopActivityModel({
    required int id,
    required String action,
    required String message,
    @JsonKey(name: 'user_name') required String userName,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'booking_id') int? bookingId,
    @JsonKey(name: 'sale_id') int? saleId,
    @JsonKey(name: 'client_id') int? clientId,
    @JsonKey(name: 'product_id') int? productId,
    @JsonKey(name: 'expense_id') int? expenseId,
    @Default({}) Map<String, dynamic> metadata,
  }) = _ShopActivityModel;

  factory ShopActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ShopActivityModelFromJson(json);
}
