part of 'sales_list_bloc.dart';

@freezed
class SalesListEvent with _$SalesListEvent {
  const factory SalesListEvent.getSales({
    String? search,
    String? fromDate,
    String? toDate,
  }) = _GetSales;
  const factory SalesListEvent.getNextPageSales() = _GetNextPageSales;
}
