import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/booking/data/models/desktop_booking_model/desktop_booking_item_model.dart';

/// Extension to convert DesktopBookingItemModel to BookingsModel
/// This allows us to reuse the BookingCard widget with desktop booking data
extension DesktopBookingItemModelX on DesktopBookingItemModel {
  BookingEntity toBookingsModel() {
    return BookingEntity(
      id: id,
      clientName: client,
      bookingStatus:
          BookingStatus.upcoming, // Default since not in desktop model
      bookedDate: createdAt,
      pickupDate: pickupDate,
      returnDate: returnDate,
      deliveryStatus: deliveryStatus ?? DeliveryStatus.booked,
      paymentStatus: paymentStatus
          ? PaymentStatus.completed
          : PaymentStatus.pending,
      shopBookingId: shopBookingId,
      staffName: staffName,
      createdAt: createdAt,
      bookedItems: bookedItems.split(',').map((e) => e.trim()).toList(),
    );
  }
}
