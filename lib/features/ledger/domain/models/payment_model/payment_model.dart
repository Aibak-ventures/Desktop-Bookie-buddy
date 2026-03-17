import 'package:bookie_buddy_web/core/constants/enums/ledger_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'payment_amount') required int paymentAmount,
    @JsonKey(
        name: 'payment_method',
        fromJson: PaymentMethod.fromJson,
        // toJson: PaymentMethod.toJson,
        includeToJson: false)
    required PaymentMethod paymentMethod,
    @JsonKey(name: 'client_name') String? clientName,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'invoice_id', defaultValue: '') required String invoiceId,
    @JsonKey(
      name: 'type',
      fromJson: LedgerListType.fromJson,
      toJson: LedgerListType.toJson,
    )
    required LedgerListType type,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}
