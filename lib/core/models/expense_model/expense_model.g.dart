// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseModelImpl _$$ExpenseModelImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseModelImpl(
      id: (json['id'] as num).toInt(),
      serviceId: (json['service_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      variantId: (json['variant_id'] as num?)?.toInt(),
      date: json['created_at'] as String? ?? '',
      userName: json['user'] as String? ?? 'Unknown',
      expense: (json['expense'] as num?)?.toInt() ?? 0,
      type: json['type'] as String?,
      description: json['description'] as String?,
      isDeleted: json['is_deleted'] as bool? ?? false,
      paymentMethod: json['payment_method'] as String?,
    );

Map<String, dynamic> _$$ExpenseModelImplToJson(_$ExpenseModelImpl instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'product_id': instance.productId,
      'variant_id': instance.variantId,
      'created_at': instance.date,
      'user': instance.userName,
      'expense': instance.expense,
      'type': instance.type,
      'description': instance.description,
      'is_deleted': instance.isDeleted,
      'payment_method': instance.paymentMethod,
    };
