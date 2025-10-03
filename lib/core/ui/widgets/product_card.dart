import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;
  final MainServiceType? mainServiceType;
  final void Function(String value)? onOptionSelected;

  const ProductCard({
    required this.product,
    required this.onTap,
    this.onOptionSelected,
    super.key,
    this.mainServiceType,
  });

  @override
  Widget build(BuildContext context) {
    final (title: title, type: type) = getProductSpecification();
    return Container(
      padding: 8.padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 10.radiusBorder,
        border: Border.all(color: AppColors.grey300),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Product Image
          ClipRRect(
            borderRadius: 10.radiusBorder,
            child: AspectRatio(
              aspectRatio: 1,
              child: CustomNetworkImage(
                imageUrl:
                    product.image ??
                    'https://static.vecteezy.com/system/resources/thumbnails/054/519/001/small/e-commerce-product-box-illustration-for-sales-vector.jpg',
                errorWidget: (context, url, error) => Image.asset(
                  AppAssets.unknownProduct,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                width: double.infinity,
              ),
            ),
          ),

          // Product Details Section
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                4.height,

                // Color and Price Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Color Information
                    Expanded(
                      child: Text(
                        type == '-' || type.trim().isEmpty ? '$title: -' : type,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.blackShade,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Only show price if it exists and is greater than 0
                    if (product.price != null && product.price! > 0)
                      Text(
                        product.price!.toCurrency(),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: AppColors.black,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).onTap(onTap);
  }

  ({String type, String title}) getProductSpecification() {
    late String title;
    late String type;

    if (mainServiceType.isDress) {
      title = 'Color';
      type = product.color ?? '-';
    } else if (mainServiceType.isVehicle) {
      title = 'Model';
      type = product.model ?? '-';
    } else if (mainServiceType.isGadgets) {
      title = 'Serial Number';
      type = product.category ?? '-';
    } else {
      title = 'Category';
      type = product.category ?? '-';
    }

    return (type: type, title: title);
  }
}

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: 8.padding,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: 10.radiusBorder,
      border: Border.all(color: Colors.grey.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        // Image Placeholder
        ClipRRect(
          borderRadius: 10.radiusBorder,
          child: AspectRatio(
            aspectRatio: 1,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: 10.radiusBorder,
                ),
              ),
            ),
          ),
        ),

        // Text Placeholders
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product name shimmer
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),

              4.height,

              // Color and Price Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Color shimmer
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 12,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  // Price shimmer
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 14,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
