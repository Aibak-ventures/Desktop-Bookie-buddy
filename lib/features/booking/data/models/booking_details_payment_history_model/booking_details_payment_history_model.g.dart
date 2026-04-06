// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details_payment_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BookingDetailsPaymentHistoryModel _$BookingDetailsPaymentHistoryModelFromJson(
  Map<String, dynamic> json,
) => _BookingDetailsPaymentHistoryModel(
  id: (json['id'] as num?)?.toInt(),
  amount: (json['amount'] as num).toInt(),
  paymentMethod: json['payment_method'] == null
      ? PaymentMethod.cash
      : PaymentMethod.fromJson(json['payment_method'] as String?),
  dateTime: _readDateTime(json, 'datetime') as String,
);

Map<String, dynamic> _$BookingDetailsPaymentHistoryModelToJson(
  _BookingDetailsPaymentHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'payment_method': instance.paymentMethod,
  'datetime': instance.dateTime,
};
