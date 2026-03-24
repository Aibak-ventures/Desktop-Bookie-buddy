import 'package:freezed_annotation/freezed_annotation.dart';

part 'desktop_dashboard_carousel_entity.freezed.dart';

@freezed
abstract class DesktopDashboardCarouselEntity
    with _$DesktopDashboardCarouselEntity {
  const factory DesktopDashboardCarouselEntity({
    required int upcomingCount,
    required int alterationBookingCount,
    required int completedCount,
    required int expiredCount,
  }) = _DesktopDashboardCarouselEntity;

  factory DesktopDashboardCarouselEntity.empty() =>
      const DesktopDashboardCarouselEntity(
        upcomingCount: 0,
        alterationBookingCount: 0,
        completedCount: 0,
        expiredCount: 0,
      );
}
