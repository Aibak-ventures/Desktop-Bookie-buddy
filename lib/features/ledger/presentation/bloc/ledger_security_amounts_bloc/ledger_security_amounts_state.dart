part of 'ledger_security_amounts_bloc.dart';

@freezed
class LedgerSecurityAmountsState with _$LedgerSecurityAmountsState {
  const factory LedgerSecurityAmountsState.loading() = _Loading;

  const factory LedgerSecurityAmountsState.loaded({
    required List<LedgerSecurityAmountDailyModel> ledgerSecurityAmounts,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    int? clientId,
    @Default(false) bool isFirstFetch,
  }) = _Loaded;

  const factory LedgerSecurityAmountsState.error(String error) = _Error;
}
