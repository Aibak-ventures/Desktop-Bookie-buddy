import 'dart:developer';

import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';
import 'package:dio/dio.dart';

class ExpenseService {
  final Dio _dio = DioClient.dio;

  // Fetch all expenses
  Future<CustomResponseModel> fetchExpensePagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.ledger.expenses,
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId,
        },
      );
      log(response.realUri.toString());
      // log('Fetch Expenses Response: ${response.realUri.toString()}, Data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Fetch Expenses Error: ${e}', stackTrace: stack);
      rethrow;
    }
  }

  // Add a new expense
  Future<CustomResponseModel> addExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.expenses.expenses,
        data: expense.toJson(),
      );
      log(
        'Add Expense Response: ${response.realUri.toString()}, Data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Add Expense Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Edit an existing expense
  Future<CustomResponseModel> editExpense({
    required ExpenseRequestModel updatedExpense,
  }) async {
    try {
      final response = await _dio.patch(
        '${ApiEndpoints.expenses.expenses}${updatedExpense.expenseId}/',
        data: updatedExpense.toJson(),
      );

      log(
        'Edit Expense Response: ${response.realUri.toString()}, Data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Edit Expense Error: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> deleteExpense({
    required int expenseId,
    required int? variantId,
  }) async {
    try {
      final response = await _dio.delete(
        variantId != null
            ? '${ApiEndpoints.expenses.variantExpenses}$expenseId/'
            : '${ApiEndpoints.expenses.expenses}$expenseId/',
      );

      log(
        'Delete Expense Response: ${response.realUri.toString()}, Data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Delete Expense Error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
