import 'package:bookie_buddy_web/core/common/models/pagination_model/pagination_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/carousel_data_model/carousel_data_model.dart';
import 'package:bookie_buddy_web/features/dashboard/domain/models/dashboard_list_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_model.freezed.dart';
// part 'dashboard_model.g.dart';

@freezed
abstract class DashboardModel with _$DashboardModel {
  const factory DashboardModel({
    required PaginationModel<DashboardListModel> data,
    required CarouselDataModel carousel,
  }) = _DashboardModel;

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    final bookings = PaginationModel.fromJson(
      json,
      (item) => DashboardListModel.fromJson(item as Map<String, dynamic>),
      customJsonParser: (dataJson, itemFromJson) {
        final upcoming =
            (dataJson as Map<String, dynamic>)['upcoming'] as List?;
        final ongoing = dataJson['ongoing_bookings'] as List?;
        return (upcoming ?? ongoing)
                ?.map((item) => itemFromJson(item))
                .toList() ??
            [];
      },
    );
    final carousel = CarouselDataModel.fromJson(
      json['data'] as Map<String, dynamic>,
    );
    return DashboardModel(data: bookings, carousel: carousel);
  }
}
