import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A single product row in the stock-management table.
///
/// All side-effects (edit, view, delete) are delegated via callbacks so the
/// widget stays stateless and free of screen-level dependencies.
class StockManagementProductRow extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onViewDetails;
  final VoidCallback onDelete;

  const StockManagementProductRow({
    super.key,
    required this.product,
    required this.onTap,
    required this.onEdit,
    required this.onViewDetails,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final totalStock = product.variants.fold<int>(
      0,
      (sum, variant) => sum + variant.stock,
    );
    final variantCount = product.variants.length;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100, width: 1),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            hoverColor: AppColors.purple.withValues(alpha: 0.08),
            splashColor: AppColors.purple.withValues(alpha: 0.12),
            highlightColor: AppColors.purple.withValues(alpha: 0.1),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  // Item column (image + name)
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                          child: (product.thumbnailImage != null ||
                                  product.image != null)
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CustomNetworkImage(
                                    imageUrl: product.thumbnailImage ??
                                        product.image!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(
                                  Icons.image_outlined,
                                  color: Colors.grey.shade400,
                                  size: 28,
                                ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1F2937),
                                  height: 1.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Builder(
                                builder: (context) {
                                  final specs = <String>[];
                                  if (product.color != null &&
                                      product.color!.isNotEmpty) {
                                    specs.add(product.color!);
                                  }
                                  if (product.category != null &&
                                      product.category!.isNotEmpty) {
                                    specs.add(product.category!);
                                  }
                                  if (product.model != null &&
                                      product.model!.isNotEmpty) {
                                    specs.add(product.model!);
                                  }
                                  if (specs.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return Text(
                                    specs.join(' • '),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Category column showing main service name
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.purple.withValues(alpha: 0.12),
                              AppColors.purple.withValues(alpha: 0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.purple.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          product.generalServiceName ?? '-',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.purple.withValues(alpha: 0.95),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Sale Price column
                  Expanded(
                    flex: 2,
                    child: Builder(
                      builder: (context) {
                        double? salePriceValue;
                        if (product.salePrice != null &&
                            product.salePrice!.isNotEmpty) {
                          salePriceValue = double.tryParse(product.salePrice!);
                        }
                        return Text(
                          salePriceValue != null
                              ? '₹ ${NumberFormat('#,###.##').format(salePriceValue)}'
                              : '-',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Rent Price column
                  Expanded(
                    flex: 2,
                    child: Text(
                      product.price != null
                          ? '₹ ${NumberFormat('#,###').format(product.price)}'
                          : '-',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Total Qty column
                  SizedBox(
                    width: 100,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          totalStock.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Variants column
                  SizedBox(
                    width: 100,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.blue.shade200,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          variantCount.toString(),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue.shade800,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Actions column
                  SizedBox(
                    width: 140,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _ActionButton(
                          icon: Icons.edit_outlined,
                          tooltip: 'Edit Product',
                          color: Colors.blue,
                          onPressed: onEdit,
                        ),
                        const SizedBox(width: 8),
                        _ActionButton(
                          icon: Icons.visibility_outlined,
                          tooltip: 'View Details',
                          color: Colors.green,
                          onPressed: onViewDetails,
                        ),
                        const SizedBox(width: 8),
                        _ActionButton(
                          icon: Icons.delete_outline,
                          tooltip: 'Delete Product',
                          color: Colors.red,
                          onPressed: onDelete,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      waitDuration: const Duration(milliseconds: 500),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        hoverColor: color.withValues(alpha: 0.1),
        splashColor: color.withValues(alpha: 0.2),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}
