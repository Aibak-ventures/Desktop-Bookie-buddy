import 'package:bookie_buddy_web/core/constants/enums/booking_list_filter_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_counts_entity.freezed.dart';

@freezed
abstract class StatusCountsEntity with _$StatusCountsEntity {
  const factory StatusCountsEntity({
    @Default(<BookingListFilter, int>{}) Map<BookingListFilter, int> counts,
  }) = _StatusCountsEntity;
}

extension StatusCountsEntityX on StatusCountsEntity {
  int fromFilter(BookingListFilter filter) => counts[filter] ?? 0;
}
