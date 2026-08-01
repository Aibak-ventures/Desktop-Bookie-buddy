import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_security_payment_entity.freezed.dart';

/// The original security-deposit payment record (as opposed to
/// [BookingSecurityRefundHistoryEntity], which tracks refunds/deductions
/// made against it).
@freezed
abstract class BookingSecurityPaymentEntity
    with _$BookingSecurityPaymentEntity {
  const factory BookingSecurityPaymentEntity({
    int? id,
    required int amount,
    String? accountName,
    int? accountId,
    String? paidAt,
    String? createdAt,
  }) = _BookingSecurityPaymentEntity;
}
