import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';

class DateFilter {
  final DateTime? startDate;
  final DateTime? endDate;

  const DateFilter({this.startDate, this.endDate});

  bool get hasActiveFilter => startDate != null || endDate != null;

  DateFilter copyWith({DateTime? startDate, DateTime? endDate}) =>
      DateFilter(startDate: startDate, endDate: endDate);

  DateFilter clear() => const DateFilter();

  String get getFilterDisplayText {
    // final startDate = dateFilterNotifier.value.startDate;
    // final endDate = dateFilterNotifier.value.endDate;

    if (startDate != null && endDate != null) {
      if (startDate!.isAtSameMomentAs(endDate!)) {
        return 'Filtered by: ${startDate!.format()}';
      } else {
        return 'Filtered by: ${startDate!.format()} - ${endDate!.format()}';
      }
    } else if (startDate != null) {
      return 'From: ${startDate!.format()}';
    } else if (endDate != null) {
      return 'Until: ${endDate!.format()}';
    }
    return 'Date filter active';
  }
}
