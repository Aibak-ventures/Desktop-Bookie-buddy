import 'package:bookie_buddy_web/core/constants/enums/security_payment_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_security_refund_history_entity.freezed.dart';

@freezed
abstract class BookingSecurityRefundHistoryEntity
    with _$BookingSecurityRefundHistoryEntity {
  const factory BookingSecurityRefundHistoryEntity({
    required int id,
    required int amount,
    String? accountName,
    int? accountId,
    required String note,
    required SecurityPaymentHistoryType type,
    required String createdAt,
  }) = _BookingSecurityRefundHistoryEntity;
}
