part of 'wallet_pending_bloc.dart';

@freezed
class WalletPendingEvent with _$WalletPendingEvent {
  const factory WalletPendingEvent.loadPending({int? clientId}) = _LoadPending;
  const factory WalletPendingEvent.loadNextPagePending() = _LoadNextPagePending;
}
