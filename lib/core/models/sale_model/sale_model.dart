import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_model.freezed.dart';
part 'sale_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class SaleModel with _$SaleModel {
  const factory SaleModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'shop_sale_id') String? shopSaleId,
    @JsonKey(name: 'client_name') String? clientName,
    @JsonKey(name: 'client_phone') dynamic clientPhone, // Can be String or int
    @JsonKey(name: 'total_amount') required int totalAmount,
    @JsonKey(name: 'paid_amount') required int paidAmount,
    @JsonKey(name: 'discount') required int discountAmount,
    @JsonKey(name: 'sale_date') required String saleDate,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'products') required String products, // Changed from List<String> to String
    @JsonKey(name: 'staff_color', unknownEnumValue: null) String? staffColor, // Note: API sometimes returns "staff_col lor" with space - handled by fromJson
  }) = _SaleModel;

 factory SaleModel.fromJson(Map<String, dynamic> json) {
  if (json.containsKey('staff_col lor')) {
    json['staff_color'] = json['staff_col lor'];
  }
  return _$SaleModelFromJson(json);
}

}
