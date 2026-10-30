import 'package:bookie_buddy_web/core/constants/enums/booking_list_filter_enum.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/status_counts_entity/status_counts_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_counts_model.freezed.dart';

/// `status_counts` from the bookings list API: a flat map of
/// [BookingListFilter.value] → count. Keys are read from the enum, so a new
/// filter only needs a new [BookingListFilter] value.
@Freezed(fromJson: false, toJson: false)
abstract class StatusCountsModel with _$StatusCountsModel {
  const factory StatusCountsModel({
    @Default(<BookingListFilter, int>{}) Map<BookingListFilter, int> counts,
  }) = _StatusCountsModel;

  factory StatusCountsModel.fromJson(Map<String, dynamic> json) =>
      StatusCountsModel(
        counts: {
          for (final filter in BookingListFilter.values)
            if (json[filter.value] case final num count) filter: count.toInt(),
        },
      );
}

extension StatusCountsModelMapper on StatusCountsModel {
  StatusCountsEntity toEntity() => StatusCountsEntity(counts: counts);
}
