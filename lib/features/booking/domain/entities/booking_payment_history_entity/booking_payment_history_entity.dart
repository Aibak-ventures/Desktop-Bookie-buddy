import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_payment_history_entity.freezed.dart';

@freezed
abstract class BookingPaymentHistoryEntity with _$BookingPaymentHistoryEntity {
  const factory BookingPaymentHistoryEntity({
    required int amount,
    required PaymentMethod paymentMethod,
    required String dateTime,
  }) = _BookingPaymentHistoryEntity;
}
