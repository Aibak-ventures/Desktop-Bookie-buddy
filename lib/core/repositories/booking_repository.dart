import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/services/booking_service.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';

class BookingRepository {
  final BookingService _bookingService;
  BookingRepository(this._bookingService);

  // Get a single booking
  Future<BookingDetailsModel> getBooking(int bookingId) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.getBooking(bookingId),
      );
      if (response.status.isSuccess) {
        return BookingDetailsModel.fromJson(response.data);
      }
      log('Error fetching booking: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error fetching booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Create a booking
  Future<void> addBooking(RequestBookingModel bookingData) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.addBooking(bookingData),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error adding booking: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error adding booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Create old booking
  Future<void> createOldBooking(RequestBookingModel bookingData) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.createOldBooking(bookingData),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error creating old booking: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error creating old booking: $e', stackTrace: stack);
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
      final response = await safeApiCall(
        () => _bookingService.updatePayment(
          bookingId: bookingId,
          amount: amount,
          paymentMethod: paymentMethod.value,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error updating payment: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error updating payment: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Update full booking data
  Future<CustomResponseModel> updateBooking(
    int bookingId,
    RequestBookingModel updatedBooking,
  ) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.updateBooking(bookingId, updatedBooking),
      );
      if (response.status.isSuccess || response.status.isInsufficientStock) {
        return response;
      }
      log('Error updating booking: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error updating booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Delete a booking
  Future<void> deleteBooking(int bookingId) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.deleteBooking(bookingId),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error deleting booking: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error deleting booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Cancel booking and process refund
  Future<void> cancelBooking({
    required int bookingId,
    required int refundAmount,
    required PaymentMethod paymentMethod,
    required String refundReason,
  }) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.cancelBooking(
          bookingId: bookingId,
          refundAmount: refundAmount,
          paymentMethod: paymentMethod.value,
          refundReason: refundReason,
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error cancelling booking: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error cancelling booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Update payment status
  Future<void> updateBookingStatus(
    int bookingId,
    BookingStatus bookingStatus,
  ) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.updateBookingStatus(
          bookingId: bookingId,
          bookingStatus: bookingStatus.toValue(),
        ),
      );
      if (response.status.isSuccess) {
        return;
      }
      log('Error updating booking status: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error updating booking status: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Update booking status (delivery or payment)
  Future<void> updateDeliveryStatus(
    int bookingId,
    DeliveryStatus deliveryStatus,
  ) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.updateDeliveryStatus(
          bookingId: bookingId,
          deliveryStatus: deliveryStatus.toValue(),
        ),
      );

      if (response.status.isSuccess) {
        return;
      }
      log('Error updating delivery status: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error updating delivery status: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Fetch bookings list with pagination support
  Future<PaginationModel<BookingsModel>> loadBookingsPagination({
    required LoadBookingType status,
    String? startDate,
    String? endDate,
    String? searchQuery,
    int page = 1,
  }) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.fetchBookingsPagination(
          status: status,
          page: page,
          startDate: startDate,
          endDate: endDate,
          searchQuery: searchQuery,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel.fromJson(
          response.data,
          (json) => BookingsModel.fromJson(json as Map<String, dynamic>),
          customJsonParser: (dataJson, itemFromJson) =>
              (dataJson as List<dynamic>?)
                  ?.map((item) => itemFromJson(item))
                  .toList() ??
              <BookingsModel>[],
        );
      }
      log('Error fetching bookings pagination: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error fetching bookings pagination: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<String> downloadBookingInvoice({
    required int bookingId,
    required String fileName,
  }) async {
    try {
      String filePath;

      if (kIsWeb) {
        // For web, we don't need to save to filesystem
        // Just return a temporary path identifier
        filePath = '/temp/$fileName.pdf';
      } else {
        // For mobile/desktop, use path_provider
        final dir = await getTemporaryDirectory();
        filePath = '${dir.path}/$fileName.pdf';
      }

      final response = await safeApiCall(
        () => _bookingService.downloadBookingInvoice(
          bookingId: bookingId,
          filePath: filePath,
        ),
      );
      if (response != null) {
        log('Download Booking Invoice Error: ${response.devMessage}');
        throw response.message;
      }
      return filePath;
    } catch (e, stack) {
      log('Error downloading booking invoice: $e', stackTrace: stack);
      rethrow;
    }
  }

  // Future<PaginationModel<BookingsModel>> searchBookings(
  //   String query, {
  //   required int page,
  //   String? startDate,
  //   String? endDate,
  //   String status = 'all',
  // }) async {
  //   try {
  //     final response = await safeApiCall(
  //       () => _searchService.searchAllBookings(
  //         query,
  //         page: page,
  //         status: status,
  //         startDate: startDate,
  //         endDate: endDate,
  //       ),
  //     );
  //     if (response.status.isSuccess) {
  //       return PaginationModel.fromJson(
  //         response.data,
  //         (json) => BookingsModel.fromJson(json as Map<String, dynamic>),
  //         customJsonParser: (dataJson, itemFromJson) =>
  //             (dataJson as List<dynamic>?)
  //                 ?.map((item) => itemFromJson(item))
  //                 .toList() ??
  //             <BookingsModel>[],
  //       );
  //     }
  //     log('Error searching bookings: ${response.devMessage}');
  //     throw response.message;
  //   } catch (e, stack) {
  //     log('Error searching bookings: $e', stackTrace: stack);
  //     rethrow;
  //   }
  // }

  Future<List<BookingDetailsPaymentHistoryModel>> getPaymentHistory(
    int bookingId,
  ) async {
    try {
      final response = await safeApiCall(
        () => _bookingService.fetchPaymentHistory(bookingId),
      );
      if (response.status.isSuccess) {
        final paymentData = (response.data as Map<String, dynamic>)['payments']
            as List<dynamic>;
        return paymentData
            .map((e) => BookingDetailsPaymentHistoryModel.fromJson(e))
            .toList();
      }
      log('Error fetching payment history: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error fetching payment history: $e', stackTrace: stack);
      rethrow;
    }
  }
}
