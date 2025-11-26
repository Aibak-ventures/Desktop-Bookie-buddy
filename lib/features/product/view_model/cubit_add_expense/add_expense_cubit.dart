import 'dart:developer';

import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_expense_state.dart';
part 'add_expense_cubit.freezed.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final ProductRepository _repository;

  AddExpenseCubit({required ProductRepository repository})
      : _repository = repository,
        super(const _Initial());

  Future<void> saveExpense({required ExpenseRequestModel expense}) async {
    emit(const _Submitted());
    try {
      await _repository.saveProductExpense(expense: expense);
      final message = expense.expenseId == null
          ? 'Expense added successfully'
          : 'Expense updated successfully';
      emit(_Success(message));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
