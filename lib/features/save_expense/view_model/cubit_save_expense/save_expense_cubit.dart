import 'dart:developer' show log;

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/expense_repository.dart';
import 'package:bookie_buddy_web/core/repositories/product_repository.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_expense_cubit.freezed.dart';
part 'save_expense_state.dart';

class SaveExpenseCubit extends Cubit<SaveExpenseState> {
  final ExpenseRepository _repository = getIt.get<ExpenseRepository>();
  final ProductRepository _productRepository = getIt.get<ProductRepository>();
  SaveExpenseCubit() : super(const _Initial());

  Future<void> saveExpense({
    required ExpenseRequestModel expense,
  }) async {
    emit(const _Submitted());

    try {
      // Here if the variant id is null then the expense is a global expense and not a product(Variant) expense
      if (expense.expenseId == null) {
        expense.variantId == null
            ? await _repository.addNewExpense(
                expense: expense,
              )
            : await _productRepository.saveProductExpense(
                expense: expense,
              );
      } else {
        expense.variantId == null
            ? await _repository.updateExpense(
                updatedExpense: expense,
              )
            : await _productRepository.saveProductExpense(
                expense: expense,
              );
      }

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
