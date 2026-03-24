import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_entity/product_entity.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsDialog extends StatelessWidget {
  const ProductDetailsDialog({required this.product, super.key});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) => Dialog(
    shape: RoundedRectangleBorder(borderRadius: 10.radiusBorder),
    backgroundColor: Colors.white,
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.isDesktop ? 600 : 400,
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: 13.padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: 10.radiusBorder,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CustomNetworkImage(
                        imageUrl: product.image ?? '',
                        width: double.infinity,
                      ),
                    ),
                  ),
                  10.height,
                  // Product Name
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  // Product Name
                  Text(
                    product.category ?? 'Category: -',
                    style: TextStyle(fontSize: 15.sp, color: AppColors.grey),
                  ),
                  // Product Name
                  Text(
                    product.color ?? 'Color: -',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -20,
            right: -20,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close, color: AppColors.purple),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(
                  side: BorderSide(color: AppColors.purple, width: 1.5),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
