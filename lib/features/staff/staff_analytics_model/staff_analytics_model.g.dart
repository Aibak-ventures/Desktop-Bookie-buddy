// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_analytics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StaffAnalyticsModelImpl _$$StaffAnalyticsModelImplFromJson(
  Map<String, dynamic> json,
) => _$StaffAnalyticsModelImpl(
  staffId: (json['staff_id'] as num).toInt(),
  staffName: json['staff_name'] as String,
  year: (json['year'] as num).toInt(),
  month: Month.fromInt((json['month'] as num).toInt()),
  monthName: json['month_name'] as String,
  totalBookingsCount: (json['total_bookings_count'] as num?)?.toInt() ?? 0,
  totalSalesCount: (json['total_sales_count'] as num?)?.toInt() ?? 0,
  totalPendingsCount:
      (json['total_bookings_pending_count'] as num?)?.toInt() ?? 0,
  totalBookingsAmount:
      (json['total_bookings_earned_amount'] as num?)?.toInt() ?? 0,
  totalSalesAmount: (json['total_sales_earning'] as num?)?.toInt() ?? 0,
  totalPendingAmount:
      (json['total_bookings_pending_amount'] as num?)?.toInt() ?? 0,
  totalAmount: (json['total_earning'] as num?)?.toInt() ?? 0,
  performancePercent: (json['performance_percent'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$StaffAnalyticsModelImplToJson(
  _$StaffAnalyticsModelImpl instance,
) => <String, dynamic>{
  'staff_id': instance.staffId,
  'staff_name': instance.staffName,
  'year': instance.year,
  'month_name': instance.monthName,
  'total_bookings_count': instance.totalBookingsCount,
  'total_sales_count': instance.totalSalesCount,
  'total_bookings_pending_count': instance.totalPendingsCount,
  'total_bookings_earned_amount': instance.totalBookingsAmount,
  'total_sales_earning': instance.totalSalesAmount,
  'total_bookings_pending_amount': instance.totalPendingAmount,
  'total_earning': instance.totalAmount,
  'performance_percent': instance.performancePercent,
};
