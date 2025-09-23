import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';

class BookingGroupedModel {
  final String date;
  final List<BookingsModel> bookings;
  BookingGroupedModel({
    required this.date,
    required this.bookings,
  });
}
