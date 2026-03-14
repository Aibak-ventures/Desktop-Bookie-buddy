import 'package:bookie_buddy_web/features/profile/domain/models/bug_report_model/bug_report_model.dart';

abstract class IBugReportRepository {
  Future<void> submitBugReport(BugReportModel bugReport);
}
