import 'package:bookie_buddy_web/features/booking/domain/models/booking_model/booking_model.dart';

class BookingSelectionState {
  final BookingsModel? selectedBooking;
  final bool isModified;
  final bool shouldRefresh;

  const BookingSelectionState({
    this.selectedBooking,
    this.isModified = false,
    this.shouldRefresh = false,
  });

  BookingSelectionState copyWith({
    BookingsModel? selectedBooking,
    bool? isModified,
    bool? shouldRefresh,
  }) =>
      BookingSelectionState(
        selectedBooking: selectedBooking ?? this.selectedBooking,
        isModified: isModified ?? this.isModified,
        shouldRefresh: shouldRefresh ?? this.shouldRefresh,
      );
}
