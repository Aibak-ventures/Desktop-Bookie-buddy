import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/models/pagination_model.dart';
import 'package:bookie_buddy_web/features/home/models/carousel_data_model/carousel_data_model.dart';
import 'package:bookie_buddy_web/features/home/services/dashboard_service.dart';

class DashboardRepository {
  final DashboardService _dashboardService;
  // final BookingSearchService _searchService;

  DashboardRepository(this._dashboardService);

  /// Fetch dashboard data
  Future<(PaginationModel<BookingsModel>, CarouselDataModel)> loadDashboardData(
      {int page = 1}) async {
    return await _dashboardService.fetchDashboardData(page);
  }

  // Future<List<BookingsModel>> searchBookings(String query) async {
  //   return await _searchService.searchUpcomingBookings(query);
  // }
}
