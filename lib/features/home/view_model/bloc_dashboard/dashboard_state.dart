part of 'dashboard_bloc.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.loading() = _Loading;

  const factory DashboardState.loaded({
    required Map<String, List<DashboardListModel>> dataGrouped,
    required CarouselDataModel carouselData,
    required String? nextPageUrl,
    @Default(false) bool isPaginating,
    @Default(false) bool isOngoing,
  }) = _Loaded;

  const factory DashboardState.error(String error) = _Error;
}