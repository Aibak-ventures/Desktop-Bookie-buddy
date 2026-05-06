import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Pure-UI search bar for the product list.
/// All BLoC listening and overlay management stay in the parent screen.
class ProductListSearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final LayerLink layerLink;
  final VoidCallback onFilterTap;

  // Optional: focus/keyboard navigation (new booking only)
  final FocusNode? focusNode;
  final ValueNotifier<List<ProductEntity>>? overlayProducts;
  final FocusNode Function(int)? getOverlayItemFocusNode;
  final FocusNode? clientNameFocusNode;

  // Optional: active-filter chip display (new booking only)
  final ValueNotifier<int>? selectedSearchTypeIndex;
  final ValueNotifier<bool>? isPriceFilterEnabled;
  final List<String>? searchTypes;

  // Optional: callbacks
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  const ProductListSearchBarWidget({
    super.key,
    required this.controller,
    required this.layerLink,
    required this.onFilterTap,
    this.focusNode,
    this.overlayProducts,
    this.getOverlayItemFocusNode,
    this.clientNameFocusNode,
    this.selectedSearchTypeIndex,
    this.isPriceFilterEnabled,
    this.searchTypes,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  });

  bool get _hasFilterDisplay =>
      selectedSearchTypeIndex != null &&
      isPriceFilterEnabled != null &&
      searchTypes != null;

  bool get _hasKeyboardNav =>
      focusNode != null &&
      overlayProducts != null &&
      getOverlayItemFocusNode != null;

  void _defaultOnSubmitted(String _) {
    if (overlayProducts != null &&
        getOverlayItemFocusNode != null &&
        overlayProducts!.value.isNotEmpty) {
      getOverlayItemFocusNode!(0).requestFocus();
    } else {
      clientNameFocusNode?.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: _hasFilterDisplay
                    ? _buildFilterAwareField()
                    : _buildBasicField(),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: IconButton(
                onPressed: onFilterTap,
                icon: const Icon(Icons.tune, size: 20),
                color: const Color(0xFF6132E4),
                tooltip: 'Filter products',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterAwareField() {
    return ValueListenableBuilder<int>(
      valueListenable: selectedSearchTypeIndex!,
      builder: (context, searchTypeIndex, _) {
        return ValueListenableBuilder<bool>(
          valueListenable: isPriceFilterEnabled!,
          builder: (context, isPriceEnabled, _) {
            String? filterText;
            if (searchTypeIndex != 0) {
              filterText = searchTypes![searchTypeIndex];
            }
            if (isPriceEnabled) {
              filterText =
                  filterText != null ? '$filterText | Price' : 'Price';
            }

            return _wrapWithKeyboardNav(
              _buildTextField(suffixChip: filterText),
            );
          },
        );
      },
    );
  }

  Widget _buildBasicField() => _wrapWithKeyboardNav(_buildTextField());

  Widget _wrapWithKeyboardNav(Widget field) {
    if (!_hasKeyboardNav) return field;

    return Focus(
      skipTraversal: true,
      canRequestFocus: false,
      onKeyEvent: (_, event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.arrowDown ||
                event.logicalKey == LogicalKeyboardKey.numpad2)) {
          if (overlayProducts!.value.isNotEmpty) {
            getOverlayItemFocusNode!(0).requestFocus();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: field,
    );
  }

  Widget _buildTextField({String? suffixChip}) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onTap: onTap != null ? () => onTap!() : null,
      textInputAction: TextInputAction.next,
      style: const TextStyle(
        fontSize: 13,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: 'Search products',
        hintStyle: const TextStyle(
          fontSize: 13,
          fontFamily: 'Inter',
          color: Color(0xFF8C8C8C),
        ),
        prefixIcon: const Icon(Icons.search, size: 18),
        suffixIcon: suffixChip != null
            ? Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  label: Text(
                    suffixChip,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6132E4),
                    ),
                  ),
                  backgroundColor: const Color(0xFF6132E4).withValues(alpha: 0.1),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
            : null,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted ?? _defaultOnSubmitted,
    );
  }
}
