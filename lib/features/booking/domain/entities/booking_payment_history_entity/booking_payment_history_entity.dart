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
    @Default(BookingPaymentHistoryPaymentType.payment)
    BookingPaymentHistoryPaymentType paymentType,
  }) = _BookingPaymentHistoryEntity;
}

enum BookingPaymentHistoryPaymentType {
  payment('payments'),
  security('security');

  final String value;
  const BookingPaymentHistoryPaymentType(this.value);

  static BookingPaymentHistoryPaymentType fromJson(String? apiValue) {
    if (apiValue == null) return BookingPaymentHistoryPaymentType.payment;
    return values.firstWhere(
      (e) => e.value == apiValue,
      orElse: () => BookingPaymentHistoryPaymentType.payment,
    );
  }

  static String toJson(BookingPaymentHistoryPaymentType type) => type.value;
}
