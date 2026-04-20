import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_web/features/accounts/domain/usecases/get_accounts_usecase.dart';
import 'package:bookie_buddy_web/utils/extensions/list_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'accounts_state.dart';
part 'accounts_cubit.freezed.dart';

class AccountsCubit extends Cubit<AccountsState> {
  final GetAccountsUseCase _getAccounts;
  AccountsCubit({required GetAccountsUseCase getAccounts})
    : _getAccounts = getAccounts,
      super(const AccountsState.initial());

  Future<void> loadAccounts({bool forceRefresh = false}) async {
    final currentState = state;
    try {
      if (currentState is _Loaded && !forceRefresh) {
        return emit(currentState);
      }
      emit(const AccountsState.loading());
      final accounts = await _getAccounts();
      emit(AccountsState.loaded(accounts));
    } catch (e) {
      emit(AccountsState.error(e.toString()));
    }
  }

  List<AccountEntity> get accounts {
    final currentState = state;
    if (currentState is _Loaded) {
      return currentState.accounts;
    }
    return [];
  }

  AccountEntity? getAccountById(int id) {
    return accounts.firstWhereOrNull((account) => account.id == id);
  }

  void clearAccounts() {
    emit(const AccountsState.initial());
  }
}
