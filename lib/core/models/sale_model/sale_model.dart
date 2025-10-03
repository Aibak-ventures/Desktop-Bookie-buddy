import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_model.freezed.dart';
part 'sale_model.g.dart';

@freezed
class SaleModel with _$SaleModel {
  const factory SaleModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'client_name') required String clientName,
    @JsonKey(name: 'total_amount') required int totalAmount,
    @JsonKey(name: 'paid_amount') required int paidAmount,
    @JsonKey(name: 'discount') required int discountAmount,
    @JsonKey(name: 'sale_date') required String saleDate,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'products') required List<String> products,
  }) = _SaleModel;

  factory SaleModel.fromJson(Map<String, dynamic> json) =>
      _$SaleModelFromJson(json);
}
