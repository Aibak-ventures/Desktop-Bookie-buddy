// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_payment_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingPaymentRequestModel _$BookingPaymentRequestModelFromJson(
  Map<String, dynamic> json,
) => _BookingPaymentRequestModel(
  accountId: (json['account_id'] as num).toInt(),
  amount: (json['amount'] as num).toInt(),
);

Map<String, dynamic> _$BookingPaymentRequestModelToJson(
  _BookingPaymentRequestModel instance,
) => <String, dynamic>{
  'account_id': instance.accountId,
  'amount': instance.amount,
};
