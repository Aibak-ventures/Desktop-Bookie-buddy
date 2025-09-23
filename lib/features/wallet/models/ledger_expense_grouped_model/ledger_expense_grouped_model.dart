import 'package:bookie_buddy_web/core/models/expense_model/expense_model.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ledger_expense_grouped_model.freezed.dart';
part 'ledger_expense_grouped_model.g.dart';

@freezed
class LedgerExpenseGroupedModel with _$LedgerExpenseGroupedModel {
  const factory LedgerExpenseGroupedModel({
    required String date,
    required List<ExpenseModel> expenses,
  }) = _LedgerExpenseGroupedModel;

  factory LedgerExpenseGroupedModel.fromJson(Map<String, dynamic> json) =>
      _$LedgerExpenseGroupedModelFromJson(json);
}
