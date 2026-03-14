import 'package:bookie_buddy_web/features/profile/data/datasources/bug_report_remote_datasource.dart';
import 'package:bookie_buddy_web/features/profile/domain/models/bug_report_model/bug_report_model.dart';
import 'package:bookie_buddy_web/features/profile/domain/repositories/i_bug_report_repository.dart';

class BugReportRepositoryImpl implements IBugReportRepository {
  final BugReportRemoteDatasource _remoteDatasource;

  BugReportRepositoryImpl(this._remoteDatasource);

  @override
  Future<void> submitBugReport(BugReportModel bugReport) async {
    return _remoteDatasource.submitBugReport(bugReport);
  }
}
