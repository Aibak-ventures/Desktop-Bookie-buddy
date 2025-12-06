import 'package:bookie_buddy_web/features/home/models/dashboard_list_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_grouped_model.freezed.dart';

@freezed
class BookingGroupedModel with _$BookingGroupedModel {
  const factory BookingGroupedModel({
    required String date,
    required List<DashboardListModel> bookings,
  }) = _BookingGroupedModel;
}
