// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesRequestModelImpl _$$SalesRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$SalesRequestModelImpl(
  id: (json['id'] as num?)?.toInt(),
  staffId: (json['staff_id'] as num?)?.toInt(),
  clientId: (json['client_id'] as num?)?.toInt(),
  clientName: json['client_name'] as String?,
  clientPhone1: json['client_phone_1'] as String?,
  clientPhone2: json['client_phone_2'] as String?,
  address: json['client_address'] as String?,
  saleDate: json['sale_date'] as String?,
  products: (json['variants'] as List<dynamic>?)
      ?.map((e) => ProductSelectedModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  stockCountDecrease: json['decrease_stock'] as bool?,
  description: json['description'] as String?,
  discountAmount: (json['discount'] as num?)?.toInt(),
  paidAmount: (json['paid_amount'] as num?)?.toInt(),
  paymentMethod:
      $enumDecodeNullable(_$PaymentMethodEnumMap, json['payment_method']) ??
      PaymentMethod.cash,
);

Map<String, dynamic> _$$SalesRequestModelImplToJson(
  _$SalesRequestModelImpl instance,
) => <String, dynamic>{
  if (instance.staffId case final value?) 'staff_id': value,
  if (instance.clientId case final value?) 'client_id': value,
  if (instance.clientName case final value?) 'client_name': value,
  if (instance.clientPhone1 case final value?) 'client_phone_1': value,
  if (instance.clientPhone2 case final value?) 'client_phone_2': value,
  if (instance.address case final value?) 'client_address': value,
  if (instance.saleDate case final value?) 'sale_date': value,
  if (_variantsToJson(instance.products) case final value?) 'variants': value,
  if (instance.stockCountDecrease case final value?) 'decrease_stock': value,
  if (instance.description case final value?) 'description': value,
  if (instance.discountAmount case final value?) 'discount': value,
  if (instance.paidAmount case final value?) 'paid_amount': value,
  if (_paymentMethodToJson(instance.paymentMethod) case final value?)
    'payment_method': value,
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.gPay: 'gPay',
  PaymentMethod.cash: 'cash',
};
