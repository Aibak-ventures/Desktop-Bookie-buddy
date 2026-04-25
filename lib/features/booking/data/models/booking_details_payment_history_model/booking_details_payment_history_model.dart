import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_payment_history_model.freezed.dart';
part 'booking_details_payment_history_model.g.dart';

@freezed
abstract class BookingDetailsPaymentHistoryModel
    with _$BookingDetailsPaymentHistoryModel {
  const factory BookingDetailsPaymentHistoryModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'amount') required int amount,
    @JsonKey(name: 'account_name') String? accountName,
    @JsonKey(name: 'account_id') int? accountId,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(
      name: 'type',
      fromJson: BookingPaymentHistoryPaymentType.fromJson,
      toJson: BookingPaymentHistoryPaymentType.toJson,
    )
    @Default(BookingPaymentHistoryPaymentType.payment)
    BookingPaymentHistoryPaymentType paymentType,
  }) = _BookingDetailsPaymentHistoryModel;

  factory BookingDetailsPaymentHistoryModel.fromJson(
    Map<String, dynamic> json,
  ) => _$BookingDetailsPaymentHistoryModelFromJson(json);
}

extension BookingPaymentHistoryModelMapper
    on BookingDetailsPaymentHistoryModel {
  BookingPaymentHistoryEntity toEntity() => BookingPaymentHistoryEntity(
    id: id,
    amount: amount,
    accountName: accountName,
    accountId: accountId,
    createdAt: createdAt,
    paymentType: paymentType,
  );
}
