import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_old_bookings_event.dart';
part 'add_old_bookings_state.dart';
part 'add_old_bookings_bloc.freezed.dart';

class AddOldBookingsBloc
    extends Bloc<AddOldBookingsEvent, AddOldBookingsState> {
  final BookingRepository _bookingRepository;
  final ClientRepository _clientRepository;
  AddOldBookingsBloc({
    required BookingRepository bookingRepository,
    required ClientRepository clientRepository,
  }) : _bookingRepository = bookingRepository,
       _clientRepository = clientRepository,
       super(const _Initial()) {
    on<_AddBooking>(_onAddBooking);
  }

  Future<void> _onAddBooking(
    _AddBooking event,
    Emitter<AddOldBookingsState> emit,
  ) async {
    emit(const _Submitting());
    try {
      int? clientId = event.booking.clientId;
      if (clientId == null && event.booking.client != null) {
        final newClient = await _clientRepository.addClient(
          event.booking.client!,
        );
        log('New client added: ${newClient.toJson()}');
        clientId = newClient.id;
      } else {
        log('Existing client found: ${event.booking.clientId}');
      }
      await _bookingRepository.createOldBooking(
        event.booking.copyWith(clientId: clientId),
      );
      emit(const _Success());
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }
}
