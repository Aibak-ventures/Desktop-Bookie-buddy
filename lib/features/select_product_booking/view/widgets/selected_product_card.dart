import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/features/select_product_booking/models/product_selected_model/product_selected_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedProductCard extends StatelessWidget {
  final String imageUrl;
  final String price;
  final String size;
  final int quantity;
  final VoidCallback? onRemove;
  final ProductSelectedModel? productModel;
  final VoidCallback? onCustomizationUpdate;

  const SelectedProductCard({
    required this.imageUrl,
    required this.price,
    required this.size,
    required this.quantity,
    this.onRemove,
    this.productModel,
    this.onCustomizationUpdate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160, // Smaller fixed width for horizontal ListView
      child: Stack(
        children: [
          Container(
            margin: (4, 2).padding,
            padding: 8.padding,
            decoration: BoxDecoration(
              color: AppColors.purpleLight,
              borderRadius: 8.radiusBorder,
              border: Border.all(
                color: AppColors.grey.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Center(
                  child: ClipRRect(
                    borderRadius: 6.radiusBorder,
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CustomNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.image_not_supported,
                              color: AppColors.grey400,
                              size: 24,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                8.height,

                // Product details
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                4.height,

                Text(
                  size,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.purple,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                2.height,

                Text(
                  'Qty: $quantity',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.purple,
                  ),
                ),

                // Customization removed from select products screen
                // Only show in cart/add booking screen
              ],
            ),
          ),

          // Close button
          Positioned(
            top: -2,
            right: -2,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
