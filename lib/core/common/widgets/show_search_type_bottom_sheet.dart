import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/price_filter_utils.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void showSearchTypeBottomSheet({
  required BuildContext context,
  required List<String> searchTypes,
  required ValueNotifier<int> selectedSearchTypeIndex,
  required void Function(String type, int index) onTap,
  // Price filter parameters
  required ValueNotifier<RangeValues> priceRange,
  required double minPrice,
  required ValueNotifier<double> maxPriceNotifier,
  required void Function(RangeValues range) onPriceChanged,
  required ValueNotifier<bool> isPriceFilterEnabledNotifier,
  required void Function(
    int type,
    RangeValues range,
    bool isPriceEnabled,
  ) onApply,
}) {
  final TextEditingController maxPriceController = TextEditingController();
  final isPriceFilterEnabledWidgetNotifier =
      ValueNotifier(isPriceFilterEnabledNotifier.value);

  showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 500,
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 700,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6132E4).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: Color(0xFF6132E4),
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Search & Filter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: Colors.grey.shade600),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content - Scrollable
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Type Section
                    const Text(
                      'Search Type',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D2D2D),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 12),
                    ValueListenableBuilder(
                      valueListenable: selectedSearchTypeIndex,
                      builder: (context, selectedIndex, child) {
                        return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: searchTypes.asMap().entries.map((entry) {
                            final index = entry.key;
                            final type = entry.value;
                            final isSelected = selectedIndex == index;
                            return InkWell(
                              onTap: () => onTap(type, index),
                              borderRadius: BorderRadius.circular(12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF6132E4)
                                      : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF6132E4)
                                        : Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: const Color(0xFF6132E4)
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isSelected)
                                      const Padding(
                                        padding: EdgeInsets.only(right: 6),
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    Text(
                                      type,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.grey.shade700,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        fontSize: 14,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    const SizedBox(height: 28),
                    const Divider(height: 1),
                    const SizedBox(height: 24),

                    // Price Filter Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Price Range',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D2D2D),
                            fontFamily: 'Inter',
                          ),
                        ),
                        ValueListenableBuilder<bool>(
                          valueListenable: isPriceFilterEnabledWidgetNotifier,
                          builder: (context, isEnabled, child) =>
                              Transform.scale(
                            scale: 0.85,
                            child: Switch(
                              value: isEnabled,
                              onChanged: (value) {
                                isPriceFilterEnabledWidgetNotifier.value =
                                    value;
                              },
                              activeThumbColor: const Color(0xFF6132E4),
                              activeTrackColor:
                                  const Color(0xFF6132E4).withOpacity(0.3),
                              inactiveThumbColor: Colors.grey.shade400,
                              inactiveTrackColor: Colors.grey.shade200,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Price Range Content
                    ValueListenableBuilder<bool>(
                      valueListenable: isPriceFilterEnabledWidgetNotifier,
                      builder: (context, isEnabled, child) => AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: isEnabled
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),

                                  // Max Price Editor
                                  Row(
                                    children: [
                                      const Text(
                                        'Maximum Price',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF6B6B6B),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      const Spacer(),
                                      ValueListenableBuilder<double>(
                                        valueListenable: maxPriceNotifier,
                                        builder:
                                            (context, currentMaxPrice, child) {
                                          maxPriceController.text =
                                              currentMaxPrice
                                                  .toInt()
                                                  .toString();
                                          return Container(
                                            width: 130,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF8F9FA),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                                width: 1,
                                              ),
                                            ),
                                            child: TextField(
                                              controller: maxPriceController,
                                              keyboardType:
                                                  TextInputType.number,
                                              onTapOutside: (_) {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Inter',
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.zero,
                                                isDense: true,
                                                prefixText: '₹ ',
                                                prefixStyle: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF6132E4),
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
                                                    if (priceRange.value.end >
                                                        newMaxPrice) {
                                                      if (priceRange
                                                              .value.start >
                                                          newMaxPrice) {
                                                        priceRange.value =
                                                            RangeValues(
                                                          0,
                                                          newMaxPrice,
                                                        );
                                                      } else {
                                                        priceRange.value =
                                                            RangeValues(
                                                          priceRange
                                                              .value.start,
                                                          newMaxPrice,
                                                        );
                                                      }
                                                      onPriceChanged(
                                                          priceRange.value);
                                                    }
                                                  }
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),

                                  // Price Range Display
                                  ValueListenableBuilder<RangeValues>(
                                    valueListenable: priceRange,
                                    builder: (context, range, child) => Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                const Color(0xFF6132E4)
                                                    .withOpacity(0.1),
                                                const Color(0xFF6132E4)
                                                    .withOpacity(0.05),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: const Color(0xFF6132E4)
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                          child: Text(
                                            range.start.toCurrency(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF6132E4),
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 18,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                const Color(0xFF6132E4)
                                                    .withOpacity(0.1),
                                                const Color(0xFF6132E4)
                                                    .withOpacity(0.05),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: const Color(0xFF6132E4)
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                          child: Text(
                                            range.end.toCurrency(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF6132E4),
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Price Range Slider
                                  ValueListenableBuilder<RangeValues>(
                                    valueListenable: priceRange,
                                    builder: (context, range, child) =>
                                        ValueListenableBuilder<double>(
                                      valueListenable: maxPriceNotifier,
                                      builder:
                                          (context, currentMaxPrice, child) =>
                                              SliderTheme(
                                        data: SliderThemeData(
                                          activeTrackColor:
                                              const Color(0xFF6132E4),
                                          inactiveTrackColor:
                                              Colors.grey.shade200,
                                          thumbColor: const Color(0xFF6132E4),
                                          overlayColor: const Color(0xFF6132E4)
                                              .withOpacity(0.2),
                                          trackHeight: 4,
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                            enabledThumbRadius: 8,
                                          ),
                                          overlayShape:
                                              const RoundSliderOverlayShape(
                                            overlayRadius: 16,
                                          ),
                                        ),
                                        child: RangeSlider(
                                          values: range,
                                          min: minPrice,
                                          max: currentMaxPrice,
                                          divisions: 20,
                                          onChanged: (RangeValues newRange) {
                                            priceRange.value = newRange;
                                            onPriceChanged(newRange);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Min-Max Labels
                                  ValueListenableBuilder<double>(
                                    valueListenable: maxPriceNotifier,
                                    builder:
                                        (context, currentMaxPrice, child) =>
                                            Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            minPrice.toCurrency(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                          Text(
                                            currentMaxPrice.toCurrency(),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Quick Filters
                                  const Text(
                                    'Quick Filters',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2D2D2D),
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  ValueListenableBuilder<double>(
                                    valueListenable: maxPriceNotifier,
                                    builder: (context, currentMaxPrice, child) {
                                      final quickFilters =
                                          generateQuickFilters(
                                        minPrice,
                                        currentMaxPrice,
                                      );

                                      return Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: quickFilters
                                            .map((filter) =>
                                                _buildQuickFilterChip(
                                                  filter['label'],
                                                  filter['range'],
                                                  priceRange,
                                                  onPriceChanged,
                                                ))
                                            .toList(),
                                      );
                                    },
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Footer - Action Buttons
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        selectedSearchTypeIndex.value = 0;
                        priceRange.value =
                            RangeValues(minPrice, maxPriceNotifier.value);
                        onPriceChanged(
                            RangeValues(minPrice, maxPriceNotifier.value));
                        isPriceFilterEnabledWidgetNotifier.value = false;
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onApply(
                          selectedSearchTypeIndex.value,
                          priceRange.value,
                          isPriceFilterEnabledWidgetNotifier.value,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF6132E4),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: const Color(0xFF6132E4).withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Apply Filters',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


Widget _buildQuickFilterChip(
  String label,
  RangeValues range,
  ValueNotifier<RangeValues> currentRange,
  void Function(RangeValues) onChanged,
) =>
    ValueListenableBuilder<RangeValues>(
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
              fontSize: 12,
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
