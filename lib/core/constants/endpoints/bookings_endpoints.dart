import 'package:bookie_buddy_web/core/constants/endpoints/api_config.dart';

class BookingsEndpoints {
  static const _rootV3 = '${ApiConfig.v3}/bookings/';
  static const _rootV4 = '${ApiConfig.v4}/bookings/';
  static const _rootV5 = '${ApiConfig.v5}/bookings/';

  static const bookingsV3 = '${_rootV3}bookings/';
  static const bookingsV4 = '${_rootV4}bookings/';
  static const bookingsV5 = '${_rootV5}bookings/';
  static const desktopList = '${_rootV5}bookings/desktop-list/';
  static const addPayment = '${bookingsV5}add-payment/';
  static const updateDetails = '${bookingsV5}update-details/';
  static const updateDeliveryStatus = '${bookingsV5}update-delivery-status/';
  static const updateBookingStatus = '${bookingsV5}update-booking-status/';
  static const oldBookings = '${bookingsV3}old-bookings/';
  static const clients = '${_rootV3}clients/';
  static const availableProducts = '${bookingsV3}desktop-available-products/';
  static const dashboard = '${_rootV4}dashboard/';
  static const cancelBooking = '${bookingsV5}cancel-booking/';

  // Dynamic methods
  static String addRefund(int bookingId) => '${bookingsV5}refund/$bookingId/';
  static String deletePayment(int id) => '${bookingsV5}delete-payment/$id/';
  static String sendBookingInvoice(int bookingId) =>
      '${bookingsV5}send-invoice/$bookingId/'; // Send invoice endpoint (returns PDF)
  static String downloadBookingInvoice(int bookingId) =>
      '${bookingsV5}send-invoice/$bookingId/'; // Same endpoint for download
  static String clientById(int id) => '${clients}$id/'; // Added missing method
}
