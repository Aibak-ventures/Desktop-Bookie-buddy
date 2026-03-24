part of 'dashboard_bloc.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState.loading() = _Loading;

  const factory DashboardState.loaded({
    required Map<String, List<BookingEntity>> upcomingGrouped,
    required Map<String, List<BookingEntity>> returnsGrouped,
    required DesktopDashboardCarouselData carouselData,
    required String? nextPageUrl,
    required int currentPage,
    required int totalPages,
    @Default(false) bool isPaginating,
  }) = _Loaded;

  const factory DashboardState.error(String error) = _Error;
}