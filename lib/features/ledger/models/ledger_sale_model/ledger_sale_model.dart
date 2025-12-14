import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_sale_model.freezed.dart';
part 'ledger_sale_model.g.dart';

@freezed
class LedgerSaleModel with _$LedgerSaleModel {
  const factory LedgerSaleModel({
    // ✅ API: "id"
    @JsonKey(name: 'id') required int saleId,

    // ✅ API does NOT have sale_date → derive from created_at
    @JsonKey(name: 'created_at', defaultValue: '')
    required String createdAt,

    // ✅ API: "total_amount"
    @JsonKey(name: 'total_amount', defaultValue: 0)
    required int totalAmount,

    // ✅ API does NOT send client_name in sales
    @Default('') String clientName,

    // ✅ API: "items" is STRING, UI expects List
    @JsonKey(name: 'items', fromJson: _itemsFromJson)
    required List<String> products,

    // ✅ API: payment_methods is STRING → convert to List<PaymentMethod>
    @JsonKey(name: 'payment_methods', fromJson: _paymentMethodsFromJson)
    required List<PaymentMethod> paymentMethods,
  }) = _LedgerSaleModel;

  factory LedgerSaleModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerSaleModelFromJson(json);
}

/// 🔧 Converts "items": "Duke" → ["Duke"]
List<String> _itemsFromJson(dynamic value) {
  if (value == null) return [];
  if (value is List) return value.map((e) => e.toString()).toList();
  return [value.toString()];
}

/// 🔧 Converts "payment_methods": "GPay" → [PaymentMethod.gpay]
List<PaymentMethod> _paymentMethodsFromJson(dynamic value) {
  if (value == null) return [];
  if (value is List) {
    return value.map((e) => PaymentMethod.fromString(e.toString())).toList();
  }
  return [PaymentMethod.fromString(value.toString())];
}
