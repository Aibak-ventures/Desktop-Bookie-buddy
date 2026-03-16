import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/product/domain/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:bookie_buddy_web/utils/app_date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductGrowthListTile extends StatelessWidget {
  const ProductGrowthListTile({
    super.key,
    required this.monthData,
    required this.isLoss,
  });

  final ProductMonthlyDataModel monthData;
  final bool isLoss;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (15, 20).padding,
      margin: 10.paddingVertical,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: 10.radiusBorder,
        border: Border.all(color: AppColors.greyBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey200,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '${AppDateUtils.getMonthName(monthData.month)}, ${monthData.year}',
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  const Icon(
                    Icons.arrow_downward_outlined,
                    color: AppColors.green2,
                  ),
                  Flexible(
                    child: Text(
                      monthData.totalEarned.toCurrency(),
                      style: const TextStyle(
                        color: AppColors.green2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  const Icon(
                    Icons.arrow_upward_outlined,
                    color: AppColors.red,
                  ),
                  Flexible(
                    child: Text(
                      monthData.totalExpense.toCurrency(),
                      style: const TextStyle(
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: 5.paddingVertical,
                decoration: BoxDecoration(
                  color: isLoss ? AppColors.redLight : AppColors.green2Light,
                  borderRadius: 5.radiusBorder,
                  border: Border.all(
                    color: isLoss ? AppColors.red : AppColors.green2,
                    width: .1,
                  ),
                ),
                child: Text(
                  isLoss ? 'Loss' : 'Profit',
                  style: TextStyle(
                    color: isLoss ? AppColors.red : AppColors.green2,
                    fontSize: 11.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductGrowthListTileShimmer extends StatelessWidget {
  const ProductGrowthListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 10.paddingVertical,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildShimmerBlock(width: 60, height: 14),
          _buildShimmerBlock(width: 80, height: 14),
          _buildShimmerBlock(width: 80, height: 14),
          _buildShimmerBlock(width: 40, height: 14),
        ],
      ),
    );
  }

  Widget _buildShimmerBlock({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
