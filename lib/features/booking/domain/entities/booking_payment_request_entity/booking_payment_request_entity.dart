import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_payment_request_entity.freezed.dart';

@freezed
abstract class BookingPaymentRequestEntity with _$BookingPaymentRequestEntity {
  const factory BookingPaymentRequestEntity({
    required int accountId,
    required int amount,
  }) = _BookingPaymentRequestEntity;
}
