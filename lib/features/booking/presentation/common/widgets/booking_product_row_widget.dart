import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingProductRowWidget extends StatelessWidget {
  final ProductSelectedEntity product;
  final bool isSales;
  final int rentalDays;
  final int effectiveDaysMultiplier;
  final bool hasVariants;
  final int? editingVariantId;
  final TextEditingController inlinePriceController;
  final FocusNode inlinePriceFocusNode;
  final TextEditingController? quantityController;
  final FocusNode? quantityFocusNode;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final ValueChanged<String>? onSaveTypedQuantity;
  final VoidCallback onStartEditingPrice;
  final VoidCallback onSaveEditingPrice;
  final VoidCallback onRemove;

  const BookingProductRowWidget({
    super.key,
    required this.product,
    required this.isSales,
    required this.rentalDays,
    required this.effectiveDaysMultiplier,
    required this.hasVariants,
    required this.editingVariantId,
    required this.inlinePriceController,
    required this.inlinePriceFocusNode,
    this.quantityController,
    this.quantityFocusNode,
    required this.onDecrement,
    required this.onIncrement,
    this.onSaveTypedQuantity,
    required this.onStartEditingPrice,
    required this.onSaveEditingPrice,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          // Item Name & Image
          Expanded(
            flex: 3,
            child: Row(
              children: [
                // Image
                Container(
                  width: 48,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade200),
                    image:
                        product.variant.image != null &&
                            product.variant.image!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.variant.image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child:
                      product.variant.image == null ||
                          product.variant.image!.isEmpty
                      ? const Icon(
                          Icons.image_not_supported,
                          size: 20,
                          color: Colors.grey,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                // Text
                Expanded(
                  child: Text(
                    product.variant.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3436),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          // Specifications (service-specific)
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                _getProductSpecifications(product),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 4),
          // Variant (only for multi-variant products)
          if (hasVariants) ...[
            Expanded(
              child: Center(
                child: Text(
                  _getVariantDisplayText(product),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
          // Days (only for bookings)
          if (!isSales) ...[
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6132E4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$rentalDays',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6132E4),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
          // Available Badge
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0x1C1FD300),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF27AE60),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${product.variant.remainingStock ?? product.variant.stock} left',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF27AE60),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          // Quantity Buttons
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQuantityBtn(
                  icon: Icons.remove,
                  onTap: onDecrement,
                  compact: true,
                ),
                const SizedBox(width: 3),
                if (quantityController != null && quantityFocusNode != null)
                  SizedBox(
                    width: 30,
                    height: 28,
                    child: TextField(
                      controller: quantityController,
                      focusNode: quantityFocusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                            color: Color(0xFF6132E4),
                          ),
                        ),
                      ),
                      onSubmitted: onSaveTypedQuantity,
                      onTapOutside: (_) =>
                          onSaveTypedQuantity?.call(quantityController!.text),
                    ),
                  )
                else
                  Text(
                    '${product.quantity}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                const SizedBox(width: 3),
                _buildQuantityBtn(
                  icon: Icons.add,
                  onTap: onIncrement,
                  compact: true,
                  isDisabled:
                      product.quantity >=
                      (product.variant.remainingStock ??
                          product.variant.stock ??
                          999),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Price / item
          Expanded(
            child: editingVariantId == product.variant.variantId
                ? Center(
                    child: SizedBox(
                      width: 80,
                      height: 32,
                      child: TextField(
                        controller: inlinePriceController,
                        focusNode: inlinePriceFocusNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xFF6132E4),
                            ),
                          ),
                        ),
                        onSubmitted: (_) => onSaveEditingPrice(),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: onStartEditingPrice,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${product.amount}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2D3436),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.edit_outlined,
                          size: 16,
                          color: Color(0xFF6132E4),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(width: 4),
          // Total
          Expanded(
            child: Center(
              child: Text(
                '${product.amount * product.quantity * effectiveDaysMultiplier}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D3436),
                ),
              ),
            ),
          ),
          // Remove
          SizedBox(
            width: 50,
            child: IconButton(
              icon: const Icon(Icons.close, size: 20, color: Colors.black87),
              onPressed: onRemove,
            ),
          ),
        ],
      ),
    );
  }

  static String _getProductSpecifications(ProductSelectedEntity product) {
    final List<String> specs = [];

    if (product.variant.category != null &&
        product.variant.category!.isNotEmpty) {
      specs.add(product.variant.category!);
    }

    if (product.variant.model != null && product.variant.model!.isNotEmpty) {
      specs.add(product.variant.model!);
    }

    if (product.variant.color != null && product.variant.color!.isNotEmpty) {
      if (!specs.contains(product.variant.color)) {
        specs.add(product.variant.color!);
      }
    }

    return specs.isNotEmpty ? specs.join(' • ') : '-';
  }

  static String _getVariantDisplayText(ProductSelectedEntity product) {
    final mainServiceType = product.variant.mainServiceType;

    if (mainServiceType?.isMultiVariantProductType ?? false) {
      return product.variant.variantAttribute?.isNotEmpty ?? false
          ? product.variant.variantAttribute!
          : '-';
    }

    return '';
  }
}

Widget _buildQuantityBtn({
  required IconData icon,
  required VoidCallback onTap,
  bool isDisabled = false,
  bool compact = false,
}) {
  return InkWell(
    onTap: isDisabled ? null : onTap,
    borderRadius: BorderRadius.circular(4),
    child: Container(
      width: compact ? 20 : 27,
      height: compact ? 20 : 22,
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey.shade300 : const Color(0xFFF3F0FF),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        icon,
        size: compact ? 12 : 14,
        color: isDisabled ? Colors.grey.shade500 : const Color(0xFF6132E4),
      ),
    ),
  );
}
