import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_request_entity/booking_payment_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_payment_request_model.freezed.dart';
part 'booking_payment_request_model.g.dart';

@freezed
abstract class BookingPaymentRequestModel with _$BookingPaymentRequestModel {
  const factory BookingPaymentRequestModel({
    @JsonKey(name: 'account_id') required int accountId,
    @JsonKey(name: 'amount') required int amount,
  }) = _BookingPaymentRequestModel;

  factory BookingPaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BookingPaymentRequestModelFromJson(json);

  factory BookingPaymentRequestModel.fromEntity(
    BookingPaymentRequestEntity entity,
  ) => BookingPaymentRequestModel(
    accountId: entity.accountId,
    amount: entity.amount,
  );
}
