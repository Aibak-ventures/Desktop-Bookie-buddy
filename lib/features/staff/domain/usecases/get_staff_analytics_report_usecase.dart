import 'package:bookie_buddy_web/features/staff/domain/models/staff_analytics_model/staff_analytics_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';

class GetStaffAnalyticsReportUseCase {
  final IStaffRepository _repository;

  GetStaffAnalyticsReportUseCase(this._repository);

  Future<StaffAnalyticsModel> call({
    required int staffId,
    required int year,
    required int month,
  }) async {
    return await _repository.getStaffAnalyticsReport(
      staffId: staffId,
      year: year,
      month: month,
    );
  }
}
