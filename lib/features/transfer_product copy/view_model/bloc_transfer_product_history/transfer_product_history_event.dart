part of 'transfer_product_history_bloc.dart';

@freezed
class TransferProductHistoryEvent with _$TransferProductHistoryEvent {
  const factory TransferProductHistoryEvent.loadTransferHistory() =
      _LoadTransferHistory;
  const factory TransferProductHistoryEvent.loadNextPageTransferHistory() =
      _LoadNextPageTransferHistory;
}
