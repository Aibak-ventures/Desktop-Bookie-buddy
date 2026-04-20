import 'package:bookie_buddy_web/features/accounts/domain/entities/account_request_entity/account_request_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/accounts_summary_entity/accounts_summary_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/create_account_usecase.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/delete_account_usecase.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/get_accounts_summary_usecase.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/update_account_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_summary_state.dart';
part 'accounts_summary_cubit.freezed.dart';

class AccountsSummaryCubit extends Cubit<AccountsSummaryState> {
  final GetAccountsSummaryUseCase _getAccountsSummary;
  final CreateAccountUseCase _createAccount;
  final UpdateAccountUseCase _updateAccount;
  final DeleteAccountUseCase _deleteAccount;

  AccountsSummaryCubit({
    required GetAccountsSummaryUseCase getAccountsSummary,
    required CreateAccountUseCase createAccount,
    required UpdateAccountUseCase updateAccount,
    required DeleteAccountUseCase deleteAccount,
  }) : _getAccountsSummary = getAccountsSummary,
       _createAccount = createAccount,
       _updateAccount = updateAccount,
       _deleteAccount = deleteAccount,
       super(const AccountsSummaryState.loading());

  bool get haveChanges => _haveChanges;
  bool _haveChanges = false;

  void _markChanges() {
    if (!_haveChanges) {
      _haveChanges = true;
    }
  }

  Future<void> loadAccountsSummary() async {
    emit(const AccountsSummaryState.loading());
    try {
      final summary = await _getAccountsSummary();
      emit(AccountsSummaryState.loaded(summary: summary));
    } catch (e) {
      emit(AccountsSummaryState.error(error: e.toString()));
    }
  }

  Future<void> createAccount({required AccountRequestEntity account}) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    emit(s.copyWith(status: AccountsActionStatus.updating));
    try {
      await _createAccount(account: account);
      // Reload summary to get updated balances
      final summary = await _getAccountsSummary();
      emit(
        AccountsSummaryState.loaded(
          summary: summary,
          status: AccountsActionStatus.success,
          message: 'Account created successfully',
        ),
      );
      _markChanges();
    } catch (e) {
      emit(
        s.copyWith(status: AccountsActionStatus.failure, message: e.toString()),
      );
    }
  }

  Future<void> updateAccount({
    required int accountId,
    required AccountRequestEntity account,
  }) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    emit(s.copyWith(status: AccountsActionStatus.updating));
    try {
      await _updateAccount(accountId: accountId, account: account);
      final summary = await _getAccountsSummary();
      emit(
        AccountsSummaryState.loaded(
          summary: summary,
          status: AccountsActionStatus.success,
          message: 'Account updated successfully',
        ),
      );
      _markChanges();
    } catch (e) {
      emit(
        s.copyWith(status: AccountsActionStatus.failure, message: e.toString()),
      );
    }
  }

  Future<void> deleteAccount({required int accountId}) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    emit(s.copyWith(status: AccountsActionStatus.updating));

    try {
      await _deleteAccount(accountId: accountId);
      final summary = await _getAccountsSummary();
      emit(
        AccountsSummaryState.loaded(
          summary: summary,
          status: AccountsActionStatus.success,
          message: 'Account deleted successfully',
        ),
      );
      _markChanges();
    } catch (e) {
      emit(
        s.copyWith(status: AccountsActionStatus.failure, message: e.toString()),
      );
    }
  }

  Future<void> toggleAccountStatus({
    required int accountId,
    required bool isActive,
  }) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    emit(s.copyWith(status: AccountsActionStatus.partiallyUpdating));
    try {
      await _updateAccount(
        accountId: accountId,
        account: AccountRequestEntity(isActive: isActive),
      );
      final summary = await _getAccountsSummary();
      emit(
        AccountsSummaryState.loaded(
          summary: summary,
          status: AccountsActionStatus.success,
          message: isActive ? 'Account activated' : 'Account deactivated',
        ),
      );
      _markChanges();
    } catch (e) {
      emit(
        s.copyWith(status: AccountsActionStatus.failure, message: e.toString()),
      );
    }
  }
}
