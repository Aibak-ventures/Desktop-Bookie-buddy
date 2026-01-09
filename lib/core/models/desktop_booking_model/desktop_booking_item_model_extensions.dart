import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/desktop_booking_model/desktop_booking_item_model.dart';

/// Extension to convert DesktopBookingItemModel to BookingsModel
/// This allows us to reuse the BookingCard widget with desktop booking data
extension DesktopBookingItemModelX on DesktopBookingItemModel {
  BookingsModel toBookingsModel() {
    return BookingsModel(
      id: id,
      clientName: client,
      bookingStatus:
          BookingStatus.upcoming, // Default since not in desktop model
      bookedDate: createdAt,
      pickupDate: pickupDate,
      returnDate: returnDate,
      deliveryStatus: deliveryStatus,
      paymentStatus:
          paymentStatus ? PaymentStatus.completed : PaymentStatus.pending,
      shopBookingId: shopBookingId,
      staffName: staffName,
      createdAt: createdAt,
      bookedItems: bookedItems.split(',').map((e) => e.trim()).toList(),
    );
  }
}
