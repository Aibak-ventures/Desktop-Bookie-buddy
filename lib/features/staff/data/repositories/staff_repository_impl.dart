import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/features/staff/data/models/staff_details_model/staff_details_model.dart';
import 'package:bookie_buddy_web/features/staff/data/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/features/staff/data/models/staff_request_model/staff_request_model.dart';
import 'package:bookie_buddy_web/features/staff/data/datasources/staff_remote_datasource.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_analytics_entity/staff_analytics_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_details_entity/staff_details_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_entity/staff_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_request_entity/staff_request_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/repositories/i_staff_repository.dart';
import 'package:bookie_buddy_web/utils/safe_api_call.dart';
import 'package:bookie_buddy_web/features/staff/data/models/staff_analytics_model/staff_analytics_model.dart';

class StaffRepositoryImpl implements IStaffRepository {
  final StaffRemoteDatasource _service;
  StaffRepositoryImpl(this._service);

  @override
  Future<PaginationModel<StaffEntity>> getStaffs({int page = 1}) async {
    try {
      final response = await safeApiCall(
        () => _service.fetchStaffs(page: page),
      );

      if (response.status.isSuccess) {
        return PaginationModel.fromJson(
          response.data,
          (json) =>
              StaffModel.fromJson(json as Map<String, dynamic>).toEntity(),
        );
      }
      log('Error in getStaffs: ${response.devMessage}');
      throw response.message ?? 'Failed to get staff list';
    } catch (e, stack) {
      log('Error in getStaffs: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<StaffDetailsEntity> getStaffDetails(int staffId) async {
    try {
      final response = await safeApiCall(
        () => _service.fetchStaffDetails(staffId),
      );

      if (response.status.isSuccess) {
        return StaffDetailsModel.fromJson(
          response.data as Map<String, dynamic>,
        ).toEntity();
      }
      log('Error in getStaffDetails: ${response.devMessage}');
      throw response.message ?? 'Failed to get staff details';
    } catch (e, stack) {
      log('Error in getStaffDetails: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<StaffEntity> addStaff(StaffRequestEntity staffData) async {
    try {
      final response = await safeApiCall(
          () => _service.addStaff(StaffRequestModel.fromEntity(staffData)));

      if (response.status.isSuccess) {
        return StaffModel.fromJson(response.data as Map<String, dynamic>)
            .toEntity();
      }
      log('Error in addStaff: ${response.devMessage}');
      throw response.message ?? 'Failed to add staff';
    } catch (e, stack) {
      log('Error in addStaff: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<void> deleteStaff(int staffId) async {
    try {
      final response = await safeApiCall(() => _service.deleteStaff(staffId));

      if (response.status.isSuccess) {
        return;
      }
      log('Error in deleteStaff: ${response.devMessage}');
      throw response.message ?? 'Failed to delete staff';
    } catch (e, stack) {
      log('Error in deleteStaff: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<StaffEntity> editStaff(StaffRequestEntity staffData) async {
    try {
      final response = await safeApiCall(
          () => _service.editStaff(StaffRequestModel.fromEntity(staffData)));

      if (response.status.isSuccess) {
        return StaffModel.fromJson(response.data as Map<String, dynamic>)
            .toEntity();
      }
      log('Error in editStaff: ${response.devMessage}');
      throw response.message ?? 'Failed to edit staff';
    } catch (e, stack) {
      log('Error in editStaff: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
  Future<StaffAnalyticsEntity> getStaffAnalyticsReport({
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
        ).toEntity();
      }
      log('Error in fetchStaffAnalyticsReport: ${response.devMessage}');
      throw response.message ?? 'Failed to get staff analytics report';
    } catch (e, stack) {
      log('Error in fetchStaffAnalyticsReport: $e', stackTrace: stack);
      rethrow;
    }
  }

  @override
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
      throw response.message ?? 'Failed to get staff monthly bookings';
    } catch (e, stack) {
      log(
        'Error in fetchStaffMonthlyBookingsPagination: $e',
        stackTrace: stack,
      );
      rethrow;
    }
  }

  @override
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
      throw response.message ?? 'Failed to get staff monthly sales';
    } catch (e, stack) {
      log('Error in fetchStaffMonthlySalesPagination: $e', stackTrace: stack);
      rethrow;
    }
  }
}
