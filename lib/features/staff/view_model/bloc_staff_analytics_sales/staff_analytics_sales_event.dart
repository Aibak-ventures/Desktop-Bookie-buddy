part of 'staff_analytics_sales_bloc.dart';

@freezed
class StaffAnalyticsSalesEvent with _$StaffAnalyticsSalesEvent {
  const factory StaffAnalyticsSalesEvent.loadSales({
    required int staffId,
    required int month,
    required int year,
  }) = _LoadSales;

  const factory StaffAnalyticsSalesEvent.loadNextPageSales() =
      _LoadNextPageSales;
}
