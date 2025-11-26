part of 'ledger_sales_bloc.dart';

@freezed
class LedgerSalesState with _$LedgerSalesState {
  const factory LedgerSalesState.loading() = _Loading;
  const factory LedgerSalesState.loaded({
    required List<LedgerSaleDailyModel> ledgerSales,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    required int? clientId,
    required bool isFirstFetch,
  }) = _Loaded;
  const factory LedgerSalesState.error(String message) = _Error;
}

extension LedgerSalesStateExtension on LedgerSalesState {
  bool get isLoading => this is _Loading;
  bool get isLoaded => this is _Loaded;
  bool get isError => this is _Error;
}
