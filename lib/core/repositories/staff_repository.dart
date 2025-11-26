import 'dart:developer';

import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/core/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/core/models/staff_details_model/staff_details_model.dart';
import 'package:bookie_buddy_web/core/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/models/staff_request_model/staff_request_model.dart';
import 'package:bookie_buddy_web/core/services/staff_service.dart';
import 'package:bookie_buddy_web/core/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/staff/staff_analytics_model/staff_analytics_model.dart';

class StaffRepository {
  final StaffService _service;
  StaffRepository(this._service);

  Future<PaginationModel<StaffModel>> getStaffs({int page = 1}) async {
    try {
      final response = await safeApiCall(
        () => _service.fetchStaffs(page: page),
      );

      if (response.status.isSuccess) {
        return PaginationModel.fromJson(
          response.data,
          (json) => StaffModel.fromJson(json as Map<String, dynamic>),
        );
      }
      log('Error in getStaffs: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error in getStaffs: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<StaffDetailsModel> getStaffDetails(int staffId) async {
    try {
      final response = await safeApiCall(
        () => _service.fetchStaffDetails(staffId),
      );

      if (response.status.isSuccess) {
        return StaffDetailsModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      log('Error in getStaffDetails: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error in getStaffDetails: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<StaffModel> addStaff(StaffRequestModel staffData) async {
    try {
      final response = await safeApiCall(() => _service.addStaff(staffData));

      if (response.status.isSuccess) {
        return StaffModel.fromJson(response.data as Map<String, dynamic>);
      }
      log('Error in addStaff: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error in addStaff: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<void> deleteStaff(int staffId) async {
    try {
      final response = await safeApiCall(() => _service.deleteStaff(staffId));

      if (response.status.isSuccess) {
        return;
      }
      log('Error in deleteStaff: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error in deleteStaff: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<StaffModel> editStaff(StaffRequestModel staffData) async {
    try {
      final response = await safeApiCall(() => _service.editStaff(staffData));

      if (response.status.isSuccess) {
        return StaffModel.fromJson(response.data as Map<String, dynamic>);
      }
      log('Error in editStaff: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error in editStaff: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<StaffAnalyticsModel> getStaffAnalyticsReport({
    required int staffId,
    required int year,
    required int month,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.fetchStaffAnalyticsReport(
          staffId: staffId,
          year: year,
          month: month,
        ),
      );
      if (response.status.isSuccess) {
        return StaffAnalyticsModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }
      log('Error in fetchStaffAnalyticsReport: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error in fetchStaffAnalyticsReport: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<PaginationModel<BookingsModel>> getStaffMonthlyBookingsPagination({
    required int staffId,
    required int year,
    required int month,
    int page = 1,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.fetchStaffMonthlyBookingsOrSalesPagination(
          page: page,
          staffId: staffId,
          year: year,
          month: month,
          type: AppMainFeatureType.bookings,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel<BookingsModel>.fromJson(
          response.data as Map<String, dynamic>,
          (json) => BookingsModel.fromJson(json as Map<String, dynamic>),
        );
      }
      log(
        'Error in fetchStaffMonthlyBookingsPagination: ${response.devMessage}',
      );
      throw response.message;
    } catch (e, stack) {
      log(
        'Error in fetchStaffMonthlyBookingsPagination: $e',
        stackTrace: stack,
      );
      rethrow;
    }
  }

  Future<PaginationModel<SaleModel>> getStaffMonthlySalesPagination({
    required int staffId,
    required int year,
    required int month,
    int page = 1,
  }) async {
    try {
      final response = await safeApiCall(
        () => _service.fetchStaffMonthlyBookingsOrSalesPagination(
          page: page,
          staffId: staffId,
          year: year,
          month: month,
          type: AppMainFeatureType.sales,
        ),
      );
      if (response.status.isSuccess) {
        return PaginationModel<SaleModel>.fromJson(
          response.data as Map<String, dynamic>,
          (json) => SaleModel.fromJson(json as Map<String, dynamic>),
        );
      }
      log('Error in fetchStaffMonthlySalesPagination: ${response.devMessage}');
      throw response.message;
    } catch (e, stack) {
      log('Error in fetchStaffMonthlySalesPagination: $e', stackTrace: stack);
      rethrow;
    }
  }
}
