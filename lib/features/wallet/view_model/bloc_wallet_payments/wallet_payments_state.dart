part of 'wallet_payments_bloc.dart';

@freezed
class WalletPaymentsState with _$WalletPaymentsState {
  const factory WalletPaymentsState.loading() = _Loading;

  const factory WalletPaymentsState.loaded({
    required List<MonthlyPaymentsModel> paymentHistory,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    int? clientId,
  }) = _Loaded;

  const factory WalletPaymentsState.error(String error) = _Error;
}

extension WalletPaymentsStateExtension on WalletPaymentsState {
  bool get isLoading => this is _Loading;
  bool get isLoaded => this is _Loaded;
  bool get isError => this is _Error;
}
