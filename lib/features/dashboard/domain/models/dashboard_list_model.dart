import 'package:bookie_buddy_web/features/booking/domain/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/dashboard_custom_work_model/dashboard_custom_work_model.dart';

class DashboardListModel {
  final bool isBooking;
  final BookingsModel? booking;
  final DashboardCustomWorkModel? customWork;
  const DashboardListModel({
    this.booking,
    this.customWork,
    required this.isBooking,
  });

  static DashboardListModel fromJson(Map<String, dynamic> item) {
    final type = item['type'] as String?;
    BookingsModel? booking;
    DashboardCustomWorkModel? customWork;
    final isBooking = type == 'booking';
    if (isBooking) {
      booking = BookingsModel.fromJson(item);
    } else {
      customWork = DashboardCustomWorkModel.fromJson(item);
    }
    return DashboardListModel(
      isBooking: isBooking,
      booking: booking,
      customWork: customWork,
    );
  }
}
