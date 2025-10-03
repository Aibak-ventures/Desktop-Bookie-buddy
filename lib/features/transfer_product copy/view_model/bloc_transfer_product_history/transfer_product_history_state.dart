part of 'transfer_product_history_bloc.dart';

@freezed
class TransferProductHistoryState with _$TransferProductHistoryState {
  const factory TransferProductHistoryState.loading() = _Loading;
  const factory TransferProductHistoryState.loaded({
    required List<TransferProductHistoryGroupedModel> transferProductsHistory,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    required int shopId,
  }) = _Loaded;
  const factory TransferProductHistoryState.error(String error) = _Error;
}
