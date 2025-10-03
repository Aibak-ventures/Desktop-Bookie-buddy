import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_network_image.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/features/transfer_product/models/transfer_product_history_model/transfer_product_history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferProductHistoryTile extends StatelessWidget {
  final TransferProductHistoryModel transfer;
  const TransferProductHistoryTile({
    super.key,
    required this.transfer,
  });

  @override
  Widget build(BuildContext context) {
    final subTitle =
        '${transfer.productColor ?? transfer.productModel ?? transfer.productCategory ?? ''} ${transfer.sourceVariantAttribute.toLowerCase() != transfer.sourceProductName.toLowerCase() ? ', ${transfer.sourceVariantAttribute}' : ''}';
    return Container(
      margin: (16, 5).padding,
      padding: 12.padding,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyBorder),
        borderRadius: 10.radiusBorder,
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey200,
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: 5.radiusBorder,
                child: CustomNetworkImage(
                  height: 60.w,
                  width: 60.w,
                  imageUrl: transfer.productImage ?? '',
                  placeholder: (context, url) => CustomShimmerBox(
                    height: 60.w,
                    width: 60.w,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppAssets.unknownProduct,
                    height: 60.w,
                    width: 60.w,
                  ),
                ),
              ),
              10.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transfer.isIncoming ? transfer.destinationProductName : transfer.sourceProductName}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subTitle.trim().isEmpty ? 'N/A' : subTitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    transfer.quantityTransferred.toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Unit${transfer.quantityTransferred > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
          5.height,
          Divider(
            color: AppColors.grey300,
          ),
          5.height,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'By: ',
                        children: [
                          TextSpan(
                            text: '${transfer.initiatedByName}',
                            style: const TextStyle(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: '${transfer.isIncoming ? 'From: ' : 'To: '}: ',
                        children: [
                          TextSpan(
                            text:
                                '${transfer.isIncoming ? transfer.sourceShopName : transfer.destinationShopName}',
                            children: [
                              TextSpan(
                                text:
                                    ', ${transfer.isIncoming ? transfer.sourceShopAddress : transfer.destinationShopAddress}',
                                style: TextStyle(
                                  color: AppColors.blackShade,
                                ),
                              ),
                            ],
                            style: const TextStyle(
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: 8.padding,
                color: transfer.isIncoming
                    ? AppColors.green2.lighten(0.9)
                    : AppColors.red.lighten(0.9),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Icon(
                      transfer.isIncoming
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: transfer.isIncoming
                          ? AppColors.green2
                          : AppColors.red,
                      size: 16.sp,
                    ),
                    5.width,
                    Text(
                      '${transfer.isIncoming ? 'Received' : 'Transferred'}',
                      style: TextStyle(
                        color: transfer.isIncoming
                            ? AppColors.green2
                            : AppColors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TransferProductHistoryShimmerTile extends StatelessWidget {
  const TransferProductHistoryShimmerTile({super.key});

  @override
  Widget build(BuildContext context) => Container(
      margin: (16, 5).padding,
      padding: 12.padding,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyBorder),
        borderRadius: 10.radiusBorder,
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey200,
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top row with image, name, subtitle and qty
          Row(
            children: [
              CustomShimmerBox(
                height: 60.w,
                width: 60.w,
                borderRadius: 5,
              ),
              10.width,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerBox(
                      height: 14.h,
                      width: 100.w,
                    ),
                    6.height,
                    CustomShimmerBox(
                      height: 12.h,
                      width: 150.w,
                    ),
                  ],
                ),
              ),
              10.width,
              Column(
                children: [
                  CustomShimmerBox(
                    height: 14.h,
                    width: 20.w,
                  ),
                  6.height,
                  CustomShimmerBox(
                    height: 12.h,
                    width: 30.w,
                  ),
                ],
              ),
            ],
          ),
          10.height,
          Divider(color: AppColors.grey300),
          10.height,
          // Bottom row with initiator & to/from
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerBox(
                      height: 12.h,
                      width: 120.w,
                    ),
                    6.height,
                    CustomShimmerBox(
                      height: 12.h,
                      width: 180.w,
                    ),
                  ],
                ),
              ),
              10.width,
              CustomShimmerBox(
                height: 28.h,
                width: 100.w,
                borderRadius: 6,
              ),
            ],
          ),
        ],
      ),
    );
}
