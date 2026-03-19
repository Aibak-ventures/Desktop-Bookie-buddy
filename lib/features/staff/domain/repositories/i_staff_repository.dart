import 'package:bookie_buddy_web/features/booking/domain/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/sales/domain/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_analytics_entity/staff_analytics_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_details_entity/staff_details_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_entity/staff_entity.dart';
import 'package:bookie_buddy_web/features/staff/domain/entities/staff_request_entity/staff_request_entity.dart';

abstract interface class IStaffRepository {
  //
  Future<PaginationModel<StaffEntity>> getStaffs({int page = 1});

  //
  Future<StaffDetailsEntity> getStaffDetails(int staffId);

  //
  Future<StaffEntity> addStaff(StaffRequestEntity staffData);

  //
  Future<void> deleteStaff(int staffId);

  //
  Future<StaffEntity> editStaff(StaffRequestEntity staffData);

  //
  Future<StaffAnalyticsEntity> getStaffAnalyticsReport({
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
