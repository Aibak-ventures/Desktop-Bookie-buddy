// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SaleDetailsModel _$SaleDetailsModelFromJson(Map<String, dynamic> json) =>
    _SaleDetailsModel(
      id: (json['id'] as num).toInt(),
      client: json['client'] == null
          ? null
          : ClientModel.fromJson(json['client'] as Map<String, dynamic>),
      clientPhone: json['client_phone_e164'],
      address: json['address'] as String? ?? '',
      description: json['description'] as String,
      saleDate: json['sale_date'] as String,
      createdAt: json['created_at'] as String? ?? '',
      totalAmount: (json['total_amount_after_discount'] as num).toInt(),
      discountAmount: (json['discount'] as num).toInt(),
      paidAmount: (json['paid_amount'] as num).toInt(),
      productTotal: (json['items_subtotal'] as num?)?.toInt() ?? 0,
      invoiceId: json['shop_sale_id'] as String? ?? '',
      balanceDueAmount: (json['balance_due'] as num).toInt(),
      products: (json['items'] as List<dynamic>)
          .map((e) => ProductSaleInfoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      staffId: (json['staff_id'] as num?)?.toInt(),
      staffName: json['staff_name'] as String?,
      paymentHistory:
          (json['payments'] as List<dynamic>?)
              ?.map(
                (e) => SaleDetailsPaymentHistoryModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
      appliedTaxes: json['tax'] == null
          ? const []
          : AppliedTaxModel.listFromJson(json['tax']),
    );

Map<String, dynamic> _$SaleDetailsModelToJson(_SaleDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'client': instance.client,
      'client_phone_e164': instance.clientPhone,
      'address': instance.address,
      'description': instance.description,
      'sale_date': instance.saleDate,
      'created_at': instance.createdAt,
      'total_amount_after_discount': instance.totalAmount,
      'discount': instance.discountAmount,
      'paid_amount': instance.paidAmount,
      'items_subtotal': instance.productTotal,
      'shop_sale_id': instance.invoiceId,
      'balance_due': instance.balanceDueAmount,
      'items': instance.products,
      'staff_id': instance.staffId,
      'staff_name': instance.staffName,
      'payments': instance.paymentHistory,
      'tax': instance.appliedTaxes,
    };

_SaleDetailsPaymentHistoryModel _$SaleDetailsPaymentHistoryModelFromJson(
  Map<String, dynamic> json,
) => _SaleDetailsPaymentHistoryModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  amount: (json['amount'] as num?)?.toInt() ?? 0,
  accountId: (json['account_id'] as num?)?.toInt(),
  accountName: json['account_name'] as String?,
  date: json['date'] as String? ?? '',
  paymentMethod: $enumDecodeNullable(_$PaymentMethodEnumMap, json['method']),
);

Map<String, dynamic> _$SaleDetailsPaymentHistoryModelToJson(
  _SaleDetailsPaymentHistoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'account_id': instance.accountId,
  'account_name': instance.accountName,
  'date': instance.date,
  'method': PaymentMethod.toJson(instance.paymentMethod),
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.upi: 'upi',
  PaymentMethod.cash: 'cash',
};

_ProductSaleInfoModel _$ProductSaleInfoModelFromJson(
  Map<String, dynamic> json,
) => _ProductSaleInfoModel(
  id: (json['id'] as num).toInt(),
  productId: (json['product_id'] as num).toInt(),
  variantId: (json['variant_id'] as num).toInt(),
  name: json['product_name'] as String,
  variantAttribute: json['variant'] as String?,
  quantity: (json['quantity'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  subtotal: (json['subtotal'] as num).toInt(),
  image: json['image'] as String?,
  thumbnailImage: json['thumbnail'] as String?,
  color: json['color'] as String?,
  category: json['category'] as String?,
  model: json['model'] as String?,
  mainServiceType: MainServiceType.fromString(
    json['main_category_name'] as String?,
  ),
  fabricLength: (json['fabric_length'] as num?)?.toDouble() ?? 0.0,
  attributes: json['attributes'] == null
      ? const ProductAttributesModel()
      : ProductAttributesModel.fromJson(
          json['attributes'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ProductSaleInfoModelToJson(
  _ProductSaleInfoModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'product_id': instance.productId,
  'variant_id': instance.variantId,
  'product_name': instance.name,
  'variant': instance.variantAttribute,
  'quantity': instance.quantity,
  'price': instance.price,
  'subtotal': instance.subtotal,
  'image': instance.image,
  'thumbnail': instance.thumbnailImage,
  'color': instance.color,
  'category': instance.category,
  'model': instance.model,
  'main_category_name': MainServiceType.toJson(instance.mainServiceType),
  'fabric_length': instance.fabricLength,
  'attributes': instance.attributes,
};
