enum BookingType { booking, sales, customWork, oldBooking }

enum BookingTabType { booking, sales, customWork, oldBooking }

extension BookingTypeX on BookingType {
  BookingTabType toTabType() => BookingTabType.values[index];
}

extension BookingTabTypeX on BookingTabType {
  BookingType toBookingType() => BookingType.values[index];
}
