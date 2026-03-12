import 'dart:developer';

import 'package:bookie_buddy_web/core/models/client_request_model/client_request_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/add_client_usecase.dart';
import 'package:bookie_buddy_web/features/add_booking/models/client_model/client_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_booking_cubit.freezed.dart';
part 'update_booking_state.dart';

class UpdateBookingCubit extends Cubit<UpdateBookingState> {
  final BookingRepository _repository;
  final AddClientUseCase _addClient;

  UpdateBookingCubit({
    required BookingRepository repository,
    required AddClientUseCase addClient,
  })  : _repository = repository,
        _addClient = addClient,
        super(const UpdateBookingState.initial());

  void updateBooking({
    required int bookingId,
    required RequestBookingModel updatedBooking,
    ClientRequestModel? client,
  }) async {
    emit(const _Submitting());
    try {
      ClientModel? newClient;
      // 3. Then add client if provided
      if (client != null) {
        newClient = await _addClient.call(client);
      }
      if (newClient != null) {
        updatedBooking = updatedBooking.copyWith(clientId: newClient.id);
      }
      // 1. Call Booking update first
      final res = await _repository.updateBooking(
        bookingId,
        updatedBooking,
      );

      // 2. If booking fails, don't proceed to client
      if (res.status.isInsufficientStock) {
        emit(_Failure(res.data));
        return;
      }

      emit(const _Success());
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
