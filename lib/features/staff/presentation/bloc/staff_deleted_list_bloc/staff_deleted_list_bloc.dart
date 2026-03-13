import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/usecases/get_staffs_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_deleted_list_event.dart';
part 'staff_deleted_list_state.dart';
part 'staff_deleted_list_bloc.freezed.dart';

class StaffDeletedListBloc
    extends Bloc<StaffDeletedListEvent, StaffDeletedListState> {
  final GetStaffsUseCase _getStaffs;

  StaffDeletedListBloc({required GetStaffsUseCase getStaffs})
      : _getStaffs = getStaffs,
        super(const StaffDeletedListState.loading()) {
    on<_LoadStaffs>(_onLoadStaffs);
    on<_LoadNextPageStaffs>(_onLoadNextPageStaffs);
    on<_RestoreStaff>(_onRestoreStaff);
  }

  Future<void> _onLoadStaffs(
    _LoadStaffs event,
    Emitter<StaffDeletedListState> emit,
  ) async {
    if (state is! _Loading) emit(const StaffDeletedListState.loading());

    try {
      final result = await _getStaffs.call(
        page: 1,
        // isDeleted: true,
      );

      emit(
        StaffDeletedListState.loaded(
          staffs: result.data,
          nextPageUrl: result.nextPageUrl,
        ),
      );
    } catch (e, stack) {
      log('Error loading staffs: $e', stackTrace: stack);
      emit(StaffDeletedListState.error(e.toString()));
    }
  }

  FutureOr<void> _onLoadNextPageStaffs(
    _LoadNextPageStaffs event,
    Emitter<StaffDeletedListState> emit,
  ) async {
    try {
      if (state is! _Loaded) return;
      final s = state as _Loaded;
      if (s.nextPageUrl == null || s.isPaginating) return;

      emit(s.copyWith(isPaginating: true));
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);

      final result = await _getStaffs.call(
        page: nextPage,
        // isDeleted: true,
      );

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
        emit(StaffDeletedListState.error(e.toString()));
      }
    }
  }

  FutureOr<void> _onRestoreStaff(
    _RestoreStaff event,
    Emitter<StaffDeletedListState> emit,
  ) async {
    try {
      emit(
        state is _Loaded
            ? (state as _Loaded).copyWith(
                status: StaffDeletedListStatus.updating,
                message: null,
              )
            : state,
      );
      // await _restoreStaff.call(event.staffId);
      if (state is! _Loaded) {
        add(const StaffDeletedListEvent.loadStaffs());
        return;
      }
      emit(
        (state as _Loaded).copyWith(
          message: 'Staff restored successfully',
          status: StaffDeletedListStatus.success,
        ),
      );
    } catch (e, stack) {
      log('Error restoring staff: $e', stackTrace: stack);
      if (state is _Loaded) {
        final s = state as _Loaded;
        emit(
          s.copyWith(
            message: e.toString(),
            status: StaffDeletedListStatus.failure,
          ),
        );
      } else {
        emit(StaffDeletedListState.error(e.toString()));
      }
    }
  }
}
