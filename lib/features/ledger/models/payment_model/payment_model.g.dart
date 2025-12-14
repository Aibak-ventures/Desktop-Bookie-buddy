// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentModelImpl _$$PaymentModelImplFromJson(Map<String, dynamic> json) =>
    _$PaymentModelImpl(
      bookingId: (json['id'] as num).toInt(),
      paymentAmount: (json['payment_amount'] as num).toInt(),
      paymentMethod: PaymentMethod.fromString(json['payment_method'] as String),
      clientName: json['client_name'] as String? ?? 'Unknown',
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$PaymentModelImplToJson(_$PaymentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.bookingId,
      'payment_amount': instance.paymentAmount,
      'payment_method': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'client_name': instance.clientName,
      'created_at': instance.createdAt,
    };

const _$PaymentMethodEnumMap = {
  PaymentMethod.gPay: 'gPay',
  PaymentMethod.cash: 'cash',
};
