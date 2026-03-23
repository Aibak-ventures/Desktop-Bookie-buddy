// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SaleModel _$SaleModelFromJson(Map<String, dynamic> json) => _SaleModel(
  id: (json['id'] as num).toInt(),
  shopSaleId: json['shop_sale_id'] as String?,
  clientName: json['client_name'] as String?,
  clientPhone: json['client_phone'],
  totalAmount: (json['total_amount'] as num).toInt(),
  paidAmount: (json['paid_amount'] as num).toInt(),
  discountAmount: (json['discount'] as num).toInt(),
  saleDate: json['sale_date'] as String,
  createdAt: json['created_at'] as String,
  products: json['products'] as String,
  staffColor: json['staff_color'] as String?,
  staffName: json['staff_name'] as String?,
);

Map<String, dynamic> _$SaleModelToJson(_SaleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_sale_id': instance.shopSaleId,
      'client_name': instance.clientName,
      'client_phone': instance.clientPhone,
      'total_amount': instance.totalAmount,
      'paid_amount': instance.paidAmount,
      'discount': instance.discountAmount,
      'sale_date': instance.saleDate,
      'created_at': instance.createdAt,
      'products': instance.products,
      'staff_color': instance.staffColor,
      'staff_name': instance.staffName,
    };
