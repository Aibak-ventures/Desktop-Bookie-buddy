part of 'all_sales_bloc.dart';

@freezed
abstract class AllSalesEvent with _$AllSalesEvent {
  const factory AllSalesEvent.loadSales({
    int? page,
    String? searchQuery,
    String? fromDate,
    String? toDate,
  }) = _LoadSales;
  const factory AllSalesEvent.loadMoreSales() = _LoadMoreSales;
}
