import 'package:bookie_buddy_web/features/booking/domain/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_details_model/staff_details_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_request_model/staff_request_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_analytics_model/staff_analytics_model.dart';

abstract interface class IStaffRepository {
  //
  Future<PaginationModel<StaffModel>> getStaffs({int page = 1});

  //
  Future<StaffDetailsModel> getStaffDetails(int staffId);

  //
  Future<StaffModel> addStaff(StaffRequestModel staffData);

  //
  Future<void> deleteStaff(int staffId);

  //
  Future<StaffModel> editStaff(StaffRequestModel staffData);

  //
  Future<StaffAnalyticsModel> getStaffAnalyticsReport({
    required int staffId,
    required int year,
    required int month,
  });

  //
  Future<PaginationModel<BookingsModel>> getStaffMonthlyBookingsPagination({
    required int staffId,
    required int year,
    required int month,
    int page = 1,
  });

  //
  Future<PaginationModel<SaleModel>> getStaffMonthlySalesPagination({
    required int staffId,
    required int year,
    required int month,
    int page = 1,
  });
}
