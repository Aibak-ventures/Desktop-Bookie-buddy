part of 'staff_analytics_bloc.dart';

@freezed
class StaffAnalyticsEvent with _$StaffAnalyticsEvent {
  const factory StaffAnalyticsEvent.getStaffAnalytics({
    required int staffId,
    required int year,
    required int month,
  }) = _GetStaffAnalytics;

  const factory StaffAnalyticsEvent.changeMonth({
    required int year,
    required int month,
  }) = _ChangeMonth;
}
