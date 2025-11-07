import 'package:bookie_buddy_web/core/api/api_config.dart';

class BookingsApiPaths {
  static const _rootV3 = '${ApiConfig.v3}/bookings/';
  static const _rootV4 = '${ApiConfig.v4}/bookings/';
  static const _rootV5 = '${ApiConfig.v5}/bookings/';

  static const bookingsV3 = '${_rootV3}bookings/';
  static const bookingsV4 = '${_rootV4}bookings/';
  static const bookingsV5 = '${_rootV5}bookings/';
  static const addPayment = '${bookingsV5}add-payment/';
  static const updateDetails = '${bookingsV5}update-details/';
  static const updateDeliveryStatus = '${bookingsV5}update-delivery-status/';
  static const updateBookingStatus = '${bookingsV5}update-booking-status/';
  static const oldBookings = '${bookingsV3}old-bookings/';
  static const clients = '${_rootV3}clients/';
  static const availableProducts = '${bookingsV3}available-products/';
  static const dashboard = '${_rootV3}dashboard/';
  
  // Download invoice
  static String downloadBookingInvoice(int bookingId) =>
      '${bookingsV5}$bookingId/download-invoice/';
}
