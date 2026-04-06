import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_carousel_entity/desktop_dashboard_carousel_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'desktop_dashboard_entity.freezed.dart';

@freezed
abstract class DesktopDashboardEntity with _$DesktopDashboardEntity {
  const factory DesktopDashboardEntity({
    required List<BookingEntity> upcoming,
    required List<BookingEntity> ongoingBookings,
    required DesktopDashboardCarouselEntity carouselData,
    required String? nextPageUrl,
    required int currentPage,
    required int totalPages,
  }) = _DesktopDashboardEntity;
}
