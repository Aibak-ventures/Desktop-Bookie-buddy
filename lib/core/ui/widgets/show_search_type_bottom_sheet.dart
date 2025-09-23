import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSearchTypeBottomSheet({
  required BuildContext context,
  required List<String> searchTypes,
  required ValueNotifier<int> selectedSearchTypeIndex,
  required void Function(String type, int index) onTap,
  // Price filter parameters
  required ValueNotifier<RangeValues> priceRange,
  required double minPrice,
  required ValueNotifier<double> maxPriceNotifier, // Changed to ValueNotifier
  required void Function(RangeValues range) onPriceChanged,
  required ValueNotifier<bool> isPriceFilterEnabled, // New parameter
  required void Function(
    int type,
    RangeValues range,
    bool isPriceEnabled,
  ) onApply,
}) {
  final TextEditingController maxPriceController = TextEditingController();

  showCustomBottomSheet(
    context,
    initialChildSize: 0.8,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        Text(
          "Search & Filter",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),

        const Divider(),

        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search Type",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: searchTypes.asMap().entries.map((entry) {
                    final index = entry.key;
                    final type = entry.value;
                    return ValueListenableBuilder(
                      valueListenable: selectedSearchTypeIndex,
                      builder: (context, value, child) {
                        final isSelected =
                            selectedSearchTypeIndex.value == index;
                        return FilterChip(
                          selected: isSelected,
                          label: Text(
                            type,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                          selectedColor: AppColors.purple,
                          checkmarkColor: AppColors.white,
                          backgroundColor: Colors.grey.shade100,
                          elevation: isSelected ? 2 : 0,
                          onSelected: (selected) {
                            if (selected) onTap(type, index);
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),

        const Divider(),

        // Price Filter Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Price Filter Enable/Disable Toggle
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Price Range",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: isPriceFilterEnabled,
                    builder: (context, isEnabled, child) {
                      return Switch(
                        value: isEnabled,
                        onChanged: (value) {
                          isPriceFilterEnabled.value = value;
                        },
                        activeColor: AppColors.purple,
                        activeTrackColor:
                            AppColors.purple.withValues(alpha: 0.3),
                        inactiveThumbColor: AppColors.grey400,
                        inactiveTrackColor: AppColors.grey200,
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Price Range Content (only shown when enabled)
              ValueListenableBuilder<bool>(
                valueListenable: isPriceFilterEnabled,
                builder: (context, isEnabled, child) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isEnabled ? null : 0,
                    child: isEnabled
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Max Price Editor
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Maximum Price",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: AppColors.grey300,
                                      ),
                                    ),
                                    child: ValueListenableBuilder<double>(
                                      valueListenable: maxPriceNotifier,
                                      builder:
                                          (context, currentMaxPrice, child) {
                                        maxPriceController.text =
                                            currentMaxPrice.toInt().toString();
                                        return TextField(
                                          controller: maxPriceController,
                                          keyboardType: TextInputType.number,
                                          onTapOutside: (_) {
                                            context.hideKeyboard();
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                            isDense: true,
                                            prefixText: "₹",
                                            prefixStyle: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              final newMaxPrice =
                                                  double.tryParse(value) ??
                                                      currentMaxPrice;
                                              if (newMaxPrice > minPrice) {
                                                maxPriceNotifier.value =
                                                    newMaxPrice;
                                                // Update price range if current end exceeds new max
                                                if (priceRange.value.end >
                                                    newMaxPrice) {
                                                  if (priceRange.value.start >
                                                      newMaxPrice) {
                                                    priceRange.value =
                                                        RangeValues(
                                                      0,
                                                      newMaxPrice,
                                                    );
                                                  }
                                                  priceRange.value =
                                                      RangeValues(
                                                    priceRange.value.start,
                                                    newMaxPrice,
                                                  );
                                                  onPriceChanged(
                                                    priceRange.value,
                                                  );
                                                }
                                              }
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              // Price Range Display
                              ValueListenableBuilder<RangeValues>(
                                valueListenable: priceRange,
                                builder: (context, range, child) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          range.start.toCurrency(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        child: Text(
                                          "to",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColors.grey600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          range.end.toCurrency(),
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              const SizedBox(height: 16),

                              // Price Range Slider
                              ValueListenableBuilder<RangeValues>(
                                valueListenable: priceRange,
                                builder: (context, range, child) {
                                  return ValueListenableBuilder<double>(
                                    valueListenable: maxPriceNotifier,
                                    builder: (context, currentMaxPrice, child) {
                                      return RangeSlider(
                                        values: range,
                                        min: minPrice,
                                        max: currentMaxPrice,
                                        divisions: 20,
                                        activeColor: AppColors.purple,
                                        inactiveColor: AppColors.grey300,
                                        onChanged: (RangeValues newRange) {
                                          priceRange.value = newRange;
                                          onPriceChanged(newRange);
                                        },
                                      );
                                    },
                                  );
                                },
                              ),

                              // Min-Max Price Labels
                              ValueListenableBuilder<double>(
                                valueListenable: maxPriceNotifier,
                                builder: (context, currentMaxPrice, child) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        minPrice.toCurrency(),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.grey600,
                                        ),
                                      ),
                                      Text(
                                        currentMaxPrice.toCurrency(),
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: AppColors.grey600,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),

                              const SizedBox(height: 16),

                              // Quick Price Filter Buttons
                              Text(
                                "Quick Filters",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 8),

                              ValueListenableBuilder<double>(
                                valueListenable: maxPriceNotifier,
                                builder: (context, currentMaxPrice, child) {
                                  // Generate dynamic quick filter ranges based on currentMaxPrice
                                  final quickFilters = _generateQuickFilters(
                                    minPrice,
                                    currentMaxPrice,
                                  );

                                  return Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: quickFilters.map((filter) {
                                      return _buildQuickFilterChip(
                                        filter['label'],
                                        filter['range'],
                                        priceRange,
                                        onPriceChanged,
                                      );
                                    }).toList(),
                                  );
                                },
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Apply/Reset Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    selectedSearchTypeIndex.value = 0;
                    // Reset price range
                    priceRange.value =
                        RangeValues(minPrice, maxPriceNotifier.value);
                    onPriceChanged(
                        RangeValues(minPrice, maxPriceNotifier.value));
                    // Reset price filter enabled state
                    isPriceFilterEnabled.value = false;
                  },
                  child: Text(
                    "Reset",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.pop();
                    onApply(
                      selectedSearchTypeIndex.value,
                      priceRange.value,
                      isPriceFilterEnabled.value,
                    );
                  },
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    ),
  );
}

// Helper function to round numbers to meaningful values
double _roundToMeaningfulNumber(double value) {
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

// Helper function to generate dynamic quick filters based on max price
List<Map<String, dynamic>> _generateQuickFilters(
    double minPrice, double maxPrice) {
  final List<Map<String, dynamic>> filters = [];

  // Calculate dynamic ranges based on maxPrice
  double range1 = maxPrice * 0.1; // 10% of max
  double range2 = maxPrice * 0.25; // 25% of max
  double range3 = maxPrice * 0.5; // 50% of max
  double range4 = maxPrice * 0.75; // 75% of max

  // Round to nearest meaningful number
  range1 = _roundToMeaningfulNumber(range1);
  range2 = _roundToMeaningfulNumber(range2);
  range3 = _roundToMeaningfulNumber(range3);
  range4 = _roundToMeaningfulNumber(range4);

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

Widget _buildQuickFilterChip(
  String label,
  RangeValues range,
  ValueNotifier<RangeValues> currentRange,
  void Function(RangeValues) onChanged,
) {
  return ValueListenableBuilder<RangeValues>(
    valueListenable: currentRange,
    builder: (context, current, child) {
      final isSelected =
          current.start == range.start && current.end == range.end;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.purple : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.purple : AppColors.grey300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ).onTap(
        () {
          currentRange.value = range;
          onChanged(range);
        },
      );
    },
  );
}
