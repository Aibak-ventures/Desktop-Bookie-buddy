import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';

import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import 'package:bookie_buddy_web/features/main/cubit/user_cubit.dart';

// Stateful widget for overlay search item with variant selection
class OverlaySearchItem extends StatefulWidget {
  final ProductEntity product;
  final Function(ProductVariantEntity) onAddProduct;
  final bool isSales;

  const OverlaySearchItem({
    required this.product,
    required this.onAddProduct,
    this.isSales = false,
  });

  @override
  State<OverlaySearchItem> createState() => OverlaySearchItemState();
}

class OverlaySearchItemState extends State<OverlaySearchItem> {
  ProductVariantEntity? selectedVariant;

  @override
  void initState() {
    super.initState();

    // For non-multi-variant products, auto-select the first variant
    // For multi-variant products (dress, costume, gadgets), user must explicitly select
    if (!widget.product.mainServiceType.isMultiVariantProductType &&
        widget.product.variants.isNotEmpty) {
      selectedVariant = widget.product.variants.first;
    } else {
      // Also auto-select when all variants have empty attribute (single unnamed variant)
      // — no chip will render so we must pre-select to allow adding
      final hasVisibleChip = widget.product.variants.any(
        (v) => v.attribute.isNotEmpty,
      );
      if (!hasVisibleChip && widget.product.variants.isNotEmpty) {
        selectedVariant = widget.product.variants.first;
      } else {
        selectedVariant = null;
      }
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
    const double minRowWidth = 700;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isOverflowing = constraints.maxWidth < minRowWidth;

          final content = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 50,
                  height: 40,
                  color: Colors.grey.shade100,
                  child:
                      widget.product.image != null &&
                          widget.product.image!.isNotEmpty
                      ? Image.network(
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
              ),
              const SizedBox(width: 10),

              // Product Info - Fixed width
              SizedBox(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.product.color ?? 'color',
                      style: const TextStyle(
                        color: Color(0xFF707070),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
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
  }
}

// Selectable variant chip widget
class SelectableVariantChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableVariantChip({
    required this.text,
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
        width: isShortText ? 33 : null,
        height: 33,
        padding: isShortText
            ? null
            : const EdgeInsets.symmetric(horizontal: 12),
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
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
