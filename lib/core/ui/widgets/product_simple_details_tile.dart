import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSimpleDetailsTile extends StatelessWidget {
  const ProductSimpleDetailsTile({
    super.key,
    required this.name,
    required this.amount,
    required this.quantity,
    MainServiceType? mainServiceType,
    this.image,
    this.trailing,
    this.variantAttribute,
    this.color,
    this.model,
    this.category,
    this.needColor = true,
    this.extraField,
  }) : mainServiceType = mainServiceType ?? MainServiceType.others;

  final String? image;
  final String name;
  final String? variantAttribute;
  final String? color;
  final String? model;
  final String? category;
  final int quantity;
  final MainServiceType mainServiceType;
  final int? amount;
  final Widget? trailing;
  final bool needColor;
  final String? extraField;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: ClipRRect(
          borderRadius: 5.radiusBorder,
          child: AspectRatio(
            aspectRatio: 1,
            child: image.isNullOrEmpty
                ? Image.asset(AppAssets.unknownProduct)
                : CustomNetworkImage(
                    imageUrl: image!,
                    errorWidget: (context, url, error) =>
                        Image.asset(AppAssets.unknownProduct),
                  ),
          ),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (mainServiceType.isDress)
              Text(
                'Size: ${variantAttribute ?? '-'}',
                style: const TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            if (needColor &&
                (mainServiceType.isDress || mainServiceType.isOthers))
              Text(
                'Color: ${color ?? '-'}',
                style: const TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            if (mainServiceType.isVehicle)
              Text(
                'Model: ${model ?? '-'}',
                style: const TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            if (mainServiceType.isVehicle ||
                mainServiceType.isOthers ||
                mainServiceType.isGadgets ||
                mainServiceType.isEquipment)
              Text(
                '${mainServiceType.isVehicle ? 'Brand' : mainServiceType.isGadgets ? 'Serial Number' : 'Category'} : ${category ?? '-'}',
                style: const TextStyle(color: AppColors.grey, fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            Text(
              'Quantity: ${quantity}',
              style: const TextStyle(color: AppColors.grey, fontSize: 12),
            ),
            if (extraField != null)
              Text(extraField!,
                  style: const TextStyle(color: AppColors.grey, fontSize: 12)),
          ],
        ),
        trailing: trailing != null
            ? trailing
            : amount == null
                ? null
                : Text(
                    amount!.toCurrency(),
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 19.sp),
                  ),
      );

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
