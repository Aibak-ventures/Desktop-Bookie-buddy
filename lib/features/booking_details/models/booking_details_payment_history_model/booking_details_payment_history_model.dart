import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_payment_history_model.freezed.dart';
part 'booking_details_payment_history_model.g.dart';

@freezed
class BookingDetailsPaymentHistoryModel
    with _$BookingDetailsPaymentHistoryModel {
  const factory BookingDetailsPaymentHistoryModel({
    @JsonKey(name: 'amount') required int amount,
    @JsonKey(
      name: 'payment_method',
      defaultValue: PaymentMethod.cash,
      fromJson: PaymentMethod.fromString,
      toJson: PaymentMethod.toJson,
    )
    required PaymentMethod paymentMethod,
    @JsonKey(name: 'datetime') required String dateTime,
  }) = _BookingDetailsPaymentHistoryModel;

  factory BookingDetailsPaymentHistoryModel.fromJson(
          Map<String, dynamic> json) =>
      _$BookingDetailsPaymentHistoryModelFromJson(json);
}
