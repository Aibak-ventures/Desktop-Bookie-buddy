part of 'dashboard_bloc.dart';

@freezed
abstract class DashboardEvent with _$DashboardEvent {
  /// Load initial desktop dashboard data using v4 API
  const factory DashboardEvent.loadDashboardData({
    UserEntity? activeShop,
    @Default(false) bool useOldState,
  }) = _LoadDashboardData;

  /// Load next page dashboard data and the page number is taken from the nextPageUrl
  const factory DashboardEvent.loadDashboardNextPageData() =
      _LoadDashboardNextPageData;

  const factory DashboardEvent.updateData(
    BookingEntity? updateBooking, {
    @Default(false) bool shouldRefresh,
    @Default(false) bool isDeleted,
  }) = _UpdateData;

  const factory DashboardEvent.loadIfNot() = _LoadIfNot;
}