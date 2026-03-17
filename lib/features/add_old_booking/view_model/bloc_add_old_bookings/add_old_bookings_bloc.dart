import 'dart:async';
import 'dart:developer';

import 'package:bookie_buddy_web/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/add_client_usecase.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_old_bookings_event.dart';
part 'add_old_bookings_state.dart';
part 'add_old_bookings_bloc.freezed.dart';

class AddOldBookingsBloc
    extends Bloc<AddOldBookingsEvent, AddOldBookingsState> {
  final BookingRepositoryImpl _repository;
  final AddClientUseCase _addClient;

  AddOldBookingsBloc({
    required BookingRepositoryImpl repository,
    required AddClientUseCase addClient,
  })  : _repository = repository,
        _addClient = addClient,
        super(const AddOldBookingsState.initial()) {
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
        final newClient = await _addClient.call(event.booking.client!);
        log('New client added: ${newClient.toJson()}');
        clientId = newClient.id;
      } else {
        log('Existing client found: ${event.booking.clientId}');
      }
      await _repository.createOldBooking(
        event.booking.copyWith(clientId: clientId),
      );
      emit(const _Success());
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }
}
