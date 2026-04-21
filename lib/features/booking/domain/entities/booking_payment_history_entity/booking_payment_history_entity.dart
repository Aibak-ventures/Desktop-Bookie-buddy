import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_payment_history_entity.freezed.dart';

@freezed
abstract class BookingPaymentHistoryEntity with _$BookingPaymentHistoryEntity {
  const factory BookingPaymentHistoryEntity({
    int? id,
    required int amount,
    String? accountName,
    int? accountId,
    required String createdAt,
  }) = _BookingPaymentHistoryEntity;
}
