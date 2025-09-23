import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_state.dart';

class BookingSelectionCubit extends Cubit<BookingSelectionState> {
  BookingSelectionCubit() : super(const BookingSelectionState());

  void selectBooking(BookingsModel booking) {
    emit(state.copyWith(selectedBooking: booking));
  }

  void markModified({bool isModified = true, bool shouldRefresh = false}) {
    log('isModified: $isModified, shouldRefresh: $shouldRefresh');
    emit(state.copyWith(
      isModified: isModified,
      shouldRefresh: shouldRefresh,
    ));
  }

  void reset() {
    emit(const BookingSelectionState());
  }
}
