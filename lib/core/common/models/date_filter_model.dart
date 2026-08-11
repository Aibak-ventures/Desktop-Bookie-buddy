import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';

class DateFilterModel {
  final DateTime? startDate;
  final DateTime? endDate;
  final Map<String, bool> additionalFilters;

  const DateFilterModel({
    this.startDate,
    this.endDate,
    this.additionalFilters = const {},
  });

  bool get hasActiveFilter =>
      startDate != null || endDate != null || additionalFilters.isNotEmpty;

  DateFilterModel copyWith({
    DateTime? startDate,
    DateTime? endDate,
    Map<String, bool>? additionalFilters,
  }) => DateFilterModel(
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    additionalFilters: additionalFilters ?? this.additionalFilters,
  );

  DateFilterModel clear() => const DateFilterModel();

  bool getFilter(String key) => additionalFilters[key] ?? false;

  /// This will add [key] to [additionalFilters] when [value] is true and remove if false
  DateFilterModel setFilter(String key, bool value) {
    final updatedFilters = Map<String, bool>.from(additionalFilters);

    if (value == true) {
      updatedFilters[key] = value;
    } else {
      updatedFilters.remove(key);
    }
    return copyWith(additionalFilters: updatedFilters);
  }

  /// Get active filter labels for display
  List<String> get activeFilterKeys {
    final labels = <String>[];
    for (final entry in additionalFilters.entries) {
      if (entry.value) {
        labels.add(entry.key);
      }
    }
    return labels;
  }

  String get getFilterDisplayText {
    final parts = <String>[];

    // Date filter text
    if (startDate != null && endDate != null) {
      if (startDate!.isAtSameMomentAs(endDate!)) {
        parts.add('Date: ${startDate!.format()}');
      } else {
        parts.add('${startDate!.format()} - ${endDate!.format()}');
      }
    } else if (startDate != null) {
      parts.add('From: ${startDate!.format()}');
    } else if (endDate != null) {
      parts.add('Until: ${endDate!.format()}');
    }

    // Additional filters
    if (activeFilterKeys.isNotEmpty) {
      parts.add(
        activeFilterKeys.map((e) => e.capitalizeFirstLetter()).join(', '),
      );
    }

    return parts.isEmpty ? 'Filter active' : parts.join(' • ');
  }
}
