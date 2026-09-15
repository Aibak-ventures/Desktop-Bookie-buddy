import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_refund_history_entity/booking_refund_history_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_refund_history_model.freezed.dart';
part 'booking_details_refund_history_model.g.dart';

@freezed
abstract class BookingDetailsRefundHistoryModel
    with _$BookingDetailsRefundHistoryModel {
  const factory BookingDetailsRefundHistoryModel({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'refunded_amount') required int amount,
    @JsonKey(name: 'account_name') String? accountName,
    @JsonKey(name: 'account_id') int? accountId,
    @JsonKey(name: 'refund_reason') String? refundReason,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _BookingDetailsRefundHistoryModel;

  factory BookingDetailsRefundHistoryModel.fromJson(
    Map<String, dynamic> json,
  ) => _$BookingDetailsRefundHistoryModelFromJson(json);
}

extension BookingDetailsRefundHistoryModelMapper
    on BookingDetailsRefundHistoryModel {
  BookingRefundHistoryEntity toEntity() => BookingRefundHistoryEntity(
    id: id,
    amount: amount,
    accountName: accountName,
    accountId: accountId,
    refundReason: refundReason,
    createdAt: createdAt,
  );
}
