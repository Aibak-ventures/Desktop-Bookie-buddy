import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_payment_history_model.freezed.dart';
part 'booking_details_payment_history_model.g.dart';

// Custom reader to support both 'datetime' and 'created_at' field names
String _readDateTime(Map json, String key) {
  return json['datetime'] ?? json['created_at'] ?? '';
}

@freezed
abstract class BookingDetailsPaymentHistoryModel
    with _$BookingDetailsPaymentHistoryModel {
  const factory BookingDetailsPaymentHistoryModel({
    @JsonKey(name: 'amount') required int amount,
    @JsonKey(
      name: 'payment_method',
      defaultValue: PaymentMethod.cash,
      fromJson: PaymentMethod.fromJson,
    )
    required PaymentMethod paymentMethod,
    @JsonKey(name: 'datetime', readValue: _readDateTime)
    required String dateTime,
  }) = _BookingDetailsPaymentHistoryModel;

  factory BookingDetailsPaymentHistoryModel.fromJson(
          Map<String, dynamic> json) =>
      _$BookingDetailsPaymentHistoryModelFromJson(json);
}
