import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_model.freezed.dart';
part 'sale_model.g.dart';

@freezed
class SaleModel with _$SaleModel {
  const factory SaleModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'client_name') String? clientName,
    @JsonKey(name: 'client_phone') dynamic clientPhone, // Can be String or int
    @JsonKey(name: 'total_amount') required int totalAmount,
    @JsonKey(name: 'paid_amount') required int paidAmount,
    @JsonKey(name: 'discount') required int discountAmount,
    @JsonKey(name: 'sale_date') required String saleDate,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'products') required String products, // Changed from List<String> to String
    @JsonKey(name: 'staff_color') String? staffColor,
  }) = _SaleModel;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
}
