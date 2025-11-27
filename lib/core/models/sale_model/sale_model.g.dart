// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleModelImpl _$$SaleModelImplFromJson(Map<String, dynamic> json) =>
    _$SaleModelImpl(
      id: (json['id'] as num).toInt(),
      clientName: json['client_name'] as String?,
      clientPhone: json['client_phone'],
      totalAmount: (json['total_amount'] as num).toInt(),
      paidAmount: (json['paid_amount'] as num).toInt(),
      discountAmount: (json['discount'] as num).toInt(),
      saleDate: json['sale_date'] as String,
      createdAt: json['created_at'] as String,
      products: json['products'] as String,
      staffColor: json['staff_color'] as String?,
    );

Map<String, dynamic> _$$SaleModelImplToJson(_$SaleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client_name': instance.clientName,
      'client_phone': instance.clientPhone,
      'total_amount': instance.totalAmount,
      'paid_amount': instance.paidAmount,
      'discount': instance.discountAmount,
      'sale_date': instance.saleDate,
      'created_at': instance.createdAt,
      'products': instance.products,
      'staff_color': instance.staffColor,
    };
