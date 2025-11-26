part of 'wallet_payments_bloc.dart';

@freezed
class WalletPaymentsEvent with _$WalletPaymentsEvent {
  const factory WalletPaymentsEvent.loadPayments({
    int? clientId,
  }) = _LoadPayments;
  const factory WalletPaymentsEvent.loadNextPagePayments() =
      _LoadNextPagePayments;
}
