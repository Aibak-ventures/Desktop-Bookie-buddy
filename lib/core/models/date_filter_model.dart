import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';

class DateFilterModel {
  final DateTime? startDate;
  final DateTime? endDate;

  const DateFilterModel({this.startDate, this.endDate});

  bool get hasActiveFilter => startDate != null || endDate != null;

  DateFilterModel copyWith({DateTime? startDate, DateTime? endDate}) =>
      DateFilterModel(startDate: startDate, endDate: endDate);

  DateFilterModel clear() => const DateFilterModel();

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
