import 'dart:developer';
import 'dart:io';

import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/api/api_paths.dart';
import 'package:bookie_buddy_web/core/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/core/utils/download_file.dart';
import 'package:bookie_buddy_web/features/add_booking/models/request_booking_model/request_booking_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class BookingService {
  final _dio = DioClient.dio;
  final bookingManagementUrl = ApiPaths.bookings.bookingsV3;

  Future<CustomResponseModel> getBooking(int bookingId) async {
    try {
      final response = await _dio.get(
        '${ApiPaths.bookings.bookingsV5}$bookingId/',
      );
      // log('booking details response: ${response.realUri.toString()} , ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> addBooking(
    RequestBookingModel bookingData,
  ) async {
    try {
      final data = bookingData.toJson();

      log(data.toString());
      final response = await _dio.post(
        ApiPaths.bookings.bookingsV5,
        data: data,
      );

      log(
        'add booking response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error adding booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updatePayment({
    required int bookingId,
    required int amount,
    required String paymentMethod,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiPaths.bookings.addPayment}$bookingId/',
        data: {'amount': amount, 'payment_method': paymentMethod},
      );

      log(
        'update payment response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating payment: $e', stackTrace: stack);
      throw e;
    }
  }

  Future<CustomResponseModel> updateBookingStatus({
    required int bookingId,
    required String bookingStatus,
  }) async {
    try {
      final response = await _dio.patch(
        '${ApiPaths.bookings.updateBookingStatus}$bookingId/',
        data: {'booking_status': bookingStatus},
      );
      log(
        'update booking status response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating booking status: $e', stackTrace: stack);
      throw 'Failed to update booking status: $e';
    }
  }

  Future<CustomResponseModel> updateDeliveryStatus({
    required int bookingId,
    required String deliveryStatus,
  }) async {
    try {
      final response = await _dio.patch(
        '${ApiPaths.bookings.updateDeliveryStatus}$bookingId/',
        data: {'delivery_status': deliveryStatus},
      );

      log(
        'update delivery status response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating delivery status: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> updateBooking(
    int bookingId,
    RequestBookingModel updatedBooking,
  ) async {
    try {
      final response = await _dio.patch(
        '${ApiPaths.bookings.updateDetails}$bookingId/',
        data: updatedBooking.toJson(),
      );

      log(
        'update booking response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error updating booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> deleteBooking(int bookingId) async {
    try {
      final response = await _dio.delete('${bookingManagementUrl}$bookingId/');
      log(
        'delete booking response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error deleting booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> cancelBooking({
    required int bookingId,
    required int refundAmount,
    required String paymentMethod,
    required String refundReason,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiPaths.bookings.addPayment}$bookingId/',
        data: {
          'refund_amount': refundAmount,
          'payment_method': paymentMethod,
          'refund_reason': refundReason,
        },
      );
      log(
        'cancel booking response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error cancelling booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchBookingsPagination({
    required LoadBookingType status,
    required int page,
    String? startDate,
    String? endDate,
    String? searchQuery,
  }) async {
    try {
      final response = await _dio.get(
        '${bookingManagementUrl}',
        queryParameters: {
          'page': page,
          'status': status.value, // upcoming, completed, past, future, all
          'search': searchQuery,
          'start_date': startDate?.formatToUiDate(),
          'end_date': endDate?.formatToUiDate(), //End date is optional
        },
      );
      log(response.realUri.toString());
      // log('fetch bookings response: ${response.realUri.toString()}, data: ${response.data}');
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching bookings: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchPaymentHistory(int bookingId) async {
    try {
      final response = await _dio.get(
        '${bookingManagementUrl}payment-details/$bookingId/',
      );
      log(
        'fetch payment history response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching payment history: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> createOldBooking(
    RequestBookingModel bookingData,
  ) async {
    try {
      final data = bookingData.toJson();
      log('request old booking data: $data');
      final response = await _dio.post(
        ApiPaths.bookings.oldBookings,
        data: data,
      );

      log(
        'add old bookings response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error creating old booking: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel?> downloadBookingInvoice({
    required int bookingId,
    required String filePath,
  }) async {
    try {
      final url = ApiPaths.bookings.downloadBookingInvoice(bookingId);
      log('Downloading booking invoice from: $url');

      final response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        if (kIsWeb) {
          // For web, trigger browser download
          final fileName = filePath.split('/').last;
          downloadFileWeb(response.data, fileName);
          log('Invoice download triggered for web: $fileName');
        } else {
          // For mobile/desktop, save to file
          final file = File(filePath);
          await file.writeAsBytes(response.data);
          log('Invoice downloaded successfully to: $filePath');
        }
        return null; // Success, no error
      } else {
        log('Error downloading invoice: ${response.statusCode}');
        return CustomResponseModel(
          status: CustomResponseStatus.error,
          message: 'Failed to download invoice',
          devMessage: 'HTTP ${response.statusCode}',
          meta: null,
          data: null,
        );
      }
    } catch (e, stack) {
      log('Error downloading booking invoice: $e', stackTrace: stack);
      return CustomResponseModel(
        status: CustomResponseStatus.error,
        message: 'Failed to download invoice',
        devMessage: e.toString(),
        meta: null,
        data: null,
      );
    }
  }
}
