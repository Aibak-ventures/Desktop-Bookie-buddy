import 'dart:developer';

import 'package:bookie_buddy_web/core/common/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/constants/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/features/accounts/data/models/account_request_model/account_request_model.dart';
import 'package:dio/dio.dart';

class AccountRemoteDatasource {
  final Dio _dio;

  const AccountRemoteDatasource(this._dio);

  /// Fetch all accounts
  Future<CustomResponseModel> getAccounts({
    required int page,
    required bool isActiveOnly,
  }) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.accounts.accounts,
        queryParameters: {'is_active': isActiveOnly, 'page': page},
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching accounts: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Fetch accounts summary (total balance + per-account balances)
  Future<CustomResponseModel> getAccountsSummary() async {
    try {
      final response = await _dio.get(ApiEndpoints.accounts.summary);

      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching accounts summary: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Create a new account
  Future<CustomResponseModel> createAccount({
    required AccountRequestModel account,
  }) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.accounts.accounts,
        data: account.toJson(),
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error creating account: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Update an existing account
  Future<CustomResponseModel> updateAccount({
    required int accountId,
    required AccountRequestModel account,
  }) async {
    try {
      final response = await _dio.patch(
        ApiEndpoints.accounts.accountById(accountId),
        data: account.toJson(),
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating account: $e', stackTrace: stack);
      rethrow;
    }
  }

  /// Delete an account
  Future<CustomResponseModel> deleteAccount({required int accountId}) async {
    try {
      final response = await _dio.delete(
        ApiEndpoints.accounts.accountById(accountId),
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error deleting account: $e', stackTrace: stack);
      rethrow;
    }
  }
}
