import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_carousel_entity/desktop_dashboard_carousel_entity.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/entities/desktop_dashboard_entity/desktop_dashboard_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'desktop_dashboard_response.freezed.dart';
part 'desktop_dashboard_response.g.dart';

@freezed
abstract class DesktopDashboardResponse with _$DesktopDashboardResponse {
  const factory DesktopDashboardResponse({
    @JsonKey(name: 'upcoming') required List<BookingsModel> upcoming,
    @JsonKey(name: 'ongoing_bookings')
    required List<BookingsModel> ongoingBookings,
    @JsonKey(name: 'upcoming_count') required int upcomingCount,
    @JsonKey(name: 'alteration_booking_count')
    required int alterationBookingCount,
    @JsonKey(name: 'completed_count') required int completedCount,
    @JsonKey(name: 'expired_count') required int expiredCount,
    @JsonKey(name: 'pagination') required DesktopDashboardPagination pagination,
  }) = _DesktopDashboardResponse;

  factory DesktopDashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DesktopDashboardResponseFromJson(json);
}

@freezed
abstract class DesktopDashboardCarouselModel
    with _$DesktopDashboardCarouselModel {
  const factory DesktopDashboardCarouselModel({
    required int upcomingCount,
    required int alterationBookingCount,
    required int completedCount,
    required int expiredCount,
  }) = _DesktopDashboardCarouselModel;

  factory DesktopDashboardCarouselModel.fromJson(Map<String, dynamic> json) =>
      _$DesktopDashboardCarouselModelFromJson(json);

  factory DesktopDashboardCarouselModel.empty() =>
      const DesktopDashboardCarouselModel(
        upcomingCount: 0,
        alterationBookingCount: 0,
        completedCount: 0,
        expiredCount: 0,
      );
}

@freezed
abstract class DesktopDashboardPagination with _$DesktopDashboardPagination {
  const factory DesktopDashboardPagination({
    @JsonKey(name: 'upcoming') required PaginationInfo upcoming,
    @JsonKey(name: 'ongoing') required PaginationInfo ongoing,
  }) = _DesktopDashboardPagination;

  factory DesktopDashboardPagination.fromJson(Map<String, dynamic> json) =>
      _$DesktopDashboardPaginationFromJson(json);
}

@freezed
abstract class PaginationInfo with _$PaginationInfo {
  const factory PaginationInfo({
    String? next,
    String? previous,
    required int count,
    @JsonKey(name: 'page_size') required int pageSize,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'start_index') required int startIndex,
    @JsonKey(name: 'end_index') required int endIndex,
  }) = _PaginationInfo;

  factory PaginationInfo.fromJson(Map<String, dynamic> json) =>
      _$PaginationInfoFromJson(json);
}

/// Extension to provide grouped data by Today/Tomorrow/Upcoming for UI presentation
extension DesktopDashboardResponseExtensions on DesktopDashboardResponse {
  /// Groups upcoming bookings by Today, Tomorrow, and Upcoming based on pickup date
  Map<String, List<BookingEntity>> get upcomingGrouped {
    return _groupBookingsByDate(
      upcoming.map((e) => e.toEntity()).toList(),
      useReturnDate: false,
    );
  }

  /// Groups returns (ongoing) bookings by Today, Tomorrow, and Upcoming based on return date
  Map<String, List<BookingEntity>> get returnsGrouped {
    return _groupBookingsByDate(
      ongoingBookings.map((e) => e.toEntity()).toList(),
      useReturnDate: true,
    );
  }

  /// Converts to carousel data for overview cards
  DesktopDashboardCarouselModel get carouselData =>
      DesktopDashboardCarouselModel(
        upcomingCount: upcomingCount,
        alterationBookingCount: alterationBookingCount,
        completedCount: completedCount,
        expiredCount: expiredCount,
      );

  /// Returns a combined next-page URL that advances whichever list(s) still
  /// have pages remaining. Both page numbers are always included so the API
  /// returns the correct slice for each list in a single request.
  String? get nextPageUrl {
    final hasMoreUpcoming = pagination.upcoming.next != null;
    final hasMoreOngoing = pagination.ongoing.next != null;

    if (!hasMoreUpcoming && !hasMoreOngoing) return null;

    final upcomingNextPage = hasMoreUpcoming
        ? pagination.upcoming.currentPage + 1
        : pagination.upcoming.currentPage;
    final ongoingNextPage = hasMoreOngoing
        ? pagination.ongoing.currentPage + 1
        : pagination.ongoing.currentPage;

    return '?upcoming_page=$upcomingNextPage&ongoing_page=$ongoingNextPage';
  }

  int get currentPage => pagination.ongoing.currentPage;
  int get totalPages => pagination.ongoing.totalPages;
}

/// Helper function to group bookings by date
Map<String, List<BookingEntity>> _groupBookingsByDate(
  List<BookingEntity> bookings, {
  required bool useReturnDate,
}) {
  final Map<String, List<BookingEntity>> grouped = {
    'today': <BookingEntity>[],
    'tomorrow': <BookingEntity>[],
    'upcoming': <BookingEntity>[],
  };

  final today = DateTime.now();
  final tomorrow = today.add(const Duration(days: 1));

  for (final booking in bookings) {
    final targetDateString = useReturnDate
        ? booking.returnDate
        : booking.pickupDate;

    // Skip bookings with null dates
    if (targetDateString == null || targetDateString.isEmpty) continue;

    try {
      // Parse the string date - handle DD-MM-YYYY HH:mm:ss format
      DateTime targetDate;

      if (targetDateString.contains('-') &&
          targetDateString.split('-').length == 3) {
        // Handle DD-MM-YYYY HH:mm:ss format from API
        final parts = targetDateString.split(' ');
        final datePart = parts[0];
        final dateComponents = datePart.split('-');

        if (dateComponents.length == 3) {
          final day = int.parse(dateComponents[0]);
          final month = int.parse(dateComponents[1]);
          final year = int.parse(dateComponents[2]);
          targetDate = DateTime(year, month, day);
        } else {
          continue; // Skip invalid date format
        }
      } else {
        // Try to parse as ISO format (fallback)
        targetDate = DateTime.parse(targetDateString);
      }

      // Reset time to compare dates only
      final bookingDate = DateTime(
        targetDate.year,
        targetDate.month,
        targetDate.day,
      );
      final todayDate = DateTime(today.year, today.month, today.day);
      final tomorrowDate = DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
      );

      if (bookingDate == todayDate) {
        grouped['today']!.add(booking);
      } else if (bookingDate == tomorrowDate) {
        grouped['tomorrow']!.add(booking);
      } else {
        grouped['upcoming']!.add(booking);
      }
    } catch (e) {
      // Skip bookings with invalid date formats
      continue;
    }
  }

  return grouped;
}

extension DesktopDashboardCarouselModelMapper on DesktopDashboardCarouselModel {
  DesktopDashboardCarouselEntity toEntity() => DesktopDashboardCarouselEntity(
    upcomingCount: upcomingCount,
    alterationBookingCount: alterationBookingCount,
    completedCount: completedCount,
    expiredCount: expiredCount,
  );
}

extension DesktopDashboardResponseMapper on DesktopDashboardResponse {
  DesktopDashboardEntity toEntity() => DesktopDashboardEntity(
    upcoming: upcoming.map((e) => e.toEntity()).toList(),
    ongoingBookings: ongoingBookings.map((e) => e.toEntity()).toList(),
    carouselData: carouselData.toEntity(),
    nextPageUrl: nextPageUrl,
    currentPage: currentPage,
    totalPages: totalPages,
  );
}
