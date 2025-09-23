import 'dart:developer';

import 'package:bookie_buddy_web/core/app_icons.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/product_info_model/product_info_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSimpleDetailsTile extends StatelessWidget {
  const ProductSimpleDetailsTile({
    super.key,
    this.serviceId,
    required this.product,
    required this.amount,
    this.trailing,
  });
  final int? serviceId;
  final ProductInfoModel product;
  final int? amount;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    log('main service type: ${product.mainServiceType}');
    final mainServiceType = product.mainServiceType ?? MainServiceType.others;

    return ListTile(
      leading: ClipRRect(
        borderRadius: 5.radiusBorder,
        child: AspectRatio(
          aspectRatio: 1,
          child: CustomNetworkImage(
            imageUrl: product.image!,
            errorWidget: (context, url, error) => Image.asset(
              AppIcons.unknownProduct,
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
              'Size: ${product.variantAttribute ?? '-'}',
              style: const TextStyle(color: AppColors.grey),
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
          Text(
            'Quantity: ${product.quantity}',
            style: const TextStyle(color: AppColors.grey),
          ),
        ],
      ),
      trailing: trailing != null
          ? trailing
          : amount == null
              ? null
              : Text(
                  amount!.toCurrency(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
    );
  }

  // ({String type, String title}) getProductSpecification(
  //     MainServiceType mainServiceType) {
  //   late String title;
  //   late String type;

  //   if (mainServiceType.isDress) {
  //     title = 'Color';
  //     type = color ?? '-';
  //   } else if (mainServiceType.isVehicle) {
  //     title = 'Model';
  //     type = model ?? '-';
  //   } else {
  //     title = 'Category';
  //     type = category ?? '-';
  //   }

  //   return (
  //     type: type,
  //     title: title,
  //   );
  // }
}
