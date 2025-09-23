import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/features/booking_details/models/client_request_model/client_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_booking_state.dart';
part 'update_booking_cubit.freezed.dart';

class UpdateBookingCubit extends Cubit<UpdateBookingState> {
  final BookingRepository _bookingRepository = getIt.get<BookingRepository>();
  final ClientRepository _clientRepository = getIt.get<ClientRepository>();
  UpdateBookingCubit() : super(const _Initial());

  Future<void> updateBooking({
    required int bookingId,
    required Map<String, dynamic> updatedData,
    ClientRequestModel? client,
  }) async {
    emit(const _Submitting());
    try {
      // 1. Call Booking update first
      final res = await _bookingRepository.updateBooking(
        bookingId,
        updatedData,
      );

      // 2. If booking fails, don't proceed to client
      if (res.containsKey('error')) {
        final error = res['error'];
        emit(error is String ? _Error(error) : _Failure(error));
        return;
      }

      // 3. Then update client if provided
      if (client != null) {
        await _clientRepository.updateClient(client);
      }

      emit(const _Success());
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
