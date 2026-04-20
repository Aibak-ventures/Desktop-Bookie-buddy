part of 'accounts_cubit.dart';

@freezed
class AccountsState with _$AccountsState {
  const factory AccountsState.initial() = _Initial;
  const factory AccountsState.loading() = _Loading;
  const factory AccountsState.loaded(List<AccountEntity> accounts) = _Loaded;
  const factory AccountsState.error(String message) = _Error;
}
