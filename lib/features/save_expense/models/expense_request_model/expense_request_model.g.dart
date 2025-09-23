// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseRequestModelImpl _$$ExpenseRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ExpenseRequestModelImpl(
      expenseId: (json['expenseId'] as num?)?.toInt(),
      variantId: (json['product_variant'] as num?)?.toInt(),
      date: json['date'] as String?,
      amount: (json['expense'] as num?)?.toInt(),
      type: json['type'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ExpenseRequestModelImplToJson(
        _$ExpenseRequestModelImpl instance) =>
    <String, dynamic>{
      if (instance.expenseId case final value?) 'expenseId': value,
      if (instance.variantId case final value?) 'product_variant': value,
      if (instance.date case final value?) 'date': value,
      if (instance.amount case final value?) 'expense': value,
      if (instance.type case final value?) 'type': value,
      if (instance.description case final value?) 'description': value,
    };
