import 'package:bookie_buddy_web/core/common/widgets/zoomable_image_dialog.dart';
import 'package:bookie_buddy_shared/core/core/constants/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_shared/core/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

/// Item details section for [SalesDetailsDrawer].
class SalesDetailsItemsSection extends StatelessWidget {
  final SaleDetailsEntity sale;

  const SalesDetailsItemsSection({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Item details',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...sale.products.map((item) {
            // Small leading thumbnail: prefer the dedicated thumbnail
            // (lighter/faster), falling back to the full-quality image.
            // The zoom preview does the opposite — a full-size view should
            // show the quality image, only falling back to the thumbnail
            // if that's all there is. Same split mobile's
            // ProductSimpleDetailsTile makes between `thumbnailImage` and
            // `qualityImage`.
            final thumbnail = item.thumbnailImage.isNotNullOrEmpty
                ? item.thumbnailImage
                : item.image;
            final qualityImage = item.image.isNotNullOrEmpty
                ? item.image
                : item.thumbnailImage;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: thumbnail.isNotNullOrEmpty
                        ? Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () => ZoomableImageDialog.show(
                                context,
                                imageUrl: qualityImage!,
                                title: item.name,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  thumbnail!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.image,
                                        color: Colors.grey.shade400,
                                      ),
                                ),
                              ),
                            ),
                          )
                        : Icon(Icons.image, color: Colors.grey.shade400),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (item.mainServiceType == MainServiceType.dress) ...[
                          if (item.variantAttribute != null &&
                              item.variantAttribute!.isNotEmpty)
                            Text(
                              'Size : ${item.variantAttribute}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          if (item.color != null && item.color!.isNotEmpty)
                            Text(
                              'Colour : ${item.color}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ] else if (item.mainServiceType ==
                            MainServiceType.vehicle) ...[
                          if (item.model != null && item.model!.isNotEmpty)
                            Text(
                              'Model : ${item.model}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          if (item.category != null &&
                              item.category!.isNotEmpty)
                            Text(
                              'Brand : ${item.category}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ] else if (item.mainServiceType ==
                            MainServiceType.equipment) ...[
                          if (item.category != null &&
                              item.category!.isNotEmpty)
                            Text(
                              'Category : ${item.category}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ] else ...[
                          if (item.category != null &&
                              item.category!.isNotEmpty)
                            Text(
                              'Category : ${item.category}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          if (item.color != null && item.color!.isNotEmpty)
                            Text(
                              'Colour : ${item.color}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Qty : ${item.quantity}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹ ${item.subtotal}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
