import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/ledger/utils/ledger_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_sale_model.freezed.dart';
part 'ledger_sale_model.g.dart';

@freezed
class LedgerSaleModel with _$LedgerSaleModel {
  const factory LedgerSaleModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'invoice_id', defaultValue: '') required String invoiceId,
    @JsonKey(name: 'total_amount') required int totalAmount,
    @JsonKey(name: 'items', defaultValue: '') required String products,
    @JsonKey(
      name: 'payment_methods',
      fromJson:PaymentMethod.fromJson,
      // toJson: PaymentMethod.toJson,
      defaultValue: PaymentMethod.cash,
    )
    required PaymentMethod paymentMethods,
    @JsonKey(name: 'created_at') required String date,
    @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson,
    )
    required LedgerListType type,
  }) = _LedgerSaleModel;

  factory LedgerSaleModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerSaleModelFromJson(json);
}
