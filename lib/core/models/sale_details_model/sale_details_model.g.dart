// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SaleDetailsModelImpl _$$SaleDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SaleDetailsModelImpl(
      id: (json['id'] as num).toInt(),
      client: json['client'] == null
          ? null
          : ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      clientPhone: json['client_phone'],
      address: json['address'] as String? ?? '',
      description: json['description'] as String,
      saleDate: json['sale_date'] as String,
      createdAt: json['created_at'] as String? ?? '',
      totalAmount: (json['total_amount'] as num).toInt(),
      discountAmount: (json['discount'] as num).toInt(),
      paidAmount: (json['paid_amount'] as num).toInt(),
      invoiceId: json['shop_sale_id'] as String? ?? '',
      balanceDueAmount: (json['balance_due'] as num).toInt(),
      products: (json['items'] as List<dynamic>)
          .map((e) => ProductSaleInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethod: _paymentMethodReadValue(json, 'method') == null
          ? PaymentMethod.cash
          : PaymentMethod.fromJson(
              _paymentMethodReadValue(json, 'method') as String?),
      staffId: (json['staff_id'] as num?)?.toInt(),
      staffName: json['staff_name'] as String?,
    );

Map<String, dynamic> _$$SaleDetailsModelImplToJson(
        _$SaleDetailsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'client_phone': instance.clientPhone,
      'address': instance.address,
      'description': instance.description,
      'sale_date': instance.saleDate,
      'created_at': instance.createdAt,
      'total_amount': instance.totalAmount,
      'discount': instance.discountAmount,
      'paid_amount': instance.paidAmount,
      'shop_sale_id': instance.invoiceId,
      'balance_due': instance.balanceDueAmount,
      'items': instance.products,
      'method': instance.paymentMethod,
      'staff_id': instance.staffId,
      'staff_name': instance.staffName,
    };

_$ProductSaleInfoModelImpl _$$ProductSaleInfoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductSaleInfoModelImpl(
      id: (json['id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      variantId: (json['variant_id'] as num).toInt(),
      name: json['product_name'] as String,
      variantAttribute: json['variant'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      subtotal: (json['subtotal'] as num).toInt(),
      image: json['thumbnail'] as String?,
      color: json['color'] as String?,
      category: json['category'] as String?,
      model: json['model'] as String?,
      mainServiceType:
          MainServiceType.fromString(json['main_category_name'] as String?),
    );

Map<String, dynamic> _$$ProductSaleInfoModelImplToJson(
        _$ProductSaleInfoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'variant_id': instance.variantId,
      'product_name': instance.name,
      'variant': instance.variantAttribute,
      'quantity': instance.quantity,
      'price': instance.price,
      'subtotal': instance.subtotal,
      'thumbnail': instance.image,
      'color': instance.color,
      'category': instance.category,
      'model': instance.model,
      'main_category_name': _$MainServiceTypeEnumMap[instance.mainServiceType],
    };

const _$MainServiceTypeEnumMap = {
  MainServiceType.dress: 'dress',
  MainServiceType.vehicle: 'vehicle',
  MainServiceType.equipment: 'equipment',
  MainServiceType.gadgets: 'gadgets',
  MainServiceType.material: 'material',
  MainServiceType.room: 'room',
  MainServiceType.costume: 'costume',
  MainServiceType.jewellery: 'jewellery',
  MainServiceType.others: 'others',
};
