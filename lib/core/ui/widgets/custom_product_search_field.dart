import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_search_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/show_search_type_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CustomProductSearchField extends StatefulWidget {
  CustomProductSearchField({
    required this.searchController,
    required this.onChanged,
    required this.mainServiceType,
    required this.onApply,
    super.key,
    required this.isPriceFilterEnabled,
    required this.priceRangeNotifier,
  });

  final TextEditingController searchController;
  final ValueNotifier<bool> isPriceFilterEnabled;
  final ValueNotifier<RangeValues> priceRangeNotifier;
  final void Function(
    String query,
    String selectedType,
    RangeValues priceRange,
    bool isPriceEnabled,
  )
  onChanged;
  final void Function(
    int type,
    RangeValues priceRange,
    bool isPriceEnabled,
    String searchQuery,
    String searchType,
  )
  onApply;
  final MainServiceType mainServiceType;

  @override
  State<CustomProductSearchField> createState() =>
      _CustomProductSearchFieldState();
}

class _CustomProductSearchFieldState extends State<CustomProductSearchField> {
  late final List<String> searchTypes;
  late final List<String> searchTypes2;

  @override
  void initState() {
    super.initState();
    searchTypes = ['Name', 'Color', 'Category', 'Model'];
    searchTypes2 = [
      'Name',
      'Color',
      widget.mainServiceType.isVehicle
          ? 'Brand'
          : widget.mainServiceType.isGadgets
          ? 'Serial Number'
          : 'Category',
      'Model',
    ];
  }

  final selectedSearchTypeIndexNotifier = ValueNotifier(0);
  final maxPriceNotifier = ValueNotifier<double>(80000);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: selectedSearchTypeIndexNotifier,
    builder: (context, selectedSearchTypeIndex, child) => CustomSearchField(
      hintText:
          'Search ${searchTypes2[selectedSearchTypeIndex].toLowerCase()}...',
      searchController: widget.searchController,
      suffixIcon: ValueListenableBuilder<bool>(
        valueListenable: widget.isPriceFilterEnabled,
        builder: (context, isFilterEnabled, child) => IconButton(
          icon: Icon(
            Icons.tune,
            color: isFilterEnabled ? AppColors.purple : AppColors.grey600,
          ),
          onPressed: () {
            if (widget.mainServiceType.isDress &&
                (widget.priceRangeNotifier.value.start == 0 &&
                    widget.priceRangeNotifier.value.end == 80000)) {
              maxPriceNotifier.value = 30000;
              widget.priceRangeNotifier.value = RangeValues(
                0,
                maxPriceNotifier.value,
              );
            }

            showSearchTypeBottomSheet(
              context: context,
              searchTypes: searchTypes2,
              selectedSearchTypeIndex: selectedSearchTypeIndexNotifier,
              onTap: (type, index) {
                selectedSearchTypeIndexNotifier.value = index;
                // context.pop();
              },
              isPriceFilterEnabledNotifier: widget.isPriceFilterEnabled,
              maxPriceNotifier: maxPriceNotifier,
              minPrice: 0,
              priceRange: widget.priceRangeNotifier,
              onPriceChanged: (range) {},
              onApply: (type, range, isPriceEnabled) {
                widget.isPriceFilterEnabled.value = isPriceEnabled;
                widget.onApply(
                  type,
                  range,
                  isPriceEnabled,
                  widget.searchController.text,
                  searchTypes[selectedSearchTypeIndex].toLowerCase(),
                );
              },
            );
          },
        ),
      ),
      onChanged: (query) {
        widget.onChanged(
          query,
          searchTypes[selectedSearchTypeIndex].toLowerCase(),
          widget.priceRangeNotifier.value,
          widget.isPriceFilterEnabled.value,
        );
      },
    ),
  );
}
