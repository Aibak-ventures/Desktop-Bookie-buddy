import 'dart:developer';

import 'package:bookie_buddy_web/features/client/domain/entities/client_request_entity/client_request_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/usecases/update_booking_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/add_client_usecase.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/request_booking_model/request_booking_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_booking_cubit.freezed.dart';
part 'update_booking_state.dart';

class UpdateBookingCubit extends Cubit<UpdateBookingState> {
  final UpdateBookingUseCase _updateBooking;
  final AddClientUseCase _addClient;

  UpdateBookingCubit({
    required UpdateBookingUseCase updateBooking,
    required AddClientUseCase addClient,
  })  : _updateBooking = updateBooking,
        _addClient = addClient,
        super(const UpdateBookingState.initial());

  void updateBooking({
    required int bookingId,
    required RequestBookingModel updatedBooking,
    ClientRequestEntity? client,
  }) async {
    emit(const _Submitting());
    try {
      ClientEntity? newClient;
      // 3. Then add client if provided
      if (client != null) {
        newClient = await _addClient.call(client);
      }
      if (newClient != null) {
        updatedBooking = updatedBooking.copyWith(clientId: newClient.id);
      }
      // 1. Call Booking update first
      final res = await _updateBooking(
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
