import 'package:bookie_buddy_shared/core/core/constants/enums/main_service_type_enums.dart';
import 'package:bookie_buddy_shared/core/features/sales/domain/entities/sale_details_entity/sale_details_entity.dart';
import 'package:bookie_buddy_web/core/common/widgets/product_details_card.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:material_ui/material_ui.dart';

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
          ...sale.products.map(
            (item) => ProductDetailsCard(
              name: item.name,
              // Small leading thumbnail: prefer the dedicated thumbnail
              // (lighter/faster), falling back to the full-quality image.
              // The zoom preview does the opposite: a full-size view should
              // show the quality image, only falling back to the thumbnail
              // if that's all there is. Same split mobile's
              // ProductSimpleDetailsTile makes between `thumbnailImage` and
              // `qualityImage`.
              imageUrl: item.thumbnailImage.isNotNullOrEmpty
                  ? item.thumbnailImage
                  : item.image,
              zoomImageUrl: item.image.isNotNullOrEmpty
                  ? item.image
                  : item.thumbnailImage,
              specs: _specsOf(item),
              amount: '₹ ${item.subtotal}',
              quantity: item.quantity,
            ),
          ),
        ],
      ),
    );
  }
}

/// Short facts about a sold item's variant, by kind of product.
List<String> _specsOf(ProductSaleInfoEntity item) {
  String? value(String? v) => v != null && v.isNotEmpty ? v : null;
  final attribute = value(item.variantAttribute);
  final color = value(item.color);
  final category = value(item.category);
  final model = value(item.model);

  return switch (item.mainServiceType) {
    MainServiceType.dress => [
      if (attribute != null) 'Size: $attribute',
      if (color != null) 'Colour: $color',
    ],
    MainServiceType.vehicle => [
      if (model != null) 'Model: $model',
      if (category != null) 'Brand: $category',
    ],
    MainServiceType.equipment => [if (category != null) 'Category: $category'],
    _ => [
      if (category != null) 'Category: $category',
      if (color != null) 'Colour: $color',
    ],
  };
}
