import 'package:bookie_buddy_web/core/constants/enums/booking_list_filter_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_counts_entity.freezed.dart';

@freezed
abstract class StatusCountsEntity with _$StatusCountsEntity {
  const factory StatusCountsEntity({
    @Default(0) int completed,
    @Default(0) int upcoming,
    @Default(0) int returns,
    @Default(0) int pending,
    @Default(0) int notReturned,
    @Default(0) int cancelled,
  }) = _StatusCountsEntity;
}

extension StatusCountsEntityX on StatusCountsEntity {
  int get total =>
      completed + upcoming + returns + pending + notReturned + cancelled;

  int fromFilter(BookingListFilter filter) {
    switch (filter) {
      case BookingListFilter.upcoming:
        return upcoming;
      case BookingListFilter.returns:
        return returns;
      case BookingListFilter.pending:
        return pending;
      case BookingListFilter.notReturned:
        return notReturned;
      case BookingListFilter.completed:
        return completed;
      case BookingListFilter.cancelled:
        return cancelled;
    }
  }
}
