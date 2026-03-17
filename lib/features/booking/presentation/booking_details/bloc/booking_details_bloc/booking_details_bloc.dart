import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/get_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_delivery_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_status_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_payment_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/cancel_booking_usecase.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/delete_booking_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_bloc.freezed.dart';
part 'booking_details_event.dart';
part 'booking_details_state.dart';

class BookingDetailsBloc
    extends Bloc<BookingDetailsEvent, BookingDetailsState> {
  final GetBookingUseCase _getBooking;
  final UpdateDeliveryStatusUseCase _updateDeliveryStatus;
  final UpdateBookingStatusUseCase _updateBookingStatus;
  final UpdatePaymentUseCase _updatePayment;
  final CancelBookingUseCase _cancelBooking;
  final DeleteBookingUseCase _deleteBooking;

  BookingDetailsBloc({
    required GetBookingUseCase getBooking,
    required UpdateDeliveryStatusUseCase updateDeliveryStatus,
    required UpdateBookingStatusUseCase updateBookingStatus,
    required UpdatePaymentUseCase updatePayment,
    required CancelBookingUseCase cancelBooking,
    required DeleteBookingUseCase deleteBooking,
  })  : _getBooking = getBooking,
        _updateDeliveryStatus = updateDeliveryStatus,
        _updateBookingStatus = updateBookingStatus,
        _updatePayment = updatePayment,
        _cancelBooking = cancelBooking,
        _deleteBooking = deleteBooking,
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
      final booking = await _getBooking(event.bookingId);

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
      await _updateDeliveryStatus(
        event.bookingId,
        event.deliveryStatus,
      );

      // Refetch booking details to get updated delivery status from server
      final booking = await _getBooking(event.bookingId);
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
      await _updateBookingStatus(
        event.bookingId,
        event.bookingStatus,
      );

      // Refetch booking details to get updated booking status
      final booking = await _getBooking(event.bookingId);
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
      await _updatePayment(
        bookingId: event.bookingId,
        amount: event.amount,
        paymentMethod: event.paymentMethod,
      );

      log('✅ Payment updated, refetching booking details...');
      // Refetch booking details to get updated payment information
      final booking = await _getBooking(event.bookingId);
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
      await _cancelBooking(
        bookingId: event.bookingId,
        refundAmount: event.refundAmount,
        paymentMethod: event.paymentMethod,
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
      await _deleteBooking(event.bookingId);
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
