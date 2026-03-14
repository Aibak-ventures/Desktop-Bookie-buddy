import 'package:bookie_buddy_web/features/profile/domain/models/bug_report_model/bug_report_model.dart';
import 'package:bookie_buddy_web/features/profile/domain/repositories/i_bug_report_repository.dart';

class SubmitBugReportUseCase {
  final IBugReportRepository _repository;

  SubmitBugReportUseCase(this._repository);

  Future<void> call(BugReportModel bugReport) async {
    return _repository.submitBugReport(bugReport);
  }
}
