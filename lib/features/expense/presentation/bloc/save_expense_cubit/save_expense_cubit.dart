import 'dart:developer' show log;

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/features/expense/domain/models/expense_request_model/expense_request_model.dart';
import 'package:bookie_buddy_web/features/expense/domain/usecases/save_expense_usecase.dart';
import 'package:bookie_buddy_web/features/expense/domain/usecases/save_product_expense_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_expense_cubit.freezed.dart';
part 'save_expense_state.dart';

class SaveExpenseCubit extends Cubit<SaveExpenseState> {
  final SaveExpenseUsecase _saveExpenseUsecase;
  final SaveProductExpenseUsecase _saveProductExpenseUsecase;
  SaveExpenseCubit({
    required SaveExpenseUsecase saveExpenseUsecase,
    required SaveProductExpenseUsecase saveProductExpenseUsecase,
  })  : _saveExpenseUsecase = saveExpenseUsecase,
        _saveProductExpenseUsecase = saveProductExpenseUsecase,
        super(const _Initial());

  Future<void> saveExpense({
    required ExpenseRequestModel expense,
  }) async {
    emit(const _Submitted());

    try {
      // if variant id is null then it is a global expense else it is a product expense
      // if expense id is null then it is a new expense else it is an existing expense
      expense.variantId == null
          ? await _saveExpenseUsecase.call(expense: expense)
          : await _saveProductExpenseUsecase.call(expense: expense);

      emit(
        _Success(
          expense.expenseId == null
              ? '${expense.variantId == null ? 'Expense' : 'Product expense'} added successfully'
              : '${expense.variantId == null ? 'Expense' : 'Product expense'} updated successfully',
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
