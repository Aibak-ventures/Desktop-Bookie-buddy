import 'dart:developer';

import 'package:bookie_buddy_web/core/network/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/network/endpoints/api_endpoints.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_request_model/staff_request_model.dart';
import 'package:dio/dio.dart';

class StaffRemoteDatasource {
  Dio get dio => DioClient.dio;

  Future<CustomResponseModel> fetchStaffs({required int page}) async {
    try {
      final response = await dio.get(
        ApiEndpoints.staff.staff,
        queryParameters: {'page': page},
      );
      log(response.realUri.toString());
      log(response.data.toString());
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching staffs: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchStaffDetails(int staffId) async {
    try {
      final response = await dio.get(ApiEndpoints.staff.staffById(staffId));
      log(
        'Fetch staff details response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching staff details: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> addStaff(StaffRequestModel staffData) async {
    try {
      final response = await dio.post(
        ApiEndpoints.staff.staff,
        data: staffData.toJson(),
      );
      log(
        'Add staff response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error adding staff: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> deleteStaff(int staffId) async {
    try {
      final response = await dio.delete(ApiEndpoints.staff.staffById(staffId));
      log(
        'Delete staff response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error deleting staff: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> editStaff(StaffRequestModel staffData) async {
    assert(staffData.id != null, 'Staff ID must not be null');
    try {
      final data = staffData.toJson();
      log('edit staff request body: $data');
      final response = await dio.patch(
        ApiEndpoints.staff.staffById(staffData.id!),
        data: data,
      );
      log(
        'Edit staff response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error editing staff: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchStaffAnalyticsReport({
    required int staffId,
    required int year,
    required int month,
  }) async {
    try {
      final response = await dio.get(
        ApiEndpoints.staff.staffAnalyticsReportById(staffId),
        queryParameters: {'year': year, 'month': month},
      );
      log(
        ' fetch staff analytics report response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log('Error fetching staff analytics report: $e', stackTrace: stack);
      rethrow;
    }
  }

  Future<CustomResponseModel> fetchStaffMonthlyBookingsOrSalesPagination({
    required int staffId,
    required int year,
    required int month,
    required AppMainFeatureType type,
    required int page,
  }) async {
    try {
      final response = await dio.post(
        ApiEndpoints.staff.staffMonthlyBookingsOrSales,
        data: {
          'page': page,
          'staff_id': staffId,
          'month': month,
          'year': year,
          'transaction_type': type.value,
        },
      );
      log(
        'fetch staff monthly bookings or sales response: ${response.realUri.toString()}, data: ${response.data}',
      );
      return CustomResponseModel.fromJson(response.data);
    } catch (e, stack) {
      log(
        'Error fetching staff monthly bookings or sales: $e',
        stackTrace: stack,
      );
      rethrow;
    }
  }
}
