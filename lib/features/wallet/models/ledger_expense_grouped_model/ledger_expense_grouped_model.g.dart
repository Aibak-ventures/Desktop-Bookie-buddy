// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_expense_grouped_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerExpenseGroupedModelImpl _$$LedgerExpenseGroupedModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerExpenseGroupedModelImpl(
      date: json['date'] as String,
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LedgerExpenseGroupedModelImplToJson(
        _$LedgerExpenseGroupedModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'expenses': instance.expenses,
    };
