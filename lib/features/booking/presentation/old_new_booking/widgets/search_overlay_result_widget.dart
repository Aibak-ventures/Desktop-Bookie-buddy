import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:go_router/go_router.dart';

// import 'package:bookie_buddy_web/features/main/cubit/user_cubit.dart';

// Stateful widget for overlay search item with variant selection
class OverlaySearchItem extends StatefulWidget {
  final ProductEntity product;
  final Function(ProductVariantEntity) onAddProduct;
  final Function(String imageUrl, String? title)? onImageTap;
  final bool isSales;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final VoidCallback? onArrowDown;
  final VoidCallback? onArrowUp;
  final VoidCallback? onEscape;
  final bool isSelected;

  const OverlaySearchItem({
    required this.product,
    required this.onAddProduct,
    this.onImageTap,
    this.isSales = false,
    this.focusNode,
    this.nextFocusNode,
    this.onArrowDown,
    this.onArrowUp,
    this.onEscape,
    this.isSelected = false,
  });

  @override
  State<OverlaySearchItem> createState() => OverlaySearchItemState();
}

class OverlaySearchItemState extends State<OverlaySearchItem> {
  ProductVariantEntity? selectedVariant;
  bool _isImageHovered = false;

  void _handleKeyboardActivate() {
    final variantToAdd =
        selectedVariant ??
        (!widget.product.mainServiceType.isMultiVariantProductType &&
                widget.product.variants.isNotEmpty
            ? widget.product.variants.first
            : null);

    if (variantToAdd != null) {
      widget.onAddProduct(variantToAdd);
      return;
    }

    if (widget.product.variants.isNotEmpty) {
      setState(() {
        selectedVariant = widget.product.variants.first;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // For non-multi-variant products, auto-select the first variant
    // For multi-variant products (dress, costume, gadgets), user must explicitly select
    if (!widget.product.mainServiceType.isMultiVariantProductType &&
        widget.product.variants.isNotEmpty) {
      selectedVariant = widget.product.variants.first;
    } else {
      selectedVariant = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show sale_price in sales mode, rent price in booking mode
    final price = widget.isSales
        ? (double.tryParse(widget.product.salePrice ?? '')?.toInt() ??
              widget.product.price ??
              0)
        : (widget.product.price ?? 0);
    final variants = widget.product.variants;
    // Define min width preventing squeeze/overflow
    const double minRowWidth = 760;

    return Focus(
      focusNode: widget.focusNode,
      onKeyEvent: (_, event) {
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.enter ||
                event.logicalKey == LogicalKeyboardKey.numpadEnter)) {
          _handleKeyboardActivate();
          return KeyEventResult.handled;
        }
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.arrowDown ||
                event.logicalKey == LogicalKeyboardKey.numpad2)) {
          widget.onArrowDown?.call();
          return KeyEventResult.handled;
        }
        if (event is KeyDownEvent &&
            (event.logicalKey == LogicalKeyboardKey.arrowUp ||
                event.logicalKey == LogicalKeyboardKey.numpad8)) {
          widget.onArrowUp?.call();
          return KeyEventResult.handled;
        }
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.escape) {
          widget.onEscape?.call();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;
          final showFocus = hasFocus || widget.isSelected;
          return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: showFocus
              ? const Color(0xFF6132E4).withOpacity(0.08)
              : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: showFocus
                  ? const Color(0xFF6132E4)
                  : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isOverflowing = constraints.maxWidth < minRowWidth;

            final content = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: MouseRegion(
                  cursor: widget.product.image != null &&
                          widget.product.image!.isNotEmpty
                      ? SystemMouseCursors.click
                      : MouseCursor.defer,
                  onEnter: (_) {
                    if (widget.product.image != null &&
                        widget.product.image!.isNotEmpty) {
                      setState(() => _isImageHovered = true);
                    }
                  },
                  onExit: (_) => setState(() => _isImageHovered = false),
                  child: GestureDetector(
                    onTap: widget.product.image != null &&
                            widget.product.image!.isNotEmpty
                        ? () => widget.onImageTap?.call(
                              widget.product.image!,
                              widget.product.name,
                            )
                        : null,
                    child: Stack(
                      children: [
                        Container(
                          width: 50,
                          height: 40,
                          color: Colors.grey.shade100,
                          child: ((widget.product.thumbnailImage ??
                                          widget.product.image) !=
                                      null &&
                                  (widget.product.thumbnailImage ??
                                          widget.product.image)!
                                      .isNotEmpty)
                              ? Image.network(
                                  widget.product.thumbnailImage ??
                                      widget.product.image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Icon(
                                    Icons.image_outlined,
                                    size: 20,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              : Icon(
                                  Icons.image_outlined,
                                  size: 20,
                                  color: Colors.grey.shade400,
                                ),
                        ),
                        if (_isImageHovered)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black45,
                              child: const Icon(
                                Icons.zoom_in,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Product Info - Fixed width
              SizedBox(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tooltip(
                      message: widget.product.name,
                      waitDuration: const Duration(milliseconds: 250),
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.product.color ?? 'color',
                      style: const TextStyle(
                        color: Color(0xFF707070),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),
              // Divider
              Container(width: 1, height: 30, color: const Color(0xFFA6A6A6)),
              const SizedBox(width: 12),

              // Variants or Details Section
              if (widget.product.mainServiceType.isMultiVariantProductType)
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: variants.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: variants.map((variant) {
                                final isSelected =
                                    selectedVariant?.id == variant.id;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: SelectableVariantChip(
                                    text: variant.attribute,
                                    quantity:
                                        variant.remainingStock ?? variant.stock,
                                    isSelected: isSelected,
                                    onTap: () {
                                      setState(() {
                                        selectedVariant = variant;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                )
              else
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.product.category != null &&
                          widget.product.category!.isNotEmpty)
                        Text(
                          '${widget.product.mainServiceType.categoryFieldLabel}: ${widget.product.category}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (widget.product.model != null &&
                          widget.product.model!.isNotEmpty)
                        Text(
                          '${widget.product.mainServiceType.secondaryAttributeLabel ?? "Model"}: ${widget.product.model}',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if ((widget.product.category == null ||
                              widget.product.category!.isEmpty) &&
                          (widget.product.model == null ||
                              widget.product.model!.isEmpty))
                        Text(
                          widget.product.description ?? '-',
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),

              const SizedBox(width: 12),
              // Divider
              Container(width: 1, height: 30, color: const Color(0xFFA6A6A6)),
              const SizedBox(width: 12),

              // Price section
              SizedBox(
                width: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.isSales ? 'sale price' : 'rent price',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      '₹$price',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),
              // Divider
              Container(width: 1, height: 30, color: const Color(0xFFA6A6A6)),
              const SizedBox(width: 12),

              // Available Quantity section
              SizedBox(
                width: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'avl qty',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      selectedVariant != null
                          ? '${selectedVariant!.remainingStock ?? selectedVariant!.stock}'
                          : (variants.isNotEmpty
                                ? '${variants.first.remainingStock ?? variants.first.stock}'
                                : '0'),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),
              // Add button
              GestureDetector(
                onTap: () {
                  // For multi-variant products, require explicit selection
                  // For non-multi-variant products, use first variant automatically
                  final variantToAdd =
                      selectedVariant ??
                      (!widget
                                  .product
                                  .mainServiceType
                                  .isMultiVariantProductType &&
                              widget.product.variants.isNotEmpty
                          ? widget.product.variants.first
                          : null);

                  if (variantToAdd != null) {
                    widget.onAddProduct(variantToAdd);
                  }
                },
                child: Container(
                  width: 90,
                  height: 36,
                  decoration: BoxDecoration(
                    color:
                        (selectedVariant != null ||
                            !widget
                                .product
                                .mainServiceType
                                .isMultiVariantProductType)
                        ? const Color(0xFF6132E4)
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, size: 18, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ],
            );

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: isOverflowing
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: SizedBox(
                width: isOverflowing ? minRowWidth : constraints.maxWidth,
                child: content,
              ),
            );
          },
        ),
        );
      },
    ));
  }
}

// Selectable variant chip widget
class SelectableVariantChip extends StatelessWidget {
  final String text;
  final int quantity;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableVariantChip({
    required this.text,
    required this.quantity,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isShortText = text.length <= 3;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isShortText ? 46 : null,
        height: 46,
        padding: isShortText
            ? null
            : const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: isShortText ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isShortText ? null : BorderRadius.circular(8),
          color: isSelected ? AppColors.purpleLight : const Color(0xFFF8F7FF),
          border: Border.all(
            color: isSelected ? const Color(0xFF6132E4) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              '$quantity',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? const Color(0xFF6132E4)
                    : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
