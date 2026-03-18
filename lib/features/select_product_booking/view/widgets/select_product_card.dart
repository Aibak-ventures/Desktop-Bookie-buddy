import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/product/presentation/product_details/widgets/product_details_dialog.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SelectProductCard extends StatelessWidget {
  const SelectProductCard({
    super.key,
    required this.isSelected,
    required this.product,
    required this.onTap,
    required this.mainServiceType,
    this.needAddButton = true,
    this.isSales = false,
  });

  final bool isSelected;
  final ProductModel product;
  final VoidCallback onTap;
  final MainServiceType mainServiceType;
  final bool needAddButton;
  final bool isSales;

  @override
  Widget build(BuildContext context) {
    final (title: title, type: type) = getProductSpecification();
    final hasValidPrice = product.price != null && product.price! > 0;

    return GestureDetector(
      onTap: () => _showProductDetails(context),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            color: isSelected ? Colors.green.shade50 : Colors.white,
            borderRadius: 10.radiusBorder,
            border: Border.all(
              color: isSelected ? Colors.green : AppColors.grey300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey300,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            AspectRatio(
              aspectRatio: 1.0, // 1:1 square ratio
              child: Padding(
                padding: 6.padding,
                child: ClipRRect(
                  borderRadius: 10.radiusBorder,
                  child: CustomNetworkImage(
                    imageUrl: product.image ??
                        'https://static.vecteezy.com/system/resources/thumbnails/054/519/001/small/e-commerce-product-box-illustration-for-sales-vector.jpg',
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        AppAssets.unknownProduct,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),

            // Product Details Section
            Padding(
              padding: (8, 4).padding,
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

                  // Product Specification
                  Text(
                    '$title: $type',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.blackShade,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  4.height,

                  // Price and Action Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price or Contact for Price
                      hasValidPrice
                          ? Text(
                              product.price!.toCurrency(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: AppColors.black,
                              ),
                            )
                          : Text(
                              'No Price Added',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: AppColors.blackShade,
                                fontStyle: FontStyle.italic,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                      // Add/Remove Button
                      if (needAddButton)
                        Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: (isSales && !hasValidPrice)
                                ? AppColors.grey400
                                : const Color(0xFF6132E4),
                            borderRadius: 6.radiusBorder,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 18,
                          ),
                        ).onTap((isSales && !hasValidPrice) ? () {} : onTap),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ProductDetailsDialog(product: product),
    );
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
    } else {
      title = 'Category';
      type = product.category ?? '-';
    }

    return (
      type: type,
      title: title,
    );
  }
}

/// Shimmer for the [SelectProductCard]
class SelectProductCardShimmer extends StatelessWidget {
  const SelectProductCardShimmer({super.key, this.needAddButton = true});
  final bool needAddButton;
  @override
  Widget build(BuildContext context) => DecoratedBox(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Placeholder
            AspectRatio(
              aspectRatio: 1.0,
              child: Padding(
                padding: 6.padding,
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
              padding: (8, 4).padding,
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

                  5.height,

                  // Specification shimmer
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      height: 12,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  6.height,

                  // Price and Button Row shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price shimmer
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: 16,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),

                      // Button shimmer
                      if (needAddButton)
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: 6.radiusBorder,
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
