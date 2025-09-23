import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/app_dependencies.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/features/add_booking/models/add_booking_model/add_booking_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_booking_event.dart';
part 'add_booking_state.dart';
part 'add_booking_bloc.freezed.dart';

class AddBookingBloc extends Bloc<AddBookingEvent, AddBookingState> {
  final BookingRepository _bookingRepository = getIt.get<BookingRepository>();

  AddBookingBloc() : super(const _Initial(booking: AddBookingModel())) {
    on<_UpdateBookingData>(_onUpdateBookingData);
    on<_AddNewBooking>(_onAddNewBooking);
  }

  Future<void> _onUpdateBookingData(
      _UpdateBookingData event, Emitter<AddBookingState> emit) async {
    if (state is! _Initial) {
      emit(const _Initial(booking: AddBookingModel()));
    }
    final s = state as _Initial;
    emit(
      s.copyWith(
        booking: event.booking,
      ),
    );
    log('event: ${s.booking}');
  }

  Future<void> _onAddNewBooking(
      _AddNewBooking event, Emitter<AddBookingState> emit) async {
    emit(const _Submitting());
    try {
      await _bookingRepository.postBooking(event.booking);
      emit(const _Success());
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      emit(_Error(e.toString()));
    }
  }
}
