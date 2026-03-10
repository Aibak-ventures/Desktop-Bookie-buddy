import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'staff_analytics_model.freezed.dart';
part 'staff_analytics_model.g.dart';

@freezed
class StaffAnalyticsModel with _$StaffAnalyticsModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StaffAnalyticsModel({
    required int staffId,
    required String staffName,
    required int year,
    @JsonKey(fromJson: Month.fromInt, includeToJson: false)
    required Month month,
    required String monthName,
    @JsonKey(name: 'total_bookings_count', defaultValue: 0)
    required int totalBookingsCount,
    @JsonKey(name: 'total_sales_count', defaultValue: 0)
    required int totalSalesCount,
    @JsonKey(name: 'total_bookings_pending_count', defaultValue: 0)
    required int totalPendingsCount,
    @JsonKey(name: 'total_bookings_earned_amount', defaultValue: 0)
    required int totalBookingsAmount,
    @JsonKey(name: 'total_sales_earning', defaultValue: 0)
    required int totalSalesAmount,
    @JsonKey(name: 'total_bookings_pending_amount', defaultValue: 0)
    required int totalPendingAmount,
    @JsonKey(name: 'total_earning', defaultValue: 0) required int totalAmount,
    @JsonKey(name: 'performance_percent', defaultValue: 0)
    required int performancePercent,
  }) = _StaffAnalyticsModel;

  factory StaffAnalyticsModel.fromJson(Map<String, dynamic> json) =>
      _$StaffAnalyticsModelFromJson(json);

  static StaffAnalyticsModel empty({
    int? staffId,
    String? staffName,
    DateTime? date,
  }) {
    final now = date ?? DateTime.now();

    final year = now.year;
    final month = Month.fromInt(now.month);

    return StaffAnalyticsModel(
      staffId: staffId ?? 0,
      staffName: staffName ?? 'Staff',
      year: year,
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
