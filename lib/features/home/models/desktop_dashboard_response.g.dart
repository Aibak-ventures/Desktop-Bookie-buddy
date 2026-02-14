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
      totalUpcoming: (json['total_upcoming'] as num).toInt(),
      totalOngoing: (json['total_ongoing'] as num).toInt(),
      totalCompleted: (json['total_completed'] as num).toInt(),
      totalExpired: (json['total_expired'] as num).toInt(),
      currentPage: (json['current_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalRecords: (json['total_records'] as num).toInt(),
      prevPageUrl: json['prev_page_url'] as String?,
      nextPageUrl: json['next_page_url'] as String?,
    );

Map<String, dynamic> _$$DesktopDashboardResponseImplToJson(
        _$DesktopDashboardResponseImpl instance) =>
    <String, dynamic>{
      'upcoming': instance.upcoming,
      'ongoing_bookings': instance.ongoingBookings,
      'total_upcoming': instance.totalUpcoming,
      'total_ongoing': instance.totalOngoing,
      'total_completed': instance.totalCompleted,
      'total_expired': instance.totalExpired,
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total_pages': instance.totalPages,
      'total_records': instance.totalRecords,
      'prev_page_url': instance.prevPageUrl,
      'next_page_url': instance.nextPageUrl,
    };

_$DesktopDashboardCarouselDataImpl _$$DesktopDashboardCarouselDataImplFromJson(
        Map<String, dynamic> json) =>
    _$DesktopDashboardCarouselDataImpl(
      totalUpcoming: (json['total_upcoming'] as num).toInt(),
      totalOngoing: (json['total_ongoing'] as num).toInt(),
      totalCompleted: (json['total_completed'] as num).toInt(),
      totalExpired: (json['total_expired'] as num).toInt(),
    );

Map<String, dynamic> _$$DesktopDashboardCarouselDataImplToJson(
        _$DesktopDashboardCarouselDataImpl instance) =>
    <String, dynamic>{
      'total_upcoming': instance.totalUpcoming,
      'total_ongoing': instance.totalOngoing,
      'total_completed': instance.totalCompleted,
      'total_expired': instance.totalExpired,
    };
