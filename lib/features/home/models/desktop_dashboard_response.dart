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
    @JsonKey(name: 'total_upcoming') required int totalUpcoming,
    @JsonKey(name: 'total_ongoing') required int totalOngoing,
    @JsonKey(name: 'total_completed') required int totalCompleted,
    @JsonKey(name: 'total_expired') required int totalExpired,
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'per_page') required int perPage,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_records') required int totalRecords,
    @JsonKey(name: 'prev_page_url') String? prevPageUrl,
    @JsonKey(name: 'next_page_url') String? nextPageUrl,
  }) = _DesktopDashboardResponse;

  factory DesktopDashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DesktopDashboardResponseFromJson(json);
}

@freezed
class DesktopDashboardCarouselData with _$DesktopDashboardCarouselData {
  const factory DesktopDashboardCarouselData({
    @JsonKey(name: 'total_upcoming') required int totalUpcoming,
    @JsonKey(name: 'total_ongoing') required int totalOngoing,
    @JsonKey(name: 'total_completed') required int totalCompleted,
    @JsonKey(name: 'total_expired') required int totalExpired,
  }) = _DesktopDashboardCarouselData;

  factory DesktopDashboardCarouselData.fromJson(Map<String, dynamic> json) =>
      _$DesktopDashboardCarouselDataFromJson(json);

  factory DesktopDashboardCarouselData.empty() =>
      const DesktopDashboardCarouselData(
        totalUpcoming: 0,
        totalOngoing: 0,
        totalCompleted: 0,
        totalExpired: 0,
      );
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
        totalUpcoming: totalUpcoming,
        totalOngoing: totalOngoing,
        totalCompleted: totalCompleted,
        totalExpired: totalExpired,
      );
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
      // Parse the string date to DateTime
      final targetDate = DateTime.parse(targetDateString);

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
