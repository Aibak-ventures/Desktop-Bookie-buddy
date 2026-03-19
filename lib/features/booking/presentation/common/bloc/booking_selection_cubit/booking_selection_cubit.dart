import 'dart:developer';

import 'package:bookie_buddy_web/features/booking/domain/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/bloc/booking_selection_cubit/booking_selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingSelectionCubit extends Cubit<BookingSelectionState> {
  BookingSelectionCubit() : super(const BookingSelectionState());

  void selectBooking(BookingsModel booking) {
    emit(state.copyWith(selectedBooking: booking));
  }

  void markModified({bool isModified = true, bool shouldRefresh = false}) {
    log('isModified: $isModified, shouldRefresh: $shouldRefresh');
    emit(state.copyWith(isModified: isModified, shouldRefresh: shouldRefresh));
  }

  void reset() {
    emit(const BookingSelectionState());
  }
}
