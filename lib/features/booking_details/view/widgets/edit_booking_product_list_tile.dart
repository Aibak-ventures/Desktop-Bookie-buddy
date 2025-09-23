import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_simple_details_tile.dart';
import 'package:flutter/material.dart';

class EditBookingProductListTile extends StatelessWidget {
  const EditBookingProductListTile({
    required this.amount,
    required this.product,
    required this.onEdit,
    required this.onRemove,
    this.isActionsVisible = true,
    this.trailing,
    super.key,
  });

  final int amount;
  final ProductInfoModel product;
  final bool isActionsVisible;
  final VoidCallback onEdit;
  final VoidCallback onRemove;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: 5.paddingOnly(top: true, bottom: true),
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.grey200,
              ),
              borderRadius: 5.radiusBorder,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.grey200,
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ]),
          child: Column(
            children: [
              ProductSimpleDetailsTile(
                amount: amount,
                product: product,
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
        if (isActionsVisible)
          Positioned(
              right: -15,
              top: -5,
              child: PopupMenuButton(
                tooltip: 'Actions',
                icon: const Icon(
                  Icons.more_vert,
                  color: AppColors.black,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                      value: 0,
                      onTap: onEdit,
                      child: const Row(
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: AppColors.purple,
                          ),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      onTap: onRemove,
                      child: const Row(
                        spacing: 5,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: AppColors.redTomato,
                          ),
                          Text('Remove'),
                        ],
                      ),
                    ),
                  ];
                },
              )),
      ],
    );
  }
}
