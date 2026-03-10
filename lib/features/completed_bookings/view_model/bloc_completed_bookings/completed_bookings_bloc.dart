import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/utils/bloc_transforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'completed_bookings_bloc.freezed.dart';
part 'completed_bookings_event.dart';
part 'completed_bookings_state.dart';

class CompletedBookingsBloc
    extends Bloc<CompletedBookingsEvent, CompletedBookingsState> {
  final BookingRepository _repository;

  CompletedBookingsBloc({required BookingRepository repository})
      : _repository = repository,
        super(const _Loading()) {
    on<_LoadCompletedBookings>(_onLoadCompletedBookings);
    on<_LoadNextPageCompletedBookings>(
      _onLoadNextPageCompletedBookings,
      transformer: throttleDroppable(),
    );

    on<_UpdateBooking>(_onUpdateBooking);
  }

  Future<void> _onLoadCompletedBookings(
    _LoadCompletedBookings event,
    Emitter<CompletedBookingsState> emit,
  ) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final PaginationModel<BookingsModel> result;

      result = await _repository.loadBookingsPagination(
        status: LoadBookingType.completed,
        startDate: event.startDate,
        endDate: event.endDate,
        searchQuery:
            event.searchQuery.isNotNullOrEmpty ? event.searchQuery : null,
      );

      emit(
        _Loaded(
          completedBookings: result.data,
          nextPageUrl: result.nextPageUrl,
          endDate: event.endDate,
          startDate: event.startDate,
          searchQuery: event.searchQuery,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageCompletedBookings(
    _LoadNextPageCompletedBookings event,
    Emitter<CompletedBookingsState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final PaginationModel<BookingsModel> result;

      result = await _repository.loadBookingsPagination(
        status: LoadBookingType.completed,
        startDate: s.startDate,
        endDate: s.endDate,
        page: nextPage,
        searchQuery: s.searchQuery.isNotNullOrEmpty ? s.searchQuery : null,
      );

      emit(
        s.copyWith(
          completedBookings: [...s.completedBookings, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
          endDate: s.endDate,
          startDate: s.startDate,
          searchQuery: s.searchQuery,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  /// Handles the update booking event by either refreshing the bookings list
  /// or updating a specific booking in the current state. If `shouldRefresh`
  /// is true, it triggers a full reload of bookings. If a specific booking
  /// is provided, it updates that booking in the list. Emits an updated
  /// state with the modified bookings list.
  Future<void> _onUpdateBooking(
    _UpdateBooking event,
    Emitter<CompletedBookingsState> emit,
  ) async {
    if (event.shouldRefresh && !event.isDeleted) {
      log('refreshing');
      add(const CompletedBookingsEvent.loadCompletedBookings());
      return;
    }
    if (event.booking == null) {
      log('booking is null, cancelling update');
      return;
    }

    final s = state as _Loaded;

    final updatedList = event.isDeleted
        ? s.completedBookings.where((b) => b.id != event.booking!.id)
        : s.completedBookings.map(
            (b) => b.id == event.booking!.id ? event.booking! : b,
          );
    emit(s.copyWith(completedBookings: updatedList.toList()));
  }
}
