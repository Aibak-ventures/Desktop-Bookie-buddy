part of 'all_sales_bloc.dart';

@freezed
class AllSalesEvent with _$AllSalesEvent {
  const factory AllSalesEvent.loadSales({
    int? page,
    String? searchQuery,
  }) = _LoadSales;
  const factory AllSalesEvent.loadMoreSales() = _LoadMoreSales;
}
