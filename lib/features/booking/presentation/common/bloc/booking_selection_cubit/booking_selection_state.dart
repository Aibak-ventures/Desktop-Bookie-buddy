import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';

class BookingSelectionState {
  final BookingEntity? selectedBooking;
  final bool isModified;
  final bool shouldRefresh;

  const BookingSelectionState({
    this.selectedBooking,
    this.isModified = false,
    this.shouldRefresh = false,
  });

  BookingSelectionState copyWith({
    BookingEntity? selectedBooking,
    bool? isModified,
    bool? shouldRefresh,
  }) => BookingSelectionState(
    selectedBooking: selectedBooking ?? this.selectedBooking,
    isModified: isModified ?? this.isModified,
    shouldRefresh: shouldRefresh ?? this.shouldRefresh,
  );
}
