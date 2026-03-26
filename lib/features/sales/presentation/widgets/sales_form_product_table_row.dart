import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A single product row in the selected-products table of [EditSalesScreen].
///
/// All mutations (quantity, price, remove) are handled via callbacks —
/// state is owned by the screen.
class SalesFormProductTableRow extends StatelessWidget {
  final ProductSelectedEntity product;
  final bool isEditing;
  final TextEditingController inlinePriceController;
  final FocusNode inlinePriceFocusNode;
  final VoidCallback onStartEditing;
  final VoidCallback onSaveEditing;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const SalesFormProductTableRow({
    super.key,
    required this.product,
    required this.isEditing,
    required this.inlinePriceController,
    required this.inlinePriceFocusNode,
    required this.onStartEditing,
    required this.onSaveEditing,
    required this.onIncrement,
    required this.onDecrement,
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
          // Item name & image
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey.shade100,
                    border: Border.all(color: Colors.grey.shade200),
                    image: product.variant.image != null &&
                            product.variant.image!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(product.variant.image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: product.variant.image == null ||
                          product.variant.image!.isEmpty
                      ? const Icon(Icons.image_not_supported,
                          size: 20, color: Colors.grey)
                      : null,
                ),
                const SizedBox(width: 16),
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

          // Specifications
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                _getSpecs(),
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

          // Quantity
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildQtyBtn(icon: Icons.remove, onTap: onDecrement),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    '${product.quantity}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                _buildQtyBtn(icon: Icons.add, onTap: onIncrement),
              ],
            ),
          ),
          const SizedBox(width: 4),

          // Price / item
          Expanded(
            child: Center(
              child: isEditing
                  ? ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 80),
                      child: SizedBox(
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
                              fontSize: 13, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide: const BorderSide(
                                  color: Color(0xFF6132E4)),
                            ),
                          ),
                          onSubmitted: (_) => onSaveEditing(),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: onStartEditing,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              '${product.amount}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF2D3436),
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.edit_outlined,
                              size: 16, color: Color(0xFF6132E4)),
                        ],
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 4),

          // Total
          Expanded(
            child: Center(
              child: Text(
                '${product.amount * product.quantity}',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D3436)),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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

  Widget _buildQtyBtn({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        width: 27,
        height: 22,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F0FF),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFF6132E4)),
      ),
    );
  }

  String _getSpecs() {
    final specs = <String>[];
    if (product.variant.category?.isNotEmpty ?? false) {
      specs.add(product.variant.category!);
    }
    if (product.variant.model?.isNotEmpty ?? false) {
      specs.add(product.variant.model!);
    }
    if (product.variant.color?.isNotEmpty ?? false) {
      if (!specs.contains(product.variant.color)) {
        specs.add(product.variant.color!);
      }
    }
    return specs.isNotEmpty ? specs.join(' • ') : '-';
  }
}
