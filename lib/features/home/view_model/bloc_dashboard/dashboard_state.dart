part of 'dashboard_bloc.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.loading() = _Loading;

  const factory DashboardState.loaded({
    required Map<String, List<BookingsModel>> bookingsGrouped,
    required CarouselDataModel carouselData,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
  }) = _Loaded;

  const factory DashboardState.error(Failure error) = _Error;
}
