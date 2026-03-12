import 'dart:developer';

import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/expense/domain/models/expense_request_model/expense_request_model.dart';
import 'package:dio/dio.dart';

class ExpenseRemoteDataSource {
  final Dio _dio = DioClient.dio;

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

  Future<CustomResponseModel> addOrUpdateProductExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      final bool isAdding = expense.expenseId == null;
      final String url =
          '${ApiEndpoints.expenses.variantExpenses}${expense.expenseId == null ? '' : '${expense.expenseId}/'}';

      final body = expense.toJson();

      final res = isAdding
          ? await _dio.post(url, data: body)
          : await _dio.patch(url, data: body);

      log(
        'add or update expense status: ${res.realUri.toString()}, ${res.statusCode}, data: ${res.data}',
      );
      return CustomResponseModel.fromJson(res.data);
    } catch (e, stack) {
      log('add or update expense error: $e', stackTrace: stack);
      rethrow;
    }
  }
}
