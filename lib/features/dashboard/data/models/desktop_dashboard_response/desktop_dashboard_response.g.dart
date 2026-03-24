// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desktop_dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DesktopDashboardResponse _$DesktopDashboardResponseFromJson(
  Map<String, dynamic> json,
) => _DesktopDashboardResponse(
  upcoming: (json['upcoming'] as List<dynamic>)
      .map((e) => BookingsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  ongoingBookings: (json['ongoing_bookings'] as List<dynamic>)
      .map((e) => BookingsModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  upcomingCount: (json['upcoming_count'] as num).toInt(),
  alterationBookingCount: (json['alteration_booking_count'] as num).toInt(),
  completedCount: (json['completed_count'] as num).toInt(),
  expiredCount: (json['expired_count'] as num).toInt(),
  pagination: DesktopDashboardPagination.fromJson(
    json['pagination'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$DesktopDashboardResponseToJson(
  _DesktopDashboardResponse instance,
) => <String, dynamic>{
  'upcoming': instance.upcoming,
  'ongoing_bookings': instance.ongoingBookings,
  'upcoming_count': instance.upcomingCount,
  'alteration_booking_count': instance.alterationBookingCount,
  'completed_count': instance.completedCount,
  'expired_count': instance.expiredCount,
  'pagination': instance.pagination,
};

_DesktopDashboardCarouselModel _$DesktopDashboardCarouselModelFromJson(
  Map<String, dynamic> json,
) => _DesktopDashboardCarouselModel(
  upcomingCount: (json['upcomingCount'] as num).toInt(),
  alterationBookingCount: (json['alterationBookingCount'] as num).toInt(),
  completedCount: (json['completedCount'] as num).toInt(),
  expiredCount: (json['expiredCount'] as num).toInt(),
);

Map<String, dynamic> _$DesktopDashboardCarouselModelToJson(
  _DesktopDashboardCarouselModel instance,
) => <String, dynamic>{
  'upcomingCount': instance.upcomingCount,
  'alterationBookingCount': instance.alterationBookingCount,
  'completedCount': instance.completedCount,
  'expiredCount': instance.expiredCount,
};

_DesktopDashboardPagination _$DesktopDashboardPaginationFromJson(
  Map<String, dynamic> json,
) => _DesktopDashboardPagination(
  upcoming: PaginationInfo.fromJson(json['upcoming'] as Map<String, dynamic>),
  ongoing: PaginationInfo.fromJson(json['ongoing'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DesktopDashboardPaginationToJson(
  _DesktopDashboardPagination instance,
) => <String, dynamic>{
  'upcoming': instance.upcoming,
  'ongoing': instance.ongoing,
};

_PaginationInfo _$PaginationInfoFromJson(Map<String, dynamic> json) =>
    _PaginationInfo(
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      count: (json['count'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      startIndex: (json['start_index'] as num).toInt(),
      endIndex: (json['end_index'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationInfoToJson(_PaginationInfo instance) =>
    <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
      'count': instance.count,
      'page_size': instance.pageSize,
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
      'start_index': instance.startIndex,
      'end_index': instance.endIndex,
    };
