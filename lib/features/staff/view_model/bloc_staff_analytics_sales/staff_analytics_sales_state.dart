part of 'staff_analytics_sales_bloc.dart';

@freezed
class StaffAnalyticsSalesState with _$StaffAnalyticsSalesState {
  const factory StaffAnalyticsSalesState.loading() = _Loading;
  const factory StaffAnalyticsSalesState.loaded({
    required List<SaleModel> sales,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    required int staffId,
    required int month,
    required int year,
  }) = _Loaded;
  const factory StaffAnalyticsSalesState.error(String message) = _Error;
}
