// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'desktop_dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DesktopDashboardResponseImpl _$$DesktopDashboardResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DesktopDashboardResponseImpl(
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
          json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DesktopDashboardResponseImplToJson(
        _$DesktopDashboardResponseImpl instance) =>
    <String, dynamic>{
      'upcoming': instance.upcoming,
      'ongoing_bookings': instance.ongoingBookings,
      'upcoming_count': instance.upcomingCount,
      'alteration_booking_count': instance.alterationBookingCount,
      'completed_count': instance.completedCount,
      'expired_count': instance.expiredCount,
      'pagination': instance.pagination,
    };

_$DesktopDashboardCarouselDataImpl _$$DesktopDashboardCarouselDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DesktopDashboardCarouselDataImpl(
      upcomingCount: (json['upcomingCount'] as num).toInt(),
      alterationBookingCount: (json['alterationBookingCount'] as num).toInt(),
      completedCount: (json['completedCount'] as num).toInt(),
      expiredCount: (json['expiredCount'] as num).toInt(),
    );

Map<String, dynamic> _$$DesktopDashboardCarouselDataImplToJson(
        _$DesktopDashboardCarouselDataImpl instance) =>
    <String, dynamic>{
      'upcomingCount': instance.upcomingCount,
      'alterationBookingCount': instance.alterationBookingCount,
      'completedCount': instance.completedCount,
      'expiredCount': instance.expiredCount,
    };

_$DesktopDashboardPaginationImpl _$$DesktopDashboardPaginationImplFromJson(
        Map<String, dynamic> json) =>
    _$DesktopDashboardPaginationImpl(
      upcoming:
          PaginationInfo.fromJson(json['upcoming'] as Map<String, dynamic>),
      ongoing: PaginationInfo.fromJson(json['ongoing'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DesktopDashboardPaginationImplToJson(
        _$DesktopDashboardPaginationImpl instance) =>
    <String, dynamic>{
      'upcoming': instance.upcoming,
      'ongoing': instance.ongoing,
    };

_$PaginationInfoImpl _$$PaginationInfoImplFromJson(Map<String, dynamic> json) =>
    _$PaginationInfoImpl(
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      count: (json['count'] as num).toInt(),
      pageSize: (json['page_size'] as num).toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      startIndex: (json['start_index'] as num).toInt(),
      endIndex: (json['end_index'] as num).toInt(),
    );

Map<String, dynamic> _$$PaginationInfoImplToJson(
        _$PaginationInfoImpl instance) =>
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
