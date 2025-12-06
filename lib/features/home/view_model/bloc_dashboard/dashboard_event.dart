part of 'dashboard_bloc.dart';

@freezed
class DashboardEvent with _$DashboardEvent {
  /// Load initial dashboard data
  const factory DashboardEvent.loadDashboardData({
    @Default(false) bool isOngoing,
    @Default(false) bool useOldState,
  }) = _LoadDashboardData;

  /// Load next page dashboard data and the page number is taken from the nextPageUrl
  const factory DashboardEvent.loadDashboardNextPageData() =
      _LoadDashboardNextPageData;

  const factory DashboardEvent.updateData(
    DashboardListModel? updateData, {
    @Default(false) bool shouldRefresh,
    @Default(false) bool isDeleted,
  }) = _UpdateData;

  /// Search by query
  // const factory DashboardEvent.search(String query) = _Search;

  const factory DashboardEvent.loadIfNot() = _LoadIfNot;
}