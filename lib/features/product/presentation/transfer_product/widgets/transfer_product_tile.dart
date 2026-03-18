import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_model/product_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class TransferProductTile extends StatelessWidget {
  const TransferProductTile({
    super.key,
    this.serviceId,
    required this.product,
    this.isSelected = false,
    this.onTap,
    this.trailing,
  });
  final int? serviceId;
  final ProductModel product;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    final mainServiceType = product.mainServiceType ?? MainServiceType.others;

    return Container(
      padding: 4.padding,
      margin: (10, 5).padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: 5.radiusBorder,
        border: Border.all(
          color: isSelected ? AppColors.purple : AppColors.grey200,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: 5.radiusBorder,
          child: AspectRatio(
            aspectRatio: 1,
            child: product.image == null
                ? Image.asset(
                    AppAssets.unknownProduct,
                  )
                : CustomNetworkImage(
                    imageUrl: product.image!,
                    errorWidget: (context, url, error) => Image.asset(
                      AppAssets.unknownProduct,
                    ),
                  ),
          ),
        ),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (mainServiceType.isDress)
              Text(
                'Size: ${product.variants.map((x) => x.attribute).join(', ')}',
                style: const TextStyle(
                  color: AppColors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (mainServiceType.isDress || mainServiceType.isOthers)
              Text(
                'Color: ${product.color ?? '-'}',
                style: const TextStyle(color: AppColors.grey),
              ),
            if (mainServiceType.isVehicle)
              Text(
                'Model: ${product.model ?? '-'}',
                style: const TextStyle(color: AppColors.grey),
              ),
            if (mainServiceType.isVehicle ||
                mainServiceType.isOthers ||
                mainServiceType.isEquipment)
              Text(
                '${mainServiceType.isVehicle ? 'Brand' : 'Category'} : ${product.category ?? '-'}',
                style: const TextStyle(color: AppColors.grey),
              ),
            // Text(
            //   'Quantity: ${product.quantity}',
            //   style: const TextStyle(color: AppColors.grey),
            // ),
          ],
        ),
        trailing: trailing != null
            ? trailing
            : isSelected
                ? Icon(
                    Icons.check_circle,
                    color: AppColors.purple,
                    size: 28.sp,
                  )
                : null,
      ),
    ).onTap(onTap);
  }
}

class TransferProductTileShimmer extends StatelessWidget {
  const TransferProductTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 4.padding,
      margin: (10, 5).padding,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: 5.radiusBorder,
        border: Border.all(color: AppColors.grey200),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: AppColors.grey200,
        highlightColor: Colors.grey[100]!,
        child: Row(
          children: [
            // Image shimmer
            ClipRRect(
              borderRadius: 5.radiusBorder,
              child: Container(
                height: 60.h,
                width: 60.h,
                color: Colors.white,
              ),
            ),
            10.horizontalSpace,
            // Text shimmer
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 12.h, width: 100.w, color: Colors.white),
                  8.verticalSpace,
                  Container(height: 10.h, width: 60.w, color: Colors.white),
                  4.verticalSpace,
                  Container(height: 10.h, width: 80.w, color: Colors.white),
                  4.verticalSpace,
                  Container(height: 10.h, width: 70.w, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
