import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_bloc.freezed.dart';
part 'booking_details_event.dart';
part 'booking_details_state.dart';

class BookingDetailsBloc
    extends Bloc<BookingDetailsEvent, BookingDetailsState> {
  final BookingRepository _bookingRepository = getIt.get<BookingRepository>();

  BookingDetailsBloc() : super(const BookingDetailsState.loading()) {
    on<_FetchBookingDetails>(_onFetchBookingDetails);
    on<_UpdateDeliveryStatus>(_onUpdateDeliveryStatus);
    on<_UpdateBookingStatus>(_onUpdateBookingStatus);
    on<_UpdatePayment>(_onUpdatePayment);
    on<_DeleteBooking>(_onDeleteBooking);
  }

  Future<void> _onFetchBookingDetails(
      _FetchBookingDetails event, Emitter<BookingDetailsState> emit) async {
    emit(const BookingDetailsState.loading());
    try {
      final booking = await _bookingRepository.getBooking(event.bookingId);

      emit(BookingDetailsState.loaded(booking: booking));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(BookingDetailsState.error(e.toString()));
    }
  }

  Future<void> _onUpdateDeliveryStatus(
      _UpdateDeliveryStatus event, Emitter<BookingDetailsState> emit) async {
    try {
      await _bookingRepository.updateDeliveryStatus(
        event.bookingId,
        event.deliveryStatus,
      );
      emit(const _Success('Delivery status updated successfully'));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      final oldState = state;
      emit(BookingDetailsState.failed(e.toString()));
      if (oldState is _Loaded) {
        emit(oldState);
      }
    }
  }

  Future<void> _onUpdateBookingStatus(
      _UpdateBookingStatus event, Emitter<BookingDetailsState> emit) async {
    try {
      await _bookingRepository.updateBookingStatus(
        event.bookingId,
        event.bookingStatus,
      );
      emit(const _Success('Booking status updated successfully'));
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(BookingDetailsState.failed(e.toString()));
    }
  }

  Future<void> _onUpdatePayment(
      _UpdatePayment event, Emitter<BookingDetailsState> emit) async {
    try {
      await _bookingRepository.updatePayment(
        bookingId: event.bookingId,
        amount: event.amount,
        paymentMethod: event.paymentMethod,
      );
      emit(const _Success('Payment updated successfully'));
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
      _DeleteBooking event, Emitter<BookingDetailsState> emit) async {
    try {
      await _bookingRepository.deleteBooking(event.bookingId);
      emit(const _Success(
        'Booking deleted successfully',
        didPop: true,
        needRefresh: false,
      ));
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
