// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ledger_expense_grouped_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LedgerExpenseGroupedModelImpl _$$LedgerExpenseGroupedModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerExpenseGroupedModelImpl(
      dailyExpenses: (json['dailyExpenses'] as List<dynamic>)
          .map((e) =>
              LedgerExpenseDailyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LedgerExpenseGroupedModelImplToJson(
        _$LedgerExpenseGroupedModelImpl instance) =>
    <String, dynamic>{
      'dailyExpenses': instance.dailyExpenses,
    };

_$LedgerExpenseDailyModelImpl _$$LedgerExpenseDailyModelImplFromJson(
        Map<String, dynamic> json) =>
    _$LedgerExpenseDailyModelImpl(
      date: json['date'] as String,
      total: (json['total_expense'] as num?)?.toInt() ?? 0,
      expenses: (json['expenses'] as List<dynamic>)
          .map((e) => ExpenseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$LedgerExpenseDailyModelImplToJson(
        _$LedgerExpenseDailyModelImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'total_expense': instance.total,
      'expenses': instance.expenses,
    };
