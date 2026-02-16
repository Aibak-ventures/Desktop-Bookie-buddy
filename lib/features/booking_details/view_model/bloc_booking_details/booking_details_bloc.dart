import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_bloc.freezed.dart';
part 'booking_details_event.dart';
part 'booking_details_state.dart';

class BookingDetailsBloc
    extends Bloc<BookingDetailsEvent, BookingDetailsState> {
  final BookingRepository _repository;

  BookingDetailsBloc({required BookingRepository repository})
      : _repository = repository,
        super(const BookingDetailsState.loading()) {
    on<_FetchBookingDetails>(_onFetchBookingDetails);
    on<_UpdateDeliveryStatus>(_onUpdateDeliveryStatus);
    on<_UpdateBookingStatus>(_onUpdateBookingStatus);
    on<_UpdatePayment>(_onUpdatePayment);
    on<_CancelBooking>(_onCancelBooking);
    on<_DeleteBooking>(_onDeleteBooking);
  }

  Future<void> _onFetchBookingDetails(
    _FetchBookingDetails event,
    Emitter<BookingDetailsState> emit,
  ) async {
    if (state is! _Loading) emit(const BookingDetailsState.loading());
    try {
      final booking = await _repository.getBooking(event.bookingId);

      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(BookingDetailsState.error(e.toString()));
    }
  }

  Future<void> _onUpdateDeliveryStatus(
    _UpdateDeliveryStatus event,
    Emitter<BookingDetailsState> emit,
  ) async {
    // Store old state for rollback on error
    final oldState = state;
    
    // Optimistic update - update UI immediately
    if (oldState is _Loaded) {
      final updatedBooking = oldState.booking.copyWith(
        deliveryStatus: event.deliveryStatus,
      );
      emit(BookingDetailsState.loaded(booking: updatedBooking));
    }
    
    try {
      await _repository.updateDeliveryStatus(
        event.bookingId,
        event.deliveryStatus,
      );

      // Refetch booking details to get updated delivery status from server
      final booking = await _repository.getBooking(event.bookingId);
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(BookingDetailsState.failed(e.toString()));
      // Rollback to old state on error
      if (oldState is _Loaded) {
        emit(oldState);
      }
    }
  }

  Future<void> _onUpdateBookingStatus(
    _UpdateBookingStatus event,
    Emitter<BookingDetailsState> emit,
  ) async {
    try {
      await _repository.updateBookingStatus(
        event.bookingId,
        event.bookingStatus,
      );

      // Refetch booking details to get updated booking status
      final booking = await _repository.getBooking(event.bookingId);
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      final previous = state;
      emit(BookingDetailsState.failed(e.toString()));
      if (previous is _Loaded) {
        emit(previous);
      }
    }
  }

  Future<void> _onUpdatePayment(
    _UpdatePayment event,
    Emitter<BookingDetailsState> emit,
  ) async {
    try {
      log('📤 Updating payment: ${event.amount} for booking ${event.bookingId}');
      await _repository.updatePayment(
        bookingId: event.bookingId,
        amount: event.amount,
        paymentMethod: event.paymentMethod,
      );

      log('✅ Payment updated, refetching booking details...');
      // Refetch booking details to get updated payment information
      final booking = await _repository.getBooking(event.bookingId);
      log('📥 Fetched booking with ${booking.payments.length} payments, total: ${booking.actualPaidAmount}');
      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      final oldState = state;
      emit(BookingDetailsState.failed(e.toString()));
      if (oldState is _Loaded) {
        emit(oldState);
      }
    }
  }

  Future<void> _onCancelBooking(
    _CancelBooking event,
    Emitter<BookingDetailsState> emit,
  ) async {
    try {
      await _repository.cancelBooking(
        bookingId: event.bookingId,
      );
      emit(
        const _Success(
          'Booking cancelled successfully',
          needRefresh: true,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      final oldState = state;
      emit(BookingDetailsState.failed(e.toString()));
      if (oldState is _Loaded) {
        emit(oldState);
      }
    }
  }

  Future<void> _onDeleteBooking(
    _DeleteBooking event,
    Emitter<BookingDetailsState> emit,
  ) async {
    try {
      await _repository.deleteBooking(event.bookingId);
      emit(
        const _Success(
          'Booking deleted successfully',
          didPop: true,
          needRefresh: false,
        ),
      );
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      final oldState = state;
      emit(BookingDetailsState.failed(e.toString()));
      if (oldState is _Loaded) {
        emit(oldState);
      }
    }
  }

  BookingDetailsModel? getBooking() {
    final state = this.state;
    if (state is _Loaded) {
      return state.booking;
    }
    return null;
  }
}
