// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentModelImpl _$$PaymentModelImplFromJson(Map<String, dynamic> json) =>
    _$PaymentModelImpl(
      id: (json['id'] as num).toInt(),
      paymentAmount: (json['payment_amount'] as num).toInt(),
      paymentMethod: PaymentMethod.fromJson(json['payment_method'] as String?),
      clientName: json['client_name'] as String?,
      createdAt: json['created_at'] as String,
      invoiceId: json['invoice_id'] as String? ?? '',
      type: LedgerListType.fromJson(json['type'] as String?),
    );

Map<String, dynamic> _$$PaymentModelImplToJson(_$PaymentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payment_amount': instance.paymentAmount,
      'client_name': instance.clientName,
      'created_at': instance.createdAt,
      'invoice_id': instance.invoiceId,
      'type': LedgerListType.toJson(instance.type),
    };
