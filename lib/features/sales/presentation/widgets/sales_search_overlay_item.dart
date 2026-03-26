import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:bookie_buddy_web/features/sales/presentation/widgets/sales_selectable_variant_chip.dart';
import 'package:flutter/material.dart';

/// Search result row shown inside the product search overlay in [EditSalesScreen].
class SalesSearchOverlayItem extends StatefulWidget {
  final ProductEntity product;
  final void Function(ProductVariantEntity) onAddProduct;

  const SalesSearchOverlayItem({
    super.key,
    required this.product,
    required this.onAddProduct,
  });

  @override
  State<SalesSearchOverlayItem> createState() => _SalesSearchOverlayItemState();
}

class _SalesSearchOverlayItemState extends State<SalesSearchOverlayItem> {
  ProductVariantEntity? selectedVariant;

  @override
  void initState() {
    super.initState();
    if (!(widget.product.mainServiceType?.isMultiVariantProductType ?? false) &&
        widget.product.variants.isNotEmpty) {
      selectedVariant = widget.product.variants.first;
    } else {
      final hasVisibleChip =
          widget.product.variants.any((v) => v.attribute.isNotEmpty);
      if (!hasVisibleChip && widget.product.variants.isNotEmpty) {
        selectedVariant = widget.product.variants.first;
      } else {
        selectedVariant = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Always prefer sale_price over rent price
    final price = widget.product.salePrice != null
        ? (double.tryParse(widget.product.salePrice!)?.toInt() ??
              widget.product.price ??
              0)
        : (widget.product.price ?? 0);
    final variants = widget.product.variants;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              width: 50,
              height: 40,
              color: Colors.grey.shade100,
              child: widget.product.image != null &&
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
                  : Icon(Icons.image_outlined,
                      size: 20, color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 10),

          // Product name + color
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.product.color ?? 'color',
                  style: const TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),
          Container(width: 1, height: 30, color: const Color(0xFFA6A6A6)),
          const SizedBox(width: 12),

          // Variants / details
          if (widget.product.mainServiceType?.isMultiVariantProductType ?? false)
            Expanded(
              child: SizedBox(
                height: 40,
                child: variants.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: variants
                              .where((v) => v.attribute.isNotEmpty)
                              .map((variant) {
                            final isSelected = selectedVariant?.id == variant.id;
                            return Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: SalesSelectableVariantChip(
                                text: variant.attribute,
                                isSelected: isSelected,
                                onTap: () =>
                                    setState(() => selectedVariant = variant),
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
                      '${widget.product.mainServiceType?.categoryFieldLabel ?? 'Category'}: ${widget.product.category}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (widget.product.model != null &&
                      widget.product.model!.isNotEmpty)
                    Text(
                      '${widget.product.mainServiceType?.secondaryAttributeLabel ?? "Model"}: ${widget.product.model}',
                      style: TextStyle(
                          fontSize: 11, color: Colors.grey.shade600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if ((widget.product.category == null ||
                          widget.product.category!.isEmpty) &&
                      (widget.product.model == null ||
                          widget.product.model!.isEmpty))
                    Text(
                      widget.product.color ?? '-',
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),

          const SizedBox(width: 12),
          Container(width: 1, height: 30, color: const Color(0xFFA6A6A6)),
          const SizedBox(width: 12),

          // Price
          SizedBox(
            width: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('price',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600)),
                Text('₹$price',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ],
            ),
          ),

          const SizedBox(width: 12),
          Container(width: 1, height: 30, color: const Color(0xFFA6A6A6)),
          const SizedBox(width: 12),

          // Available qty
          SizedBox(
            width: 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('avl qty',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600)),
                Text(
                  selectedVariant != null
                      ? '${selectedVariant!.remainingStock ?? selectedVariant!.stock}'
                      : (variants.isNotEmpty
                            ? '${variants.first.remainingStock ?? variants.first.stock}'
                            : '0'),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Add button
          GestureDetector(
            onTap: selectedVariant != null
                ? () => widget.onAddProduct(selectedVariant!)
                : null,
            child: Container(
              width: 90,
              height: 36,
              decoration: BoxDecoration(
                color: selectedVariant != null
                    ? const Color(0xFF6132E4)
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 18, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    'Add',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
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
