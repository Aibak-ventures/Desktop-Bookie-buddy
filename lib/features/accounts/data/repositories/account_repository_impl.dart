import 'dart:developer';

import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/accounts/data/datasources/account_remote_datasource.dart';
import 'package:bookie_buddy_web/features/accounts/data/models/account_model/account_model.dart';
import 'package:bookie_buddy_web/features/accounts/data/models/account_request_model/account_request_model.dart';
import 'package:bookie_buddy_web/features/accounts/data/models/accounts_summary_model/accounts_summary_model.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_request_entity/account_request_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/accounts_summary_entity/accounts_summary_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/repositories/i_account_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';

class AccountRepositoryImpl implements IAccountRepository {
  final AccountRemoteDatasource _datasource;

  AccountRepositoryImpl(this._datasource);

  @override
  Future<PaginationModel<AccountEntity>> getAccounts({
    int page = 1,
    bool isActiveOnly = true,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.getAccounts(page: page, isActiveOnly: isActiveOnly),
      );
      if (response.status.isSuccess) {
        return PaginationModel.fromJson(
          response.data as Map<String, dynamic>,
          (data) =>
              AccountModel.fromJson(data as Map<String, dynamic>).toEntity(),
        );
        // return;
      }
      log('Error fetching accounts: ${response.devMessage}');
      throw response.message ?? 'Error fetching accounts';
    } catch (e, stack) {
      log('Error fetching accounts: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<AccountsSummaryEntity> getAccountsSummary() async {
    try {
      final response = await safeApiCall(
        () => _datasource.getAccountsSummary(),
      );
      if (response.status.isSuccess) {
        return AccountsSummaryModel.fromJson(
          response.data as Map<String, dynamic>,
        ).toEntity();
      }
      log('Error fetching accounts summary: ${response.devMessage}');
      throw response.message ?? 'Error fetching accounts summary';
    } catch (e, stack) {
      log('Error fetching accounts summary: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> createAccount({required AccountRequestEntity account}) async {
    try {
      final response = await safeApiCall(
        () => _datasource.createAccount(
          account: AccountRequestModel.fromEntity(account),
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error creating account: ${response.devMessage}');
      throw response.message ?? 'Error creating account';
    } catch (e, stack) {
      log('Error creating account: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> updateAccount({
    required int accountId,
    required AccountRequestEntity account,
  }) async {
    try {
      final response = await safeApiCall(
        () => _datasource.updateAccount(
          accountId: accountId,
          account: AccountRequestModel.fromEntity(account),
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error updating account: ${response.devMessage}');
      throw response.message ?? 'Error updating account';
    } catch (e, stack) {
      log('Error updating account: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> deleteAccount({required int accountId}) async {
    try {
      final response = await safeApiCall(
        () => _datasource.deleteAccount(accountId: accountId),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error deleting account: ${response.devMessage}');
      throw response.message ?? 'Error deleting account';
    } catch (e, stack) {
      log('Error deleting account: $e', stackTrace: stack);
      rethrow;
    }
  }
}
