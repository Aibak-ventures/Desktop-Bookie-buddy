import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/expense_model/expense_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/save_expense/models/expense_request_model/expense_request_model.dart';
import 'package:dio/dio.dart';

class ExpenseService {
  final Dio _dio = DioClient.dio;

  // Fetch all expenses
  Future<PaginationModel<ExpenseModel>> fetchExpensePagination({
    required int page,
    int? clientId,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v1/expenses/wallet/expenses/',
        queryParameters: {
          'page': page,
          if (clientId != null) 'client_id': clientId,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data["results"];
        final data = results.map((e) => ExpenseModel.fromJson(e)).toList();

        return PaginationModel<ExpenseModel>(
          data: data,
          totalData: response.data["count"],
          nextPageUrl: response.data["next"],
        );
      } else {
        throw 'Failed to fetch expenses';
      }
    } on DioException catch (e) {
      log("Fetch Expenses Error: ${e.message}");
      throw 'Error fetching expenses: ${e.message}';
    }
  }

  // Add a new expense
  Future<void> addExpense({
    required ExpenseRequestModel expense,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/expenses/expenses/',
        data: expense.toJson(),
      );

      if (response.statusCode != 201) {
        throw 'Failed to add expense';
      }
    } on DioException catch (e) {
      log("Add Expense Error: ${e.message}");
      throw 'Error adding expense: ${e.message}';
    }
  }

  // Edit an existing expense
  Future<void> editExpense({
    required ExpenseRequestModel updatedExpense,
  }) async {
    try {
      final response = await _dio.patch(
        '/api/v1/expenses/expenses/${updatedExpense.expenseId}/',
        data: updatedExpense.toJson(),
      );

      final data = response.data;

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 404) {
        throw data['error'] ?? 'Expense not found';
      } else {
        throw data['error'] ?? 'Failed to edit expense';
      }
    } on DioException catch (e, stack) {
      log("Edit Expense Error: ${e.message}", stackTrace: stack);
      throw 'Error editing expense: ${e.message}';
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw 'Error editing expense: $e';
    }
  }

  Future<void> deleteExpense({
    required int expenseId,
    required int? variantId,
  }) async {
    try {
      final response = await _dio.delete(
        variantId != null
            ? '/api/v1/expenses/variant-expenses/$expenseId/'
            : '/api/v1/expenses/expenses/$expenseId/',
      );

      if (response.statusCode != 204) {
        throw response.data['error'] ??
            response.data['message'] ??
            'Failed to delete expense';
      }
    } on DioException catch (e) {
      log("Delete Expense Error: ${e.message}");
      throw 'Error deleting expense: ${e.message}';
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
