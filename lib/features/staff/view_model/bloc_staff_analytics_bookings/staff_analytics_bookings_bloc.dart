import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/staff_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_analytics_bookings_event.dart';
part 'staff_analytics_bookings_state.dart';
part 'staff_analytics_bookings_bloc.freezed.dart';

class StaffAnalyticsBookingsBloc
    extends Bloc<StaffAnalyticsBookingsEvent, StaffAnalyticsBookingsState> {
  final StaffRepository _repository;
  StaffAnalyticsBookingsBloc({required StaffRepository repository})
    : _repository = repository,
      super(const _Loading()) {
    on<_LoadBookings>(_onLoadBookings);
    on<_LoadNextPageBookings>(_onLoadNextPageBookings);
  }

  Future<void> _onLoadBookings(
    _LoadBookings event,
    Emitter<StaffAnalyticsBookingsState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final result = await _repository.getStaffMonthlyBookingsPagination(
        staffId: event.staffId,
        year: event.year,
        month: event.month,
      );
      emit(
        _Loaded(
          bookings: result.data,
          nextPageUrl: result.nextPageUrl,
          staffId: event.staffId,
          month: event.month,
          year: event.year,
        ),
      );
    } catch (e, stack) {
      log(
        'Error loading bookings for staff analytics',
        error: e,
        stackTrace: stack,
      );
      emit(_Error(e.toString()));
    }
  }

  FutureOr<void> _onLoadNextPageBookings(
    _LoadNextPageBookings event,
    Emitter<StaffAnalyticsBookingsState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.nextPageUrl == null || s.isPaginating) return;
    emit(s.copyWith(isPaginating: true));
    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final result = await _repository.getStaffMonthlyBookingsPagination(
        staffId: s.staffId,
        year: s.year,
        month: s.month,
        page: nextPage,
      );

      emit(
        s.copyWith(
          bookings: [...s.bookings, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e, stack) {
      log(
        'Error loading next page bookings for staff analytics',
        error: e,
        stackTrace: stack,
      );
      emit(_Error(e.toString()));
    }
  }
}
