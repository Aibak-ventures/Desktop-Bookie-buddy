import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_details_drawer_cubit.freezed.dart';

@freezed
abstract class BookingDetailsDrawerState with _$BookingDetailsDrawerState {
  const factory BookingDetailsDrawerState({
    @Default(false) bool isOpen,
    int? selectedBookingId,
  }) = _BookingDetailsDrawerState;
}

class BookingDetailsDrawerCubit extends Cubit<BookingDetailsDrawerState> {
  BookingDetailsDrawerCubit() : super(const BookingDetailsDrawerState());

  void openDrawer(int bookingId) {
    emit(state.copyWith(isOpen: true, selectedBookingId: bookingId));
  }

  void closeDrawer() {
    emit(state.copyWith(isOpen: false));
  }

  void toggleDrawer(int? bookingId) {
    if (state.isOpen && state.selectedBookingId == bookingId) {
      closeDrawer();
    } else if (bookingId != null) {
      openDrawer(bookingId);
    }
  }
}
