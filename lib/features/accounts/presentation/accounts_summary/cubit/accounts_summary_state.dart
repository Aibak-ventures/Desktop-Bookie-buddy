part of 'accounts_summary_cubit.dart';

enum AccountsActionStatus {
  idle,
  updating,
  partiallyUpdating,
  success,
  failure;

  bool get isUpdating => this == updating;
  bool get isPartiallyUpdating => this == partiallyUpdating;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

@freezed
class AccountsSummaryState with _$AccountsSummaryState {
  const factory AccountsSummaryState.loading() = _Loading;
  const factory AccountsSummaryState.loaded({
    required AccountsSummaryEntity summary,
    @Default(AccountsActionStatus.idle) AccountsActionStatus status,
    String? message,
  }) = _Loaded;
  const factory AccountsSummaryState.error({required String error}) = _Error;
}
