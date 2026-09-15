import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_security_payment_entity/booking_security_payment_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_security_payment_model.freezed.dart';
part 'booking_security_payment_model.g.dart';

@freezed
abstract class BookingSecurityPaymentModel with _$BookingSecurityPaymentModel {
  const factory BookingSecurityPaymentModel({
    int? id,
    @JsonKey(name: 'amount') required int amount,
    @JsonKey(name: 'account_name') String? accountName,
    @JsonKey(name: 'account_id') int? accountId,
    @JsonKey(name: 'paid_at') String? paidAt,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _BookingSecurityPaymentModel;

  factory BookingSecurityPaymentModel.fromJson(Map<String, dynamic> json) =>
      _$BookingSecurityPaymentModelFromJson(json);
}

extension BookingSecurityPaymentModelMapper on BookingSecurityPaymentModel {
  BookingSecurityPaymentEntity toEntity() => BookingSecurityPaymentEntity(
    id: id,
    amount: amount,
    accountName: accountName,
    accountId: accountId,
    paidAt: paidAt,
    createdAt: createdAt,
  );
}
