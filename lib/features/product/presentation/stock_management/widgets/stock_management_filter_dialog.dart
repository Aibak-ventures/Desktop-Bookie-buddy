import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/price_filter_utils.dart';
import 'package:flutter/material.dart';

/// Result returned by [StockManagementFilterDialog] when the user taps Apply.
class StockFilterResult {
  final int searchTypeIndex;
  final RangeValues priceRange;
  final bool isPriceEnabled;

  const StockFilterResult({
    required this.searchTypeIndex,
    required this.priceRange,
    required this.isPriceEnabled,
  });
}

/// Product search & filter dialog for the stock management screen.
///
/// [maxPriceNotifier] is shared with the screen — the dialog may write to it
/// when the user manually sets a new max price.
///
/// Pops with a [StockFilterResult] on Apply, or `null` on dismiss / close.
class StockManagementFilterDialog extends StatefulWidget {
  final ValueNotifier<double> maxPriceNotifier;
  final int initialSearchTypeIndex;
  final RangeValues initialPriceRange;
  final bool initialIsPriceEnabled;

  const StockManagementFilterDialog({
    super.key,
    required this.maxPriceNotifier,
    required this.initialSearchTypeIndex,
    required this.initialPriceRange,
    required this.initialIsPriceEnabled,
  });

  @override
  State<StockManagementFilterDialog> createState() =>
      _StockManagementFilterDialogState();
}

class _StockManagementFilterDialogState
    extends State<StockManagementFilterDialog> {
  final TextEditingController _maxPriceController = TextEditingController();
  late final ValueNotifier<int> _tempSearchTypeIndex;
  late final ValueNotifier<RangeValues> _tempPriceRange;
  late final ValueNotifier<bool> _tempIsPriceEnabled;

  static const _searchTypes = ['Name', 'Category', 'Model', 'Color'];

  @override
  void initState() {
    super.initState();
    _tempSearchTypeIndex =
        ValueNotifier(widget.initialSearchTypeIndex);
    _tempPriceRange = ValueNotifier(widget.initialPriceRange);
    _tempIsPriceEnabled = ValueNotifier(widget.initialIsPriceEnabled);
  }

  @override
  void dispose() {
    _maxPriceController.dispose();
    _tempSearchTypeIndex.dispose();
    _tempPriceRange.dispose();
    _tempIsPriceEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 500,
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 700),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchTypeSection(),
                    const SizedBox(height: 28),
                    const Divider(height: 1),
                    const SizedBox(height: 24),
                    _buildPriceRangeSection(),
                  ],
                ),
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF6132E4).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF6132E4),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Search & Filter',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D2D2D),
                fontFamily: 'Inter',
              ),
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close, color: Colors.grey.shade600),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Search By',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: _tempSearchTypeIndex,
          builder: (context, selectedIndex, child) {
            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(_searchTypes.length, (index) {
                final isSelected = index == selectedIndex;
                return GestureDetector(
                  onTap: () => _tempSearchTypeIndex.value = index,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6132E4).withValues(alpha: 0.1)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF6132E4)
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Text(
                      _searchTypes[index],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: isSelected
                            ? const Color(0xFF6132E4)
                            : Colors.grey.shade700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPriceRangeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              valueListenable: _tempIsPriceEnabled,
              builder: (context, isEnabled, child) => Transform.scale(
                scale: 0.85,
                child: Switch(
                  value: isEnabled,
                  onChanged: (value) => _tempIsPriceEnabled.value = value,
                  activeThumbColor: const Color(0xFF6132E4),
                  activeTrackColor:
                      const Color(0xFF6132E4).withValues(alpha: 0.3),
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade200,
                ),
              ),
            ),
          ],
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _tempIsPriceEnabled,
          builder: (context, isEnabled, child) => AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isEnabled
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildPriceRangeDisplay(),
                      const SizedBox(height: 8),
                      _buildPriceSlider(),
                      const SizedBox(height: 16),
                      _buildManualMaxPriceInput(),
                      const SizedBox(height: 20),
                      _buildQuickFiltersSection(),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Widget _buildPriceRangeDisplay() {
    return ValueListenableBuilder<RangeValues>(
      valueListenable: _tempPriceRange,
      builder: (context, range, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PriceLabel(value: range.start.toCurrency()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.arrow_forward,
              size: 18,
              color: Colors.grey.shade400,
            ),
          ),
          _PriceLabel(value: range.end.toCurrency()),
        ],
      ),
    );
  }

  Widget _buildPriceSlider() {
    return ValueListenableBuilder<RangeValues>(
      valueListenable: _tempPriceRange,
      builder: (context, range, child) =>
          ValueListenableBuilder<double>(
            valueListenable: widget.maxPriceNotifier,
            builder: (context, currentMaxPrice, child) => SliderTheme(
              data: SliderThemeData(
                activeTrackColor: const Color(0xFF6132E4),
                inactiveTrackColor: Colors.grey.shade200,
                thumbColor: const Color(0xFF6132E4),
                overlayColor:
                    const Color(0xFF6132E4).withValues(alpha: 0.2),
                trackHeight: 4,
                thumbShape:
                    const RoundSliderThumbShape(enabledThumbRadius: 8),
                overlayShape:
                    const RoundSliderOverlayShape(overlayRadius: 16),
              ),
              child: RangeSlider(
                values: range,
                min: 0,
                max: currentMaxPrice,
                divisions: 20,
                onChanged: (RangeValues newRange) {
                  _tempPriceRange.value = newRange;
                },
              ),
            ),
          ),
    );
  }

  Widget _buildManualMaxPriceInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Set Max Price',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D2D2D),
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _maxPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter max price',
                    prefixText: '₹ ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                  ),
                  style: const TextStyle(fontSize: 14, fontFamily: 'Inter'),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                final newMax =
                    double.tryParse(_maxPriceController.text.trim());
                if (newMax != null && newMax > 0) {
                  widget.maxPriceNotifier.value = newMax;
                  _tempPriceRange.value = RangeValues(0, newMax);
                  _maxPriceController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                backgroundColor: const Color(0xFF6132E4),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Set',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickFiltersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          valueListenable: widget.maxPriceNotifier,
          builder: (context, currentMaxPrice, child) {
            final quickFilters = generateQuickFilters(0, currentMaxPrice);
            return Wrap(
              spacing: 8,
              runSpacing: 8,
              children: quickFilters
                  .map(
                    (filter) => _QuickFilterChip(
                      label: filter['label'] as String,
                      range: filter['range'] as RangeValues,
                      currentRange: _tempPriceRange,
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(20)),
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                _tempSearchTypeIndex.value = 0;
                _tempPriceRange.value =
                    RangeValues(0, widget.maxPriceNotifier.value);
                _tempIsPriceEnabled.value = false;
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
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
                Navigator.of(context).pop(
                  StockFilterResult(
                    searchTypeIndex: _tempSearchTypeIndex.value,
                    priceRange: _tempPriceRange.value,
                    isPriceEnabled: _tempIsPriceEnabled.value,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: const Color(0xFF6132E4),
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor:
                    const Color(0xFF6132E4).withValues(alpha: 0.3),
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
    );
  }
}

class _PriceLabel extends StatelessWidget {
  final String value;
  const _PriceLabel({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6132E4).withValues(alpha: 0.1),
            const Color(0xFF6132E4).withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF6132E4).withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xFF6132E4),
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

class _QuickFilterChip extends StatelessWidget {
  final String label;
  final RangeValues range;
  final ValueNotifier<RangeValues> currentRange;

  const _QuickFilterChip({
    required this.label,
    required this.range,
    required this.currentRange,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RangeValues>(
      valueListenable: currentRange,
      builder: (context, current, child) {
        final isSelected =
            current.start == range.start && current.end == range.end;
        return GestureDetector(
          onTap: () => currentRange.value = range,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color:
                  isSelected ? const Color(0xFF6132E4) : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF6132E4)
                    : Colors.grey.shade300,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight:
                    isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
