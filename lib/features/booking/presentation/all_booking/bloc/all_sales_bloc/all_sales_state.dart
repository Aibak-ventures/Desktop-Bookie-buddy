part of 'all_sales_bloc.dart';

@freezed
class AllSalesState with _$AllSalesState {
  const factory AllSalesState.loading() = _Loading;
  const factory AllSalesState.loaded({
    required List<SaleModel> sales,
    String? nextPageUrl,
    String? searchQuery,
    @Default(false) bool isPaginating,
    String? fromDate,
    String? toDate,
  }) = _Loaded;
  const factory AllSalesState.error(String message) = _Error;
}
