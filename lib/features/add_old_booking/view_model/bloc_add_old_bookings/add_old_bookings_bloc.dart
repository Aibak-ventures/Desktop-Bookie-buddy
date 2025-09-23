import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/features/add_booking/models/add_booking_model/add_booking_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_old_bookings_event.dart';
part 'add_old_bookings_state.dart';
part 'add_old_bookings_bloc.freezed.dart';

class AddOldBookingsBloc
    extends Bloc<AddOldBookingsEvent, AddOldBookingsState> {
  final BookingRepository _repository = getIt.get<BookingRepository>();
  AddOldBookingsBloc() : super(const _Initial()) {
    on<_AddBooking>(_onAddBooking);
  }

  Future<void> _onAddBooking(
      _AddBooking event, Emitter<AddOldBookingsState> emit) async {
    emit(const _Submitting());
    try {
      await _repository.createOldBooking(event.booking);
      emit(const _Success());
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Failure(e.toString()));
    }
  }
}
