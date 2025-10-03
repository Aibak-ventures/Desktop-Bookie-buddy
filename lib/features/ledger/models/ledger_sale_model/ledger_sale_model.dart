import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_sale_model.freezed.dart';
part 'ledger_sale_model.g.dart';

@freezed
class LedgerSaleModel with _$LedgerSaleModel {
  const factory LedgerSaleModel({
    @JsonKey(name: 'id') required int saleId,
    @JsonKey(name: 'sale_date') required String date,
    @JsonKey(name: 'created_at', defaultValue: '') required String createdAt,
    @JsonKey(name: 'total_amount') required int totalAmount,
    @JsonKey(name: 'client_name') required String clientName,
    @JsonKey(name: 'items') required List<String> products,
    @JsonKey(
      name: 'payment_methods',
      fromJson: PaymentMethod.fromList,
      toJson: PaymentMethod.toList,
    )
    required List<PaymentMethod> paymentMethods,
  }) = _LedgerSaleModel;

  factory LedgerSaleModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerSaleModelFromJson(json);
}
