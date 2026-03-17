import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/desktop_booking_model/desktop_booking_item_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/desktop_booking_model/status_counts_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_delivery_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/load_desktop_bookings_pagination_usecase.dart';
import 'package:bookie_buddy_web/utils/bloc_transforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_booking_bloc.freezed.dart';
part 'all_booking_event.dart';
part 'all_booking_state.dart';

class AllBookingBloc extends Bloc<AllBookingEvent, AllBookingState> {
  final UpdateDeliveryStatusUseCase _updateDeliveryStatus;
  final DeleteBookingUseCase _deleteBooking;
  final UpdateBookingStatusUseCase _updateBookingStatus;
  final LoadDesktopBookingsPaginationUseCase _loadDesktopBookings;

  AllBookingBloc({
    required UpdateDeliveryStatusUseCase updateDeliveryStatus,
    required DeleteBookingUseCase deleteBooking,
    required UpdateBookingStatusUseCase updateBookingStatus,
    required LoadDesktopBookingsPaginationUseCase loadDesktopBookings,
  })  : _updateDeliveryStatus = updateDeliveryStatus,
        _deleteBooking = deleteBooking,
        _updateBookingStatus = updateBookingStatus,
        _loadDesktopBookings = loadDesktopBookings,
        super(const AllBookingState.loading()) {
    on<_LoadBookings>(_onFetchBookings);
    on<_LoadNextPageBookings>(
      _onFetchNextPage,
      transformer: throttleDroppable(),
    );

    on<_UpdateBooking>(_onUpdateBooking);

    on<_UpdateDeliveryStatus>(_onUpdateDeliveryStatus);
    on<_DeleteBooking>(_onDeleteBooking);
    on<_MarkAsCompleted>(_onMarkAsCompleted);
  }

  Future<void> _onUpdateDeliveryStatus(
    _UpdateDeliveryStatus event,
    Emitter<AllBookingState> emit,
  ) async {
    try {
      await _updateDeliveryStatus(
        event.bookingId,
        event.deliveryStatus,
      );

      // Update the local state instead of reloading
      if (state is _Loaded) {
        final s = state as _Loaded;
        final updatedBookings = s.bookings.map((booking) {
          if (booking.id == event.bookingId) {
            return booking.copyWith(deliveryStatus: event.deliveryStatus);
          }
          return booking;
        }).toList();

        emit(s.copyWith(bookings: updatedBookings));
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      if (state is _Loaded) {
        emit((state as _Loaded).copyWith(actionError: e.toString()));
        emit((state as _Loaded).copyWith(actionError: null));
      } else {
        emit(_Error(e.toString()));
      }
    }
  }

  Future<void> _onDeleteBooking(
    _DeleteBooking event,
    Emitter<AllBookingState> emit,
  ) async {
    try {
      await _deleteBooking(event.bookingId);
      if (state is _Loaded) {
        final s = state as _Loaded;
        // Reload to ensure data consistency
        add(AllBookingEvent.loadBookings(
          status: s.status,
          startDate: s.startDate,
          endDate: s.endDate,
          searchQuery: s.searchQuery,
        ));
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      if (state is _Loaded) {
        emit((state as _Loaded).copyWith(actionError: e.toString()));
        emit((state as _Loaded).copyWith(actionError: null));
      } else {
        emit(_Error(e.toString()));
      }
    }
  }

  Future<void> _onMarkAsCompleted(
    _MarkAsCompleted event,
    Emitter<AllBookingState> emit,
  ) async {
    try {
      // API requires items to be returned before completing
      // EXCEPT for cancelled bookings - skip delivery status update for those
      if (event.currentStatus != DeliveryStatus.returned &&
          event.currentStatus != DeliveryStatus.cancelled) {
        await _updateDeliveryStatus(
          event.bookingId,
          DeliveryStatus.returned,
        );
      }

      await _updateBookingStatus(
        event.bookingId,
        BookingStatus.completed,
      );

      if (state is _Loaded) {
        final s = state as _Loaded;
        // Reload to ensure data consistency
        add(AllBookingEvent.loadBookings(
          status: s
              .status, // If status was 'pending', removing item should happen via reload naturally
          startDate: s.startDate,
          endDate: s.endDate,
          searchQuery: s.searchQuery,
        ));
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      if (state is _Loaded) {
        emit((state as _Loaded).copyWith(actionError: e.toString()));
        emit((state as _Loaded).copyWith(actionError: null));
      } else {
        emit(_Error(e.toString()));
      }
    }
  }

  Future<void> _onFetchBookings(
    _LoadBookings event,
    Emitter<AllBookingState> emit,
  ) async {
    // Only show loading if we don't have data for this status yet
    // This prevents the counts from showing zero during tab switches
    final currentState = state;
    final shouldShowLoading =
        currentState is! _Loaded || (currentState.status != event.status);

    if (shouldShowLoading) {
      emit(const _Loading());
    }

    try {
      final result = await _loadDesktopBookings(
        status: event.status ?? 'pending',
        startDate: event.startDate,
        endDate: event.endDate,
        searchQuery:
            event.searchQuery.isNotNullOrEmpty ? event.searchQuery : null,
      );

      emit(
        _Loaded(
          bookings: result.pagination.data,
          nextPageUrl: result.pagination.nextPageUrl,
          endDate: event.endDate,
          startDate: event.startDate,
          searchQuery: event.searchQuery,
          status: event.status ?? 'pending',
          statusCounts: result.statusCounts,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }

  Future<void> _onFetchNextPage(
    _LoadNextPageBookings event,
    Emitter<AllBookingState> emit,
  ) async {
    if (state is! _Loaded) return;
    final s = state as _Loaded;
    if (s.isPaginating || s.nextPageUrl == null) return;

    emit(s.copyWith(isPaginating: true));

    try {
      final nextPage = PaginationModel.getPageFromUrl(s.nextPageUrl);

      final result = await _loadDesktopBookings(
        status: s.status ?? 'pending',
        startDate: s.startDate,
        endDate: s.endDate,
        page: nextPage,
        searchQuery: s.searchQuery,
      );

      emit(
        s.copyWith(
          bookings: [...s.bookings, ...result.pagination.data],
          nextPageUrl: result.pagination.nextPageUrl,
          isPaginating: false,
          endDate: s.endDate,
          startDate: s.startDate,
          searchQuery: s.searchQuery,
          statusCounts: result.statusCounts ?? s.statusCounts,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
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
    Emitter<AllBookingState> emit,
  ) async {
    if (event.shouldRefresh && !event.isDeleted) {
      log('refreshing');
      if (state is _Loaded) {
        final s = state as _Loaded;
        add(AllBookingEvent.loadBookings(
          status: s.status,
          startDate: s.startDate,
          endDate: s.endDate,
          searchQuery: s.searchQuery,
        ));
      } else {
        add(const AllBookingEvent.loadBookings());
      }
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
