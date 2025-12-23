part of 'bug_report_cubit.dart';

@freezed
class BugReportState with _$BugReportState {
  const factory BugReportState.initial() = _Initial;
  const factory BugReportState.loading() = _Loading;
  const factory BugReportState.success(String message) = _Success;
  const factory BugReportState.error(String message) = _Error;
}
