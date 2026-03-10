import 'dart:async';
import 'dart:developer' show log;

import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_booking_past_event.dart';
part 'all_booking_past_state.dart';
part 'all_booking_past_bloc.freezed.dart';

class AllBookingPastBloc
    extends Bloc<AllBookingPastEvent, AllBookingPastState> {
  final BookingRepository _repository;

  AllBookingPastBloc({required BookingRepository repository})
      : _repository = repository,
        super(const _Loading()) {
    on<_LoadBookings>(_onLoadBookings);
    on<_LoadNextPageBookings>(_onLoadNextPageBookings);
    on<_UpdateBooking>(_onUpdateBooking);
  }

  Future<void> _onLoadBookings(
    _LoadBookings event,
    Emitter<AllBookingPastState> emit,
  ) async {
    if (state is! _Loading && event.shouldRefresh) emit(const _Loading());
    try {
      final PaginationModel<BookingsModel> result;

      result = await _repository.loadBookingsPagination(
        status: LoadBookingType.past,
        startDate: event.startDate,
        endDate: event.endDate,
        searchQuery:
            event.searchQuery.isNotNullOrEmpty ? event.searchQuery : null,
      );

      emit(
        _Loaded(
          bookings: result.data,
          nextPageUrl: result.nextPageUrl,
          endDate: event.endDate,
          startDate: event.startDate,
          searchQuery: event.searchQuery,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageBookings(
    _LoadNextPageBookings event,
    Emitter<AllBookingPastState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final PaginationModel<BookingsModel> result;

      result = await _repository.loadBookingsPagination(
        status: LoadBookingType.past,
        startDate: s.startDate,
        endDate: s.endDate,
        page: nextPage,
        searchQuery: s.searchQuery.isNotNullOrEmpty ? s.searchQuery : null,
      );

      emit(
        s.copyWith(
          bookings: [...s.bookings, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  FutureOr<void> _onUpdateBooking(
    _UpdateBooking event,
    Emitter<AllBookingPastState> emit,
  ) async {
    if (event.shouldRefresh && !event.isDeleted) {
      log('refreshing');
      add(const AllBookingPastEvent.loadBookings());
      return;
    }
    if (event.booking == null) {
      log('booking is null, cancelling update');
      return;
    }

    final s = state as _Loaded;

    final updatedList = event.isDeleted
        ? s.bookings.where((e) => e.id != event.booking?.id)
        : s.bookings.map((b) => b.id == event.booking!.id ? event.booking! : b);
    emit(s.copyWith(bookings: updatedList.toList()));
  }
}
