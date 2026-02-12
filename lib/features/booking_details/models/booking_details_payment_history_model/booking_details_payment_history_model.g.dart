// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_details_payment_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingDetailsPaymentHistoryModelImpl
    _$$BookingDetailsPaymentHistoryModelImplFromJson(
            Map<String, dynamic> json) =>
        _$BookingDetailsPaymentHistoryModelImpl(
          amount: (json['amount'] as num).toInt(),
          paymentMethod: json['payment_method'] == null
              ? PaymentMethod.cash
              : PaymentMethod.fromJson(json['payment_method'] as String?),
          dateTime: _readDateTime(json, 'datetime') as String,
        );

Map<String, dynamic> _$$BookingDetailsPaymentHistoryModelImplToJson(
        _$BookingDetailsPaymentHistoryModelImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'payment_method': instance.paymentMethod,
      'datetime': instance.dateTime,
    };
