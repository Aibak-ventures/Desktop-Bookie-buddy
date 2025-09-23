part of 'wallet_pending_bloc.dart';

@freezed
class WalletPendingState with _$WalletPendingState {
  const factory WalletPendingState.loading() = _Loading;

  const factory WalletPendingState.loaded({
    required List<LedgerPendingsGroupedModel> walletPending,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    int? clientId,
  }) = _Loaded;

  const factory WalletPendingState.error(String error) = _Error;
}
