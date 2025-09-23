import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/utils/bloc_transforms.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'completed_bookings_bloc.freezed.dart';
part 'completed_bookings_event.dart';
part 'completed_bookings_state.dart';

class CompletedBookingsBloc
    extends Bloc<CompletedBookingsEvent, CompletedBookingsState> {
  final BookingRepository _bookingRepository = getIt<BookingRepository>();

  CompletedBookingsBloc() : super(const _Loading()) {
    on<_LoadCompletedBookings>(_onLoadCompletedBookings);
    on<_LoadNextPageCompletedBookings>(
      _onLoadNextPageCompletedBookings,
      transformer: throttleDroppable(const Duration(milliseconds: 500)),
    );

    on<_UpdateBooking>(_onUpdateBooking);
  }

  Future<void> _onLoadCompletedBookings(_LoadCompletedBookings event,
      Emitter<CompletedBookingsState> emit) async {
    if (state is! _Loading) emit(const _Loading());
    try {
      final PaginationModel<BookingsModel> result;
      if (event.searchQuery == null || event.searchQuery!.isEmpty) {
        result = await _bookingRepository.loadBookingsPagination(
          fetchCompleted: true,
          startDate: event.startDate,
          endDate: event.endDate,
          page: 1,
        );
      } else {
        result = await _bookingRepository.searchBookings(
          event.searchQuery!,
          startDate: event.startDate,
          endDate: event.endDate,
          page: 1,
          status: 'completed',
        );
      }

      emit(
        _Loaded(
          completedBookings: result.data,
          nextPageUrl: result.nextPageUrl,
        ),
      );
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onLoadNextPageCompletedBookings(
      _LoadNextPageCompletedBookings event,
      Emitter<CompletedBookingsState> emit) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(
      s.copyWith(isPaginating: true),
    );

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);
      final PaginationModel<BookingsModel> result;
      if (event.searchQuery == null || event.searchQuery!.isEmpty) {
        result = await _bookingRepository.loadBookingsPagination(
          fetchCompleted: true,
          startDate: event.startDate,
          endDate: event.endDate,
          page: nextPage,
        );
      } else {
        result = await _bookingRepository.searchBookings(
          event.searchQuery!,
          startDate: event.startDate,
          endDate: event.endDate,
          page: nextPage,
          status: 'completed',
        );
      }

      emit(
        s.copyWith(
          completedBookings: [...s.completedBookings, ...result.data],
          nextPageUrl: result.nextPageUrl,
          isPaginating: false,
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
      _UpdateBooking event, Emitter<CompletedBookingsState> emit) async {
    if (event.shouldRefresh) {
      log('refreshing');
      add(const CompletedBookingsEvent.loadCompletedBookings());
      return;
    }
    if (event.booking == null) {
      log('booking is null, cancelling update');
      return;
    }

    final s = state as _Loaded;

    final updatedList = s.completedBookings.map((b) {
      return b.id == event.booking!.id ? event.booking! : b;
    }).toList();
    emit(
      s.copyWith(
        completedBookings: updatedList,
      ),
    );
  }
}
