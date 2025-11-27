part of 'sales_list_bloc.dart';

@freezed
class SalesListState with _$SalesListState {
  const factory SalesListState.loading() = _Loading;
  const factory SalesListState.loaded({
    required List<SaleModel> sales,
    String? nextPageUrl,
    @Default(false) bool isPaginating,
    String? search,
    String? fromDate,
    String? toDate,
  }) = _Loaded;
  const factory SalesListState.error(String error) = _Error;
}
