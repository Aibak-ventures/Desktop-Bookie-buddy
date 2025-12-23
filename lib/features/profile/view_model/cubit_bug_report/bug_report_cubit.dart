import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookie_buddy_web/core/models/bug_report_model/bug_report_model.dart';
import 'package:bookie_buddy_web/features/profile/repository/bug_report_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bug_report_state.dart';
part 'bug_report_cubit.freezed.dart';

class BugReportCubit extends Cubit<BugReportState> {
  final BugReportRepository _repository;

  BugReportCubit(this._repository) : super(const BugReportState.initial());

  Future<void> submitBugReport(BugReportModel bugReport) async {
    try {
      emit(const BugReportState.loading());
      
      log('Submitting bug report: ${bugReport.title}');
      
      await _repository.submitBugReport(bugReport);
      
      emit(const BugReportState.success('Bug report submitted successfully!'));
      
      // Reset to initial after showing success
      await Future.delayed(const Duration(seconds: 2));
      emit(const BugReportState.initial());
    } catch (e, stack) {
      log('Error in BugReportCubit: $e', stackTrace: stack);
      emit(BugReportState.error(e.toString()));
    }
  }

  void reset() {
    emit(const BugReportState.initial());
  }
}
