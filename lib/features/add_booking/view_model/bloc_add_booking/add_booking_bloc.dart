import 'dart:developer';

import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_booking_event.dart';
part 'add_booking_state.dart';
part 'add_booking_bloc.freezed.dart';

class AddBookingBloc extends Bloc<AddBookingEvent, AddBookingState> {
  final BookingRepository _bookingRepository;

  AddBookingBloc({
    required BookingRepository bookingRepository,
  })  : _bookingRepository = bookingRepository,
        super(const _Initial(booking: RequestBookingModel())) {
    //
    on<_UpdateBookingData>(_onUpdateBookingData);
    on<_AddNewBooking>(_onAddNewBooking);
  }

  Future<void> _onUpdateBookingData(
    _UpdateBookingData event,
    Emitter<AddBookingState> emit,
  ) async {
    if (state is! _Initial) {
      emit(const _Initial(booking: RequestBookingModel()));
    }
    final s = state as _Initial;
    emit(s.copyWith(booking: event.booking));
    log('event: ${s.booking}');
  }

  Future<void> _onAddNewBooking(
    _AddNewBooking event,
    Emitter<AddBookingState> emit,
  ) async {
    assert(
      event.booking.clientId != null || event.booking.client != null,
      'Either clientId or client must be provided',
    );
    emit(const _Submitting());
    try {
      // final clientId = event.booking.clientId;
      // if (clientId == null && event.booking.client != null) {
      //   final newClient = await _clientRepository.addClient(
      //     event.booking.client!,
      //   );
      //   log('New client added: ${newClient.toJson()}');
      //   clientId = newClient.id;
      // } else {
      //   log('Existing client found: ${event.booking.clientId}');
      // }

      await _bookingRepository.addBooking(event.booking);
      emit(const _Success());
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
