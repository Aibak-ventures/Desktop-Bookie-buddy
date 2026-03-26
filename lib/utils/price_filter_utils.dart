import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';

/// Rounds a price value to the nearest "meaningful" boundary
/// (e.g. 1234 → 1000, 456 → 500).
double roundToMeaningfulNumber(double value) {
  if (value < 100) {
    return (value / 10).round() * 10.0;
  } else if (value < 1000) {
    return (value / 100).round() * 100.0;
  } else if (value < 10000) {
    return (value / 1000).round() * 1000.0;
  } else {
    return (value / 5000).round() * 5000.0;
  }
}

/// Generates a list of dynamic quick-filter chips based on [minPrice] and
/// [maxPrice].  Each entry has:
///   - `'label'`: display string
///   - `'range'`: [RangeValues] for the filter
List<Map<String, dynamic>> generateQuickFilters(
  double minPrice,
  double maxPrice,
) {
  final List<Map<String, dynamic>> filters = [];

  // Calculate dynamic ranges based on maxPrice
  double range1 = maxPrice * 0.1; // 10% of max
  double range2 = maxPrice * 0.25; // 25% of max
  double range3 = maxPrice * 0.5; // 50% of max
  double range4 = maxPrice * 0.75; // 75% of max

  // Round to nearest meaningful number
  range1 = roundToMeaningfulNumber(range1);
  range2 = roundToMeaningfulNumber(range2);
  range3 = roundToMeaningfulNumber(range3);
  range4 = roundToMeaningfulNumber(range4);

  // Ensure ranges are distinct and meaningful
  if (range1 > minPrice && range1 < maxPrice) {
    filters.add({
      'label': 'Under ${range1.toCurrency()}',
      'range': RangeValues(minPrice, range1),
    });
  }

  if (range2 > range1 && range2 < maxPrice) {
    filters.add({
      'label': '${range1.toCurrency()} - ${range2.toCurrency()}',
      'range': RangeValues(range1, range2),
    });
  }

  if (range3 > range2 && range3 < maxPrice) {
    filters.add({
      'label': '${range2.toCurrency()} - ${range3.toCurrency()}',
      'range': RangeValues(range2, range3),
    });
  }

  if (range4 > range3 && range4 < maxPrice) {
    filters.add({
      'label': '${range3.toCurrency()} - ${range4.toCurrency()}',
      'range': RangeValues(range3, range4),
    });
  }

  // Always add "Above X" filter
  if (range4 < maxPrice) {
    filters.add({
      'label': 'Above ${range4.toCurrency()}',
      'range': RangeValues(range4, maxPrice),
    });
  }

  // Fallback: if no meaningful ranges, create simple divisions
  if (filters.isEmpty) {
    final quarter = (maxPrice - minPrice) / 4;
    filters.addAll([
      {
        'label': 'Under ${(minPrice + quarter).toCurrency()}',
        'range': RangeValues(minPrice, minPrice + quarter),
      },
      {
        'label':
            '${(minPrice + quarter).toCurrency()} - ${(minPrice + 2 * quarter).toCurrency()}',
        'range': RangeValues(minPrice + quarter, minPrice + 2 * quarter),
      },
      {
        'label':
            '${(minPrice + 2 * quarter).toCurrency()} - ${(minPrice + 3 * quarter).toCurrency()}',
        'range': RangeValues(minPrice + 2 * quarter, minPrice + 3 * quarter),
      },
      {
        'label': 'Above ${(minPrice + 3 * quarter).toCurrency()}',
        'range': RangeValues(minPrice + 3 * quarter, maxPrice),
      },
    ]);
  }

  return filters;
}
