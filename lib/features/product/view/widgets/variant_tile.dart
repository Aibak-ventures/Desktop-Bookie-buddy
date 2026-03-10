import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_variant_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class VariantTile extends StatelessWidget {
  const VariantTile({
    required this.variant,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final ProductVariantModel variant;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: 5.paddingOnly(top: true, bottom: true),
            padding: 10.padding,
            decoration: BoxDecoration(
              color: AppColors.purpleLightShade,
              borderRadius: 5.radiusBorder,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(variant.attribute),
                ),
                const Expanded(
                  child: Text(':', textAlign: TextAlign.center),
                ),
                Expanded(
                    child: Text(
                  variant.stock.toString(),
                  textAlign: TextAlign.end,
                )),
              ],
            ),
          ),
        ),
        Container(
          margin: 5.paddingOnly(left: true),
          padding: 10.padding,
          decoration: BoxDecoration(
            color: AppColors.purpleLight,
            borderRadius: 5.radiusBorder,
          ),
          child: const Icon(
            Icons.edit,
            color: AppColors.purple,
            size: 18,
          ),
        ).onTap(onEdit),
        Container(
          margin: 5.paddingOnly(left: true),
          padding: 10.padding,
          decoration: BoxDecoration(
            color: AppColors.redLight,
            borderRadius: 5.radiusBorder,
          ),
          child: const Icon(
            Icons.close,
            color: AppColors.redTomato,
            size: 18,
          ),
        ).onTap(onDelete),
      ],
    );
  }
}
