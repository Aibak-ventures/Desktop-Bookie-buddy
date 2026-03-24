import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/product/data/models/product_selected_model/product_selected_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/entities/sales_request_entity/sales_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_request_model.freezed.dart';
part 'sales_request_model.g.dart';

List<Map<String, dynamic>>? _variantsToJson(
  List<ProductSelectedModel>? variants,
) => variants == null || variants.isEmpty
    ? null
    : variants.map((e) => e.toCustomJson(includeMeasurement: false)).toList();

String? _paymentMethodToJson(PaymentMethod? method) => method?.value;

@freezed
abstract class SalesRequestModel with _$SalesRequestModel {
  @JsonSerializable(includeIfNull: false)
  const factory SalesRequestModel({
    @JsonKey(includeToJson: false) int? id,
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'client_phone') String? clientPhone,
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

  factory SalesRequestModel.fromEntity(SalesRequestEntity entity) =>
      SalesRequestModel(
        id: entity.id,
        staffId: entity.staffId,
        clientPhone: entity.clientPhone,
        address: entity.address,
        saleDate: entity.saleDate,
        products: entity.products?.map((e) => e.toModel()).toList(),
        stockCountDecrease: entity.stockCountDecrease,
        description: entity.description,
        discountAmount: entity.discountAmount,
        paidAmount: entity.paidAmount,
        paymentMethod: entity.paymentMethod,
        sendPdfToWhatsApp: entity.sendPdfToWhatsApp,
      );
}
