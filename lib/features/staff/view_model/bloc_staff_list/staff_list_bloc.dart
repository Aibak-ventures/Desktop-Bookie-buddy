import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/models/staff_request_model/staff_request_model.dart';
import 'package:bookie_buddy_web/core/repositories/staff_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_list_bloc.freezed.dart';
part 'staff_list_event.dart';
part 'staff_list_state.dart';

class StaffListBloc extends Bloc<StaffListEvent, StaffListState> {
  final StaffRepository _repository;

  StaffListBloc({required StaffRepository repository})
    : _repository = repository,
      super(const StaffListState.loading()) {
    on<_LoadStaffs>(_onLoadStaffs);
    on<_LoadNextPageStaffs>(_onLoadNextPageStaffs);
    on<_AddStaff>(_onAddStaff);
    on<_EditStaff>(_onEditStaff);
    on<_DeleteStaff>(_onDeleteStaff);
  }

  Future<void> _onLoadStaffs(
    _LoadStaffs event,
    Emitter<StaffListState> emit,
  ) async {
    if (state is! _Loading) emit(const StaffListState.loading());

    try {
      final result = await _repository.getStaffs();

      emit(
        StaffListState.loaded(
          staffs: result.data,
          nextPageUrl: result.nextPageUrl,
        ),
      );
    } catch (e, stack) {
      log('Error loading staffs: $e', stackTrace: stack);
      emit(StaffListState.error(e.toString()));
    }
  }

  FutureOr<void> _onLoadNextPageStaffs(
    _LoadNextPageStaffs event,
    Emitter<StaffListState> emit,
  ) async {
    try {
      if (state is! _Loaded) return;
      final s = state as _Loaded;
      if (s.nextPageUrl == null || s.isPaginating) return;

      emit(s.copyWith(isPaginating: true));
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);

      final result = await _repository.getStaffs(page: nextPage);

      emit(
        s.copyWith(
          staffs: [...s.staffs, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e, stack) {
      log('Error loading next page of staffs: $e', stackTrace: stack);
      if (state is _Loaded) {
        final s = state as _Loaded;
        emit(s.copyWith(isPaginating: false));
      } else {
        emit(StaffListState.error(e.toString()));
      }
    }
  }

  FutureOr<void> _onAddStaff(
    _AddStaff event,
    Emitter<StaffListState> emit,
  ) async {
    try {
      if (state is! _Loaded) return;
      final s = state as _Loaded;

      emit(s.copyWith(status: StaffListStatus.updating));

      final newStaff = await _repository.addStaff(event.staff);

      final updatedStaffs = [newStaff, ...s.staffs];

      emit(
        s.copyWith(
          staffs: updatedStaffs,
          isPaginating: false,
          status: StaffListStatus.success,
          message: 'Staff added successfully',
        ),
      );
    } catch (e, stack) {
      log('Error adding staff: $e', stackTrace: stack);
      if (state is _Loaded) {
        final s = state as _Loaded;
        emit(
          s.copyWith(
            isPaginating: false,
            status: StaffListStatus.failure,
            message: e.toString(),
          ),
        );
      } else {
        emit(StaffListState.error(e.toString()));
      }
    }
  }

  FutureOr<void> _onEditStaff(
    _EditStaff event,
    Emitter<StaffListState> emit,
  ) async {
    try {
      if (state is! _Loaded) return;
      final s = state as _Loaded;

      emit(s.copyWith(status: StaffListStatus.updating));

      final newStaff = await _repository.editStaff(event.staff);
      final updatedStaffs = s.staffs.map((staff) {
        if (staff.id == newStaff.id) {
          return newStaff;
        }
        return staff;
      }).toList();

      emit(
        s.copyWith(
          staffs: updatedStaffs,
          isPaginating: false,
          status: StaffListStatus.success,
          message: 'Staff updated successfully',
        ),
      );
    } catch (e, stack) {
      log('Error updating staff: $e', stackTrace: stack);
      if (state is _Loaded) {
        final s = state as _Loaded;
        emit(
          s.copyWith(
            isPaginating: false,
            status: StaffListStatus.failure,
            message: e.toString(),
          ),
        );
      } else {
        emit(StaffListState.error(e.toString()));
      }
    }
  }

  FutureOr<void> _onDeleteStaff(
    _DeleteStaff event,
    Emitter<StaffListState> emit,
  ) async {
    try {
      if (state is! _Loaded) return;
      final s = state as _Loaded;

      emit(s.copyWith(status: StaffListStatus.updating));

      await _repository.deleteStaff(event.staffId);

      final updatedStaffs = s.staffs
          .where((staff) => staff.id != event.staffId)
          .toList();

      emit(
        s.copyWith(
          staffs: updatedStaffs,
          isPaginating: false,
          status: StaffListStatus.success,
          message: 'Staff deleted successfully',
        ),
      );
    } catch (e, stack) {
      log('Error deleting staff: $e', stackTrace: stack);
      if (state is _Loaded) {
        final s = state as _Loaded;
        emit(
          s.copyWith(
            isPaginating: false,
            status: StaffListStatus.failure,
            message: e.toString(),
          ),
        );
      } else {
        emit(StaffListState.error(e.toString()));
      }
    }
  }

  // FutureOr<void> _onLoadAllStaffs(
  //   _LoadAllStaffs event,
  //   Emitter<StaffListState> emit,
  // ) async {
  //   if (state is! _Loading) emit(const StaffListState.loading());

  //   try {
  //     int page = 1;
  //     final List<StaffModel> allStaffs = [];
  //     String? nextPageUrl;

  //     do {
  //       final result = await _repository.getStaffs(page: page);
  //       allStaffs.addAll(result.data);
  //       nextPageUrl = result.nextPageUrl;
  //       page++;
  //     } while (nextPageUrl != null);

  //     emit(StaffListState.loaded(staffs: allStaffs));
  //   } catch (e, stack) {
  //     log('Error loading staffs: $e', stackTrace: stack);
  //     emit(StaffListState.error(e.toString()));
  //   }
  // }
}
