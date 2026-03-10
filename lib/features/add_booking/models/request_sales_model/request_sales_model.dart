import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_sales_model.freezed.dart';
part 'request_sales_model.g.dart';

/// Model for creating a sale
@freezed
class RequestSalesModel with _$RequestSalesModel {
  @JsonSerializable(includeIfNull: false)
  const factory RequestSalesModel({
    @JsonKey(name: 'staff_id') int? staffId,
    @JsonKey(name: 'client_phone') String? clientPhone,
    @JsonKey(name: 'client_address') String? clientAddress,
    @JsonKey(name: 'sale_date') String? saleDate,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'send_invoice') @Default(false) bool sendInvoice,
    @JsonKey(name: 'variants') List<Map<String, dynamic>>? variants,
    @JsonKey(name: 'paid_amount') int? paidAmount,
    @JsonKey(name: 'payment_method') PaymentMethod? paymentMethod,
    @JsonKey(name: 'discount') int? discount,
    @JsonKey(name: 'decrease_stock') @Default(false) bool decreaseStock,
  }) = _RequestSalesModel;

  factory RequestSalesModel.fromJson(Map<String, dynamic> json) =>
      _$RequestSalesModelFromJson(json);
}
