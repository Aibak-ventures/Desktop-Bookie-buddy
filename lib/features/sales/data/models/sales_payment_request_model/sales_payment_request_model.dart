
import 'package:bookie_buddy_shared/core/features/sales/domain/entities/sales_payment_request_entity/sales_payment_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_payment_request_model.freezed.dart';
part 'sales_payment_request_model.g.dart';

@freezed
abstract class SalesPaymentRequestModel with _$SalesPaymentRequestModel {
  // includeIfNull: false — a leg without an id must serialize with no `id`
  // key at all (an id-less entry creates a new payment record; sending
  // `"id": null` is not the same thing to the backend).
  @JsonSerializable(includeIfNull: false)
  const factory SalesPaymentRequestModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'account_id') required int accountId,
    @JsonKey(name: 'amount') required int amount,
  }) = _SalesPaymentRequestModel;

  factory SalesPaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SalesPaymentRequestModelFromJson(json);

  factory SalesPaymentRequestModel.fromEntity(
    SalesPaymentRequestEntity entity,
  ) => SalesPaymentRequestModel(
    id: entity.id,
    accountId: entity.accountId,
    amount: entity.amount,
  );
}
