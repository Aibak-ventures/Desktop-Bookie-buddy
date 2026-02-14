part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  /// Load initial desktop dashboard data using v4 API
  const factory DashboardEvent.loadDashboardData({
    UserModel? activeShop,
    @Default(false) bool useOldState,
  }) = _LoadDashboardData;

  /// Load next page dashboard data and the page number is taken from the nextPageUrl
  const factory DashboardEvent.loadDashboardNextPageData() =
      _LoadDashboardNextPageData;

  const factory DashboardEvent.updateData(
    BookingsModel? updateBooking, {
    @Default(false) bool shouldRefresh,
    @Default(false) bool isDeleted,
  }) = _UpdateData;

  const factory DashboardEvent.loadIfNot() = _LoadIfNot;
}