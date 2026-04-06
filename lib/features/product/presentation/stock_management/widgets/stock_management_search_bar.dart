import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Search + filter bar for the stock management screen.
///
/// [selectedServiceId] is used to decide whether to show the filter icon
/// (hidden when "All Services" / -1 is selected).
/// [onSearch] is called (after a 500 ms debounce) whenever the search text
/// changes.
class StockManagementSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final ValueNotifier<int> selectedSearchTypeIndex;
  final int selectedServiceId;
  final VoidCallback onFilterTap;
  final VoidCallback onAddProduct;
  final VoidCallback onSearch;

  const StockManagementSearchBar({
    super.key,
    required this.searchController,
    required this.selectedSearchTypeIndex,
    required this.selectedServiceId,
    required this.onFilterTap,
    required this.onAddProduct,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 269,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey.shade500, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: ValueListenableBuilder<int>(
                  valueListenable: selectedSearchTypeIndex,
                  builder: (context, searchTypeIndex, child) {
                    final searchTypes = ['name', 'category', 'model', 'color'];
                    final searchType = searchTypes[searchTypeIndex];
                    return TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by $searchType',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade400,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                      style: const TextStyle(fontSize: 14),
                      onChanged: (value) {
                        Future.delayed(const Duration(milliseconds: 500), () {
                          if (searchController.text == value) {
                            onSearch();
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              if (selectedServiceId != -1)
                IconButton(
                  onPressed: onFilterTap,
                  icon: Icon(
                    Icons.tune,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
            ],
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: onAddProduct,
          icon: const Icon(Icons.add, size: 18),
          label: const Text(
            'Add Product',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
