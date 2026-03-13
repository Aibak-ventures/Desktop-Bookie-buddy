import 'dart:developer';

import 'package:bookie_buddy_web/utils/extensions/list_extensions.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staffs_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_search_state.dart';
part 'staff_search_cubit.freezed.dart';

class StaffSearchCubit extends Cubit<StaffSearchState> {
  final GetStaffsUseCase _getStaffs;
  StaffSearchCubit({required GetStaffsUseCase getStaffs})
      : _getStaffs = getStaffs,
        super(const StaffSearchState());

  void selectStaff(StaffModel staff) {
    log('Selected staff: ${staff.name}');
    emit(state.copyWith(selectedStaff: staff));
  }

  void selectStaffById(int staffId) {
    final staff = state.staffs.firstWhereOrNull((e) => e.id == staffId);
    if (staff != null) {
      log('Selected staff by ID: ${staff.id}, ${staff.name}');
      emit(state.copyWith(selectedStaff: staff));
    } else {
      log('No staff found with ID: $staffId');
    }
  }

  void clearSelectedStaff() {
    log('Cleared selected staff: ${state.selectedStaff?.name}');
    emit(state.copyWith(selectedStaff: null));
  }

  void getAllStaffs([int? existingStaffId, StaffModel? existingStaff]) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      int page = 1;
      final List<StaffModel> allStaffs = [];
      String? nextPageUrl;

      do {
        final result = await _getStaffs.call(page: page);
        allStaffs.addAll(result.data);
        nextPageUrl = result.nextPageUrl;
        page++;
      } while (nextPageUrl != null);

      final isContain = allStaffs.any(
        (e) => e.name.trim() == existingStaff?.name.trim(),
      );

      if (!isContain && existingStaff != null) {
        allStaffs.add(existingStaff);
      }

      emit(state.copyWith(staffs: allStaffs, isLoading: false));

      if (existingStaffId != null) {
        selectStaffById(existingStaffId);
      }
    } catch (e, stack) {
      log('Error loading staffs: $e', stackTrace: stack);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
