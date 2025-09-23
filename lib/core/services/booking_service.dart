import 'dart:developer';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/error/error_handler.dart';
import 'package:bookie_buddy_web/core/error/exceptions/booking_exceptions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/add_booking/models/add_booking_model/add_booking_model.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:dio/dio.dart';

class BookingService {
  final _dio = DioClient.dio;
  final bookingManagementUrl = '/api/v2/bookings/bookings/';

  Future<BookingDetailsModel> getBooking(int bookingId) async {
    try {
      final response = await _dio.get('${bookingManagementUrl}$bookingId/');

      if (response.statusCode == 200) {
        return BookingDetailsModel.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw BookingNotFoundException('Booking not found');
      } else {
        log('status code: ${response.statusCode}, data: ${response.data}');
        throw FailedBookingException('Failed to fetch booking');
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw ErrorHandler.handle(e);
    }
  }

  Future<void> AddBooking(AddBookingModel bookingData) async {
    try {
      final data = bookingData.toCustomJson();
      // {
      //   "client_id": bookingData.clientId,
      //   "pickup_date": bookingData.pickupDate,
      //   "return_date": bookingData.returnDate,
      //   if (bookingData.advanceAmount != null)
      //     "advance_amount": bookingData.advanceAmount,
      //   "security_amount": bookingData.securityAmount,
      //   "discount_amount": bookingData.discountAmount,
      //   "purchase_mode": bookingData.purchaseMode,
      //   "staff_name": bookingData.staffName,
      //   "description": bookingData.description,
      //   "payment_method": bookingData.paymentMethod,
      //   "client_address": bookingData.address,
      //   "delivery_status": bookingData.deliveryStatus,
      //   "variants": bookingData.products?.map((e) => e.toCustomJson()).toList(),
      //   "details": {
      //     //Location for vehicle
      //     if (bookingData.locationFrom != null &&
      //         bookingData.locationFrom != '')
      //       "location_from": bookingData.locationFrom,

      //     if (bookingData.locationTo != null && bookingData.locationTo != '')
      //       "location_to": bookingData.locationTo,

      //     if (bookingData.locationStart != null &&
      //         bookingData.locationStart != '')
      //       "location_start": bookingData.locationStart
      //   }
      // };

      log(data.toString());
      final response = await _dio.post(
        bookingManagementUrl,
        data: data,
      );

      log('status code: ${response.statusCode}, data: ${response.data}');

      if (response.statusCode == 201) {
        return;
      } else if (response.statusCode == 400) {
        final error = response.data['error'];
        if (error is Map && error.containsKey('message')) {
          throw error['message'];
        } else if (error is String) {
          throw error;
        } else {
          throw 'Failed to create booking';
        }
      } else {
        throw response.data['error'] ?? 'Failed to create booking';
      }
    } on DioException catch (e) {
      throw 'Failed to create booking: ${e.message}';
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<void> updatePayment({
    required int bookingId,
    required int amount,
    required String paymentMethod,
  }) async {
    try {
      final response = await _dio.patch(
        '${bookingManagementUrl}$bookingId/',
        data: {
          "amount": amount,
          "payment_method": paymentMethod,
        },
      );

      log('status code: ${response.statusCode}, data: ${response.data}');

      if (response.statusCode != 200) {
        throw response.data['error'] ??
            response.data['message'] ??
            'Failed to update booking';
      }
    } on DioException catch (e) {
      throw 'Failed to update booking: ${e.message}';
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw e;
    }
  }

  Future<void> updateBookingStatus({
    required int bookingId,
    required String bookingStatus,
  }) async {
    try {
      final response = await _dio.patch(
        '${bookingManagementUrl}$bookingId/',
        data: {
          "booking_status": bookingStatus,
        },
      );

      log('status code: ${response.statusCode}, data: ${response.data}');
      if (response.statusCode == 400) {
        throw response.data['error'] ?? 'Failed to update booking status';
      }
      if (response.statusCode != 200) {
        throw 'Failed to update booking status';
      }
    } on DioException catch (e) {
      throw 'Failed to update booking status: ${e.message}';
    } catch (e) {
      throw 'Failed to update booking status: $e';
    }
  }

  Future<void> updateDeliveryStatus({
    required int bookingId,
    required String deliveryStatus,
  }) async {
    try {
      final response = await _dio.patch(
        '${bookingManagementUrl}$bookingId/',
        data: {
          "delivery_status": deliveryStatus,
        },
      );

      log('status code: ${response.statusCode}, data: ${response.data}');
      if (response.statusCode == 400) {
        throw 'Delivery status can\'t be updated before pickup date';
      }
      if (response.statusCode != 200) {
        throw 'Failed to update delivery status';
      }
    } on DioException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateBooking(
      int bookingId, Map<String, dynamic> updatedData) async {
    try {
      final response = await _dio.patch(
        '${bookingManagementUrl}$bookingId/',
        data: updatedData,
      );

      log('status code: ${response.statusCode}, data: ${response.data}');
      if (response.statusCode == 200 || response.statusCode == 400) {
        return response.data;
      }

      throw 'Failed to update booking';
    } on DioException catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw e.message.toString();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw e;
    }
  }

  Future<void> deleteBooking(int bookingId) async {
    try {
      final response = await _dio.delete('${bookingManagementUrl}$bookingId/');

      log('status code: ${response.statusCode}, data: ${response.data}');
      if (response.statusCode == 400) {
        throw response.data['error'] ?? 'Failed to delete booking';
      }
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw 'Failed to delete booking';
      }
    } on DioException catch (e) {
      throw e.message.toString();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<PaginationModel<BookingsModel>> fetchBookingsPagination({
    required bool fetchCompleted,
    required int page,
    String? startDate,
    String? endDate,
  }) async {
    try {
      final response = await _dio.get(
        '${bookingManagementUrl}',
        queryParameters: {
          'page': page,
          'status': fetchCompleted ? 'completed' : 'upcoming',
          if (startDate != null) 'start_date': startDate.formatToUiDate(),
          if (endDate != null)
            'end_date': endDate.formatToUiDate(), //End date is optional
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final bookingsData = data['results']['bookings'] as List<dynamic>;

        final list =
            bookingsData.map((e) => BookingsModel.fromJson(e)).toList();
        log('count: ${data['count']}, next: ${data['next']}');
        return PaginationModel(
          data: list,
          totalData: data['count'],
          nextPageUrl: data['next'],
        );
      } else {
        print('start date: $startDate, end date: $endDate');
        log('status code: ${response.statusCode}, data: ${response.data}');
        throw Exception('Failed to load bookings');
      }
    } on DioException catch (e) {
      throw e.message.toString();
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }

  Future<List<BookingDetailsPaymentHistoryModel>> fetchPaymentHistory(
      int bookingId) async {
    try {
      final response =
          await _dio.get('${bookingManagementUrl}payment-details/$bookingId/');
      log(' status code: ${response.statusCode}, data: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['payments'] == null) return [];
        final paymentHistoryData = data['payments'] as List<dynamic>;

        return paymentHistoryData
            .map((e) => BookingDetailsPaymentHistoryModel.fromJson(e))
            .toList();
      } else {
        log('status code: ${response.statusCode}, data: ${response.data}');
        throw 'Failed to fetch payment history';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      throw e;
    }
  }

  Future<void> createOldBooking(AddBookingModel bookingData) async {
    try {
      final data = bookingData.toCustomJson();
      log('request old booking data: $data');
      final response = await _dio.post(
        '${bookingManagementUrl}/old-bookings/',
        data: data,
      );

      log('status code: ${response.statusCode}, data: ${response.data}');
      if (response.statusCode == 201 || response.statusCode == 200) {
        return;
      } else {
        throw response.data['error'] ??
            response.data['message'] ??
            'Failed to create booking';
      }
    } catch (e, stack) {
      log(e.toString(), stackTrace: stack);
      rethrow;
    }
  }
}
