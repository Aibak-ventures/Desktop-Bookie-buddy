import 'package:freezed_annotation/freezed_annotation.dart';

part 'bug_report_model.freezed.dart';
part 'bug_report_model.g.dart';

@freezed
class BugReportModel with _$BugReportModel {
  const factory BugReportModel({
    required String title,
    required String description,
    @Default({}) Map<String, dynamic> moreDetails,
    String? image1,
    String? image2,
  }) = _BugReportModel;

  factory BugReportModel.fromJson(Map<String, dynamic> json) =>
      _$BugReportModelFromJson(json);
}
