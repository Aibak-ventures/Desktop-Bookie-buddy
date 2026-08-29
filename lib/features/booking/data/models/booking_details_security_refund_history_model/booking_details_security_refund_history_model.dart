import 'package:bookie_buddy_core/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_security_refund_history_model.freezed.dart';
part 'booking_details_security_refund_history_model.g.dart';

@freezed
abstract class BookingDetailsSecurityRefundHistoryModel
    with _$BookingDetailsSecurityRefundHistoryModel {
  const factory BookingDetailsSecurityRefundHistoryModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'amount') required int amount,
    @JsonKey(name: 'account_name') String? accountName,
    @JsonKey(name: 'account_id') int? accountId,
    @JsonKey(name: 'reason') required String note,
    @JsonKey(
      name: 'type',
      fromJson: SecurityPaymentHistoryType.fromJson,
      includeToJson: false,
    )
    required SecurityPaymentHistoryType type,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _BookingDetailsSecurityRefundHistoryModel;

  factory BookingDetailsSecurityRefundHistoryModel.fromJson(
    Map<String, dynamic> json,
  ) => _$BookingDetailsSecurityRefundHistoryModelFromJson(json);
}

extension BookingDetailsSecurityRefundHistoryModelMapper
    on BookingDetailsSecurityRefundHistoryModel {
  BookingSecurityRefundHistoryEntity toEntity() =>
      BookingSecurityRefundHistoryEntity(
        id: id,
        amount: amount,
        accountName: accountName,
        accountId: accountId,
        note: note,
        type: type,
        createdAt: createdAt,
      );
}
