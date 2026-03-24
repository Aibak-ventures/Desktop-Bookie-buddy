import 'package:bookie_buddy_web/features/booking/domain/entities/booking_entity/booking_entity.dart';
import 'package:bookie_buddy_web/features/booking/data/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/dashboard_custom_work_model/dashboard_custom_work_model.dart';

class DashboardListModel {
  final bool isBooking;
  final BookingEntity? booking;
  final DashboardCustomWorkModel? customWork;
  const DashboardListModel({
    this.booking,
    this.customWork,
    required this.isBooking,
  });

  static DashboardListModel fromJson(Map<String, dynamic> item) {
    final type = item['type'] as String?;
    BookingEntity? booking;
    DashboardCustomWorkModel? customWork;
    final isBooking = type == 'booking';
    if (isBooking) {
      booking = BookingsModel.fromJson(item).toEntity();
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
