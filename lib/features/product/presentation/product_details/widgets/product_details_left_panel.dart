import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_variant_entity/product_variant_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Left panel for [ProductDetailsScreen]: image, name, price, variants,
/// specs, vehicle info, and description.
///
/// [onEditVariant] and [onAddVariant] bubble up to the screen which owns
/// the secure-action and cubit calls.
class ProductDetailsLeftPanel extends StatelessWidget {
  final ProductEntity product;
  final void Function(ProductVariantEntity variant) onEditVariant;
  final VoidCallback onAddVariant;

  const ProductDetailsLeftPanel({
    super.key,
    required this.product,
    required this.onEditVariant,
    required this.onAddVariant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(28),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image
            Container(
              width: 408,
              height: 279,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: product.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomNetworkImage(
                        imageUrl: product.image!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey.shade400,
                    ),
            ),
            const SizedBox(height: 16),

            // Name + price row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (product.purchaseAmount != null &&
                          product.purchaseAmount! > 0)
                        Text(
                          'Purchase: ₹${NumberFormat('#,###').format(product.purchaseAmount)}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${NumberFormat('#,###').format(product.price ?? 0)}',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFF6132E4),
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Builder(
                      builder: (context) {
                        int? salePrice;
                        if (product.variants.isNotEmpty) {
                          salePrice = double.parse(
                            product.salePrice ?? '0',
                          ).toInt();
                        }
                        return Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Sale:',
                                style: TextStyle(
                                  color: Color(0xFF8E8E8E),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: salePrice != null
                                    ? ' ₹${NumberFormat('#,###').format(salePrice)}'
                                    : ' -',
                                style: const TextStyle(
                                  color: Color(0xFFFFA93A),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),
            Container(height: 1, color: Colors.grey.shade300),
            const SizedBox(height: 12),

            // Variants section
            if (product.variants.length > 1 ||
                (product.variants.length == 1 &&
                    product.variants.first.attribute != product.name))
              ..._buildVariantsSection(),

            // Single-variant stock count
            if (product.variants.length == 1 &&
                product.variants.first.attribute == product.name) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.purple.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.purple.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.inventory_2_outlined,
                          size: 20,
                          color: AppColors.purple,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Total Stock:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${product.variants.first.stock} Units',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Product specifications chips
            if (product.category != null ||
                product.model != null ||
                product.color != null) ...[
              const Text(
                'Product Specifications',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (product.category != null &&
                        product.category!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _specChip(Icons.category, product.category!),
                      ),
                    if (product.model != null && product.model!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _specChip(Icons.layers, product.model!),
                      ),
                    if (product.color != null && product.color!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _specChip(Icons.palette, product.color!),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Vehicle-specific information
            if (product.effectiveRegistrationNumber != null ||
                product.effectivePollutionExpiry != null ||
                product.effectiveInsuranceExpiry != null ||
                product.effectiveFitnessExpiry != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.app_registration,
                      size: 18,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Registration No:',
                      style: TextStyle(
                        color: Color(0xFF787878),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      product.effectiveRegistrationNumber != null &&
                              product.effectiveRegistrationNumber!.isNotEmpty
                          ? product.effectiveRegistrationNumber!
                          : 'N/A',
                      style: TextStyle(
                        color: product.effectiveRegistrationNumber != null &&
                                product.effectiveRegistrationNumber!.isNotEmpty
                            ? Colors.black
                            : Colors.grey.shade400,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F0FF),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.purple.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          size: 18,
                          color: AppColors.purple,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Valid Upto',
                          style: TextStyle(
                            color: AppColors.purple,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildExpiryRow(
                      'Pollution',
                      product.effectivePollutionExpiry?.isNotEmpty == true
                          ? product.effectivePollutionExpiry!
                          : 'N/A',
                    ),
                    const SizedBox(height: 8),
                    _buildExpiryRow(
                      'Insurance',
                      product.effectiveInsuranceExpiry?.isNotEmpty == true
                          ? product.effectiveInsuranceExpiry!
                          : 'N/A',
                    ),
                    const SizedBox(height: 8),
                    _buildExpiryRow(
                      'Permit',
                      product.effectiveFitnessExpiry?.isNotEmpty == true
                          ? product.effectiveFitnessExpiry!
                          : 'N/A',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // Description
            if (product.description != null &&
                product.description!.isNotEmpty) ...[
              const Text(
                'Description',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                product.description!,
                style: const TextStyle(
                  color: Color(0xFF787878),
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildVariantsSection() {
    final isGadget = product.mainServiceType?.isGadget == true;
    final displayVariants = product.variants
        .where(
          (v) =>
              v.attribute.trim().toLowerCase() !=
              product.name.trim().toLowerCase(),
        )
        .toList();

    if (displayVariants.isEmpty) return [];

    final sectionTitle = isGadget ? 'Serial Numbers' : 'Available Variants';

    return [
      Text(
        sectionTitle,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        height: isGadget ? 84 : 70,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: displayVariants
                      .map(
                        (variant) => Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: _variantCard(variant),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            _addVariantButton(),
          ],
        ),
      ),
      const SizedBox(height: 12),
    ];
  }

  Widget _variantCard(ProductVariantEntity variant) {
    final isGadget = product.mainServiceType?.isGadget == true;
    final cardWidth = isGadget ? 200.0 : 102.0;
    final cardMinHeight = isGadget ? 72.0 : 58.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: cardWidth,
          height: cardMinHeight,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFE0E0E0)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                variant.attribute,
                textAlign: TextAlign.center,
                maxLines: isGadget ? 3 : 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF171717),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${variant.stock} stocks',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: InkWell(
            onTap: () => onEditVariant(variant),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.purple,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, size: 12, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addVariantButton() {
    return Container(
      width: 118,
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F4FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.purple,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onAddVariant,
          borderRadius: BorderRadius.circular(10),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: AppColors.purple, size: 18),
                SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'Add Variant',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.purple,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _specChip(IconData icon, String label) {
    return Container(
      width: 130,
      height: 25,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.black),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF787878),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: value == 'N/A' ? Colors.grey.shade400 : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
