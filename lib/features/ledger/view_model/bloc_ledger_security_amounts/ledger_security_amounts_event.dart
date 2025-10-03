part of 'ledger_security_amounts_bloc.dart';

@freezed
class LedgerSecurityAmountsEvent with _$LedgerSecurityAmountsEvent {
  const factory LedgerSecurityAmountsEvent.loadSecurityAmounts(
      {int? clientId}) = _LoadSecurityAmounts;
  const factory LedgerSecurityAmountsEvent.loadNextPageSecurityAmounts() =
      _LoadNextPageSecurityAmounts;
}
