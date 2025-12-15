import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_request_model.freezed.dart';
part 'sales_request_model.g.dart';

List<Map<String, dynamic>>? _variantsToJson(
  List<ProductSelectedModel>? variants,
) => variants == null || variants.isEmpty
    ? null
    : variants.map((e) => e.toCustomJson(includeMeasurement: false)).toList();

// Map<String, dynamic>? _clientToJson(ClientRequestModel? client) {
//   if (client == null) return null;
//   return {
//     'client_name': client.name,
//     'client_phone_1': client.phone1,
//     'client_phone_2': client.phone2,
//   };
// }

String? _paymentMethodToJson(PaymentMethod? method) =>
    method?.toValue();

@freezed
class SalesRequestModel with _$SalesRequestModel {
  @JsonSerializable(includeIfNull: false)
  const factory SalesRequestModel({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'staff_id') int? staffId,
    // @JsonKey(name: 'client_id') int? clientId,
    // @JsonKey(name: 'client_name') String? clientName,
    @JsonKey(name: 'client_phone') String? clientPhone,
    // @JsonKey(name: 'client_phone_2') String? clientPhone2,
    @JsonKey(name: 'client_address') String? address,
    @JsonKey(name: 'sale_date') String? saleDate,
    @JsonKey(name: 'variants', toJson: _variantsToJson)
    List<ProductSelectedModel>? products,
    @JsonKey(name: 'decrease_stock') bool? stockCountDecrease,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'discount') int? discountAmount,
    @JsonKey(name: 'paid_amount') int? paidAmount,
    @JsonKey(name: 'payment_method', toJson: _paymentMethodToJson)
    @Default(PaymentMethod.cash)
    PaymentMethod? paymentMethod,
    @JsonKey(name: 'send_invoice', includeToJson: true, includeFromJson: false)
    @Default(false)
    bool sendPdfToWhatsApp,
  }) = _SalesRequestModel;

  factory SalesRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SalesRequestModelFromJson(json);
}
