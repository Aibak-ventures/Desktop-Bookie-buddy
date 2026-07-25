import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_refund_history_entity.freezed.dart';

@freezed
abstract class BookingRefundHistoryEntity with _$BookingRefundHistoryEntity {
  const factory BookingRefundHistoryEntity({
    required int id,
    required int amount,
    required String? accountName,
    required int? accountId,
    String? refundReason,
    required String createdAt,
  }) = _BookingRefundHistoryEntity;
}
