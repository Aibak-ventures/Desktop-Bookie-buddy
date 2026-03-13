import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/models/staff_request_model/staff_request_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/add_staff_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/delete_staff_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/edit_staff_usecase.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staffs_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_list_bloc.freezed.dart';
part 'staff_list_event.dart';
part 'staff_list_state.dart';

class StaffListBloc extends Bloc<StaffListEvent, StaffListState> {
  final GetStaffsUseCase _getStaffs;
  final AddStaffUseCase _addStaff;
  final EditStaffUseCase _editStaff;
  final DeleteStaffUseCase _deleteStaff;

  StaffListBloc({
    required GetStaffsUseCase getStaffs,
    required AddStaffUseCase addStaff,
    required EditStaffUseCase editStaff,
    required DeleteStaffUseCase deleteStaff,
  })  : _getStaffs = getStaffs,
        _addStaff = addStaff,
        _editStaff = editStaff,
        _deleteStaff = deleteStaff,
        super(const StaffListState.loading()) {
    on<_LoadStaffs>(_onLoadStaffs);
    on<_LoadNextPageStaffs>(_onLoadNextPageStaffs);
    on<_AddStaff>(_onAddStaff);
    on<_EditStaff>(_onEditStaff);
    on<_DeleteStaff>(_onDeleteStaff);
    on<_StaffUpdated>(_onStaffUpdated);
  }

  Future<void> _onLoadStaffs(
    _LoadStaffs event,
    Emitter<StaffListState> emit,
  ) async {
    emit(const StaffListState.loading());

    try {
      final result = await _getStaffs.call();
      emit(
        StaffListState.loaded(
          staffs: result.data,
          nextPageUrl: result.nextPageUrl,
        ),
      );
    } catch (e, stack) {
      log('Load staffs error: $e', stackTrace: stack);
      emit(StaffListState.error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageStaffs(
    _LoadNextPageStaffs event,
    Emitter<StaffListState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.nextPageUrl == null || s.isPaginating) return;

    emit(s.copyWith(isPaginating: true));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _getStaffs.call(page: nextPage);

      emit(
        s.copyWith(
          staffs: [...s.staffs, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e) {
      emit(s.copyWith(isPaginating: false));
    }
  }

  Future<void> _onAddStaff(
    _AddStaff event,
    Emitter<StaffListState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    emit(s.copyWith(status: StaffListStatus.updating));

    try {
      final staff = await _addStaff.call(event.staff);

      emit(
        s.copyWith(
          staffs: [staff, ...s.staffs],
          status: StaffListStatus.success,
          message: 'Staff added successfully',
        ),
      );
    } catch (e) {
      emit(
        s.copyWith(
          status: StaffListStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onEditStaff(
    _EditStaff event,
    Emitter<StaffListState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    emit(s.copyWith(status: StaffListStatus.updating));

    try {
      final updated = await _editStaff.call(event.staff);

      add(StaffListEvent.staffUpdated(updated));
    } catch (e) {
      emit(
        s.copyWith(
          status: StaffListStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteStaff(
    _DeleteStaff event,
    Emitter<StaffListState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    emit(s.copyWith(status: StaffListStatus.updating));

    try {
      await _deleteStaff.call(event.staffId);

      emit(
        s.copyWith(
          staffs: s.staffs.where((e) => e.id != event.staffId).toList(),
          status: StaffListStatus.success,
          message: 'Staff deleted successfully',
        ),
      );
    } catch (e) {
      emit(
        s.copyWith(
          status: StaffListStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  /// 🔥 INSTANT UI UPDATE — NO API CALL
  void _onStaffUpdated(
    _StaffUpdated event,
    Emitter<StaffListState> emit,
  ) {
    if (state is! _Loaded) return;
    final s = state as _Loaded;

    final updatedStaffs =
        s.staffs.map((e) => e.id == event.staff.id ? event.staff : e).toList();

    emit(
      s.copyWith(
        staffs: updatedStaffs,
        status: StaffListStatus.success,
        message: 'Staff updated successfully',
      ),
    );
  }
}
