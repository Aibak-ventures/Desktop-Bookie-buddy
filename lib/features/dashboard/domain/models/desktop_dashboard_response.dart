import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'desktop_dashboard_response.freezed.dart';
part 'desktop_dashboard_response.g.dart';

@freezed
class DesktopDashboardResponse with _$DesktopDashboardResponse {
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
class DesktopDashboardCarouselData with _$DesktopDashboardCarouselData {
  const factory DesktopDashboardCarouselData({
    required int upcomingCount,
    required int alterationBookingCount,
    required int completedCount,
    required int expiredCount,
  }) = _DesktopDashboardCarouselData;

  factory DesktopDashboardCarouselData.fromJson(Map<String, dynamic> json) =>
      _$DesktopDashboardCarouselDataFromJson(json);

  factory DesktopDashboardCarouselData.empty() =>
      const DesktopDashboardCarouselData(
        upcomingCount: 0,
        alterationBookingCount: 0,
        completedCount: 0,
        expiredCount: 0,
      );
}

@freezed
class DesktopDashboardPagination with _$DesktopDashboardPagination {
  const factory DesktopDashboardPagination({
    @JsonKey(name: 'upcoming') required PaginationInfo upcoming,
    @JsonKey(name: 'ongoing') required PaginationInfo ongoing,
  }) = _DesktopDashboardPagination;

  factory DesktopDashboardPagination.fromJson(Map<String, dynamic> json) =>
      _$DesktopDashboardPaginationFromJson(json);
}

@freezed
class PaginationInfo with _$PaginationInfo {
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
  Map<String, List<BookingsModel>> get upcomingGrouped {
    return _groupBookingsByDate(upcoming, useReturnDate: false);
  }

  /// Groups returns (ongoing) bookings by Today, Tomorrow, and Upcoming based on return date
  Map<String, List<BookingsModel>> get returnsGrouped {
    return _groupBookingsByDate(ongoingBookings, useReturnDate: true);
  }

  /// Converts to carousel data for overview cards
  DesktopDashboardCarouselData get carouselData => DesktopDashboardCarouselData(
        upcomingCount: upcomingCount,
        alterationBookingCount: alterationBookingCount,
        completedCount: completedCount,
        expiredCount: expiredCount,
      );

  /// Pagination accessors for ongoing bookings (main paginated data)
  String? get nextPageUrl => pagination.ongoing.next;
  int get currentPage => pagination.ongoing.currentPage;
  int get totalPages => pagination.ongoing.totalPages;
}

/// Helper function to group bookings by date
Map<String, List<BookingsModel>> _groupBookingsByDate(
  List<BookingsModel> bookings, {
  required bool useReturnDate,
}) {
  final Map<String, List<BookingsModel>> grouped = {
    'today': <BookingsModel>[],
    'tomorrow': <BookingsModel>[],
    'upcoming': <BookingsModel>[],
  };

  final today = DateTime.now();
  final tomorrow = today.add(const Duration(days: 1));

  for (final booking in bookings) {
    final targetDateString =
        useReturnDate ? booking.returnDate : booking.pickupDate;

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
      final bookingDate =
          DateTime(targetDate.year, targetDate.month, targetDate.day);
      final todayDate = DateTime(today.year, today.month, today.day);
      final tomorrowDate =
          DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

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
