import 'package:bookie_buddy_web/core/repositories/staff_repository.dart';
import 'package:bookie_buddy_web/features/staff/staff_analytics_model/staff_analytics_model.dart';
// import 'package:bookie_buddy_web/features/staff/models/staff_analytics_model/staff_analytics_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_analytics_event.dart';
part 'staff_analytics_state.dart';
part 'staff_analytics_bloc.freezed.dart';

class StaffAnalyticsBloc
    extends Bloc<StaffAnalyticsEvent, StaffAnalyticsState> {
  final StaffRepository _repository;
  StaffAnalyticsBloc({required StaffRepository repository})
      : _repository = repository,
        super(
          StaffAnalyticsState.loading(
            month: DateTime.now().month,
            year: DateTime.now().year,
          ),
        ) {
    on<_GetStaffAnalytics>(_onGetAnalytics);
    on<_ChangeMonth>(_onMonthChanged);
  }

  Future<void> _onGetAnalytics(
    _GetStaffAnalytics event,
    Emitter<StaffAnalyticsState> emit,
  ) async {
    final oldState = state is _Loaded ? state as _Loaded : null;

    if (state is! _Loading)
      emit(_Loading(month: event.month, year: event.year));
    try {
      final staffReport = await _repository.getStaffAnalyticsReport(
        staffId: event.staffId,
        year: event.year,
        month: event.month,
      );

      emit(_Loaded(staffReport));
    } catch (e) {
      if (oldState != null) {
        emit(
          _Error(
            e.toString(),
            oldState.staffReport.month.number,
            oldState.staffReport.year,
          ),
        );
        return;
      }
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onMonthChanged(
    _ChangeMonth event,
    Emitter<StaffAnalyticsState> emit,
  ) async {
    // Re-fetch with new month
    // You can store staffId in bloc if needed
  }
}
