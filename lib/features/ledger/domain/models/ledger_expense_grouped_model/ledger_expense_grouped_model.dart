import 'dart:developer';

import 'package:bookie_buddy_web/core/models/expense_model/expense_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_expense_grouped_model.freezed.dart';
part 'ledger_expense_grouped_model.g.dart';

@freezed
class LedgerExpenseGroupedModel with _$LedgerExpenseGroupedModel {
  const factory LedgerExpenseGroupedModel({
    required List<LedgerExpenseDailyModel> dailyExpenses,
  }) = _LedgerExpenseGroupedModel;

  factory LedgerExpenseGroupedModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerExpenseGroupedModelFromJson(json);

  factory LedgerExpenseGroupedModel.fromCustomJson(Map<String, dynamic> json) {
    final daily = <LedgerExpenseDailyModel>[];

    for (final monthEntry in json.entries) {
      final monthMap = monthEntry.value;
      if (monthMap is! Map<String, dynamic>) continue; // Skip malformed month

      for (final dayEntry in monthMap.entries) {
        final rawDay = dayEntry.value;
        if (rawDay is! Map<String, dynamic>) continue; // Skip malformed day

        final expensesRaw = rawDay['items'];
        final expenses = <ExpenseModel>[];
        if (expensesRaw is List) {
          for (final e in expensesRaw) {
            if (e is Map<String, dynamic>) {
              try {
                expenses.add(ExpenseModel.fromJson(e));
              } catch (error, stack) {
                // Ignore malformed expense entries silently
                log('Error ledger expense grouped model: Invalid expense data: $e',
                    error: error, stackTrace: stack);
              }
            }
          }
        }

        // Get total from JSON if provided, else compute sum of expense field.
        final total = (rawDay['total_expense'] as num?)?.toInt() ?? 0;
        log('Parsed LedgerExpenseDailyModel: ${dayEntry.key}, Total: $total, Expenses: ${expenses.length}');
        daily.add(
          LedgerExpenseDailyModel(
            date: dayEntry.key.toString(),
            total: total,
            expenses: expenses,
          ),
        );
      }
    }

    return LedgerExpenseGroupedModel(dailyExpenses: daily);
  }
}

@freezed
class LedgerExpenseDailyModel with _$LedgerExpenseDailyModel {
  const factory LedgerExpenseDailyModel({
    required String date,
    @JsonKey(name: 'total_expense', defaultValue: 0) required int total,
    required List<ExpenseModel> expenses,
  }) = _LedgerExpenseDailyModel;

  factory LedgerExpenseDailyModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerExpenseDailyModelFromJson(json);
}
