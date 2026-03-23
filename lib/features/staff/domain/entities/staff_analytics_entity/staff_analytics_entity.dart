import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_analytics_entity.freezed.dart';

@freezed
abstract class StaffAnalyticsEntity with _$StaffAnalyticsEntity {
  const StaffAnalyticsEntity._();

  const factory StaffAnalyticsEntity({
    required int staffId,
    required String staffName,
    required int year,
    required Month month,
    required String monthName,
    required int totalBookingsCount,
    required int totalSalesCount,
    required int totalPendingsCount,
    required int totalBookingsAmount,
    required int totalSalesAmount,
    required int totalPendingAmount,
    required int totalAmount,
    required int performancePercent,
  }) = _StaffAnalyticsEntity;

  static StaffAnalyticsEntity empty({
    int? staffId,
    String? staffName,
    DateTime? date,
  }) {
    final now = date ?? DateTime.now();
    final month = Month.fromInt(now.month);

    return StaffAnalyticsEntity(
      staffId: staffId ?? 0,
      staffName: staffName ?? 'Staff',
      year: now.year,
      month: month,
      monthName: month.value,
      totalBookingsCount: 0,
      totalSalesCount: 0,
      totalPendingsCount: 0,
      totalBookingsAmount: 0,
      totalSalesAmount: 0,
      totalPendingAmount: 0,
      totalAmount: 0,
      performancePercent: 0,
    );
  }
}
