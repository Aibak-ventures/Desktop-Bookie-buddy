import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/core/services/booking_search_service.dart';
import 'package:bookie_buddy_web/core/services/booking_service.dart';
import 'package:bookie_buddy_web/features/add_booking/models/add_booking_model/add_booking_model.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';

class BookingRepository {
  final BookingService _bookingService;
  final BookingSearchService _searchService;
  BookingRepository(
    this._bookingService,
    this._searchService,
  );

  // Get a single booking
  Future<BookingDetailsModel> getBooking(int bookingId) async {
    try {
      return await _bookingService.getBooking(bookingId);
    } catch (e) {
      rethrow;
    }
  }

  // Create a booking
  Future<void> postBooking(AddBookingModel bookingData) async {
    try {
      await _bookingService.AddBooking(bookingData);
    } catch (e) {
      rethrow;
    }
  }

  // Create old booking
  Future<void> createOldBooking(AddBookingModel bookingData) async {
    try {
      await _bookingService.createOldBooking(bookingData);
    } catch (e) {
      rethrow;
    }
  }

  // Update amount or part of booking
  Future<void> updatePayment({
    required int bookingId,
    required int amount,
    required PaymentMethod paymentMethod,
  }) async {
    try {
      await _bookingService.updatePayment(
        bookingId: bookingId,
        amount: amount,
        paymentMethod: paymentMethod.toValue(),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Update full booking data
  Future<Map<String, dynamic>> updateBooking(
      int bookingId, Map<String, dynamic> data) async {
    try {
      return await _bookingService.updateBooking(bookingId, data);
    } catch (e) {
      rethrow;
    }
  }

  // Delete a booking
  Future<void> deleteBooking(int bookingId) async {
    try {
      await _bookingService.deleteBooking(bookingId);
    } catch (e) {
      rethrow;
    }
  }

  // Update payment status
  Future<void> updateBookingStatus(
    int bookingId,
    BookingStatus bookingStatus,
  ) async {
    try {
      await _bookingService.updateBookingStatus(
        bookingId: bookingId,
        bookingStatus: bookingStatus.toValue(),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Update booking status (delivery or payment)
  Future<void> updateDeliveryStatus(
    int bookingId,
    DeliveryStatus deliveryStatus,
  ) async {
    try {
      await _bookingService.updateDeliveryStatus(
        bookingId: bookingId,
        deliveryStatus: deliveryStatus.toValue(),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Fetch bookings list with pagination support
  Future<PaginationModel<BookingsModel>> loadBookingsPagination({
    String? startDate,
    String? endDate,
    bool fetchCompleted = false,
    int page = 1,
  }) async {
    try {
      return await _bookingService.fetchBookingsPagination(
        fetchCompleted: fetchCompleted,
        page: page,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<PaginationModel<BookingsModel>> searchBookings(
    String query, {
    required int page,
    String? startDate,
    String? endDate,
    String status = 'all',
  }) async {
    try {
      return await _searchService.searchAllBookings(
        query,
        page: page,
        status: status,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BookingDetailsPaymentHistoryModel>> getPaymentHistory(
    int bookingId,
  ) async {
    try {
      return await _bookingService.fetchPaymentHistory(bookingId);
    } catch (e) {
      rethrow;
    }
  }
}
