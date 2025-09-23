import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedProductCard extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String size;
  final int quantity;
  final VoidCallback? onRemove;

  const SelectedProductCard({
    required this.imageUrl,
    required this.price,
    required this.size,
    required this.quantity,
    this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: (4, 2).padding,
          padding:
              context.isMobile ? 5.paddingHorizontal : 10.paddingHorizontal,
          decoration: BoxDecoration(
            color: AppColors.purpleLight, // Light purple background
            borderRadius: 4.radiusBorder,
            border: Border.all(
              color: AppColors.grey.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Product Image
              Container(
                margin: 2.padding,
                padding: 5.paddingVertical,
                decoration: BoxDecoration(
                  borderRadius: 10.radiusBorder,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: 4.radiusBorder,
                  child: CustomNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.grey400,
                          size: 20,
                        ),
                      );
                    },
                  ),
                ),
              ),

              8.width,

              // Price and Size
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    size,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.purple,
                    ),
                  ),
                  Text(
                    'Qty: $quantity',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.purple,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Remove button
        Positioned(
          top: 0,
          right: -8,
          child: Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.red,
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.close,
              color: AppColors.redTomato,
              size: 14,
            ),
          ).onTap(onRemove),
        ),
      ],
    );
  }
}
