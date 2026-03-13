part of 'staff_analytics_bloc.dart';

@freezed
class StaffAnalyticsState with _$StaffAnalyticsState {
  // const factory StaffAnalyticsState({StaffAnalyticsModel? data}) = _StaffAnalyticsState;
  const factory StaffAnalyticsState.loading({
    required int year,
    required int month,
  }) = _Loading;
  const factory StaffAnalyticsState.loaded(StaffAnalyticsModel staffReport) =
      _Loaded;
  const factory StaffAnalyticsState.error(
    String message, [
    int? month,
    int? year,
  ]) = _Error;
}
