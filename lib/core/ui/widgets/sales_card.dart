import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/sale_model/sale_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SalesCard extends StatelessWidget {
  const SalesCard({super.key, required this.sale, required this.onTap});

  final SaleModel sale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final date = sale.saleDate.isEmpty ? null : sale.saleDate.formatToUiDate();
    final productNames = sale.products.join(', ');

    final total = sale.totalAmount - sale.discountAmount; // total

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: 16.padding,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: 10.radiusBorder,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.grey200),
        ),
        child: Row(
          children: [
            // Date Section
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.purpleLight,
                borderRadius: 10.radiusBorder,
              ),
              child: Center(
                child: Text(
                  (() {
                    final name = sale.clientName.trim();
                    if (name.isEmpty) return '--';
                    final parts = name
                        .split(RegExp(r'\s+'))
                        .where((e) => e.isNotEmpty);
                    final initials = parts
                        .map((w) => w[0].toUpperCase())
                        .take(2)
                        .join();
                    return initials;
                  })(),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.purple,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Content Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client Name
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          sale.clientName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      Text(
                        total.toCurrency(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.purple,
                        size: 20.sp,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Items : $productNames',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  4.height,
                  // Status Badge
                  Row(
                    spacing: 5,
                    children: [
                      Text(
                        'Date: ${date ?? '--'}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow Icon
            // Icon(Icons.arrow_forward_ios, color: AppColors.grey, size: 16.sp),
          ],
        ),
      ),
    );
  }
}

class SalesCardShimmer extends StatelessWidget {
  const SalesCardShimmer({super.key});

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: 16.padding,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all(color: const Color(0xFFF0F0F0)),
    ),
    child: Shimmer.fromColors(
      baseColor: AppColors.grey[300]!,
      highlightColor: AppColors.grey[100]!,
      child: Row(
        children: [
          // Date Section Shimmer
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: 10.radiusBorder,
            ),
          ),

          const SizedBox(width: 16),

          // Content Section Shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5,
              children: [
                // Client Name Shimmer
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Container(
                      height: 24,
                      width: 80,
                      margin: 10.paddingOnly(left: true),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),

                // Payment Status Row Shimmer
                Row(
                  children: [
                    Container(
                      height: 18,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 18,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),

                // Status Badge Shimmer
                Container(
                  height: 18,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// Convenience shimmer list.
class SalesListShimmer extends StatelessWidget {
  const SalesListShimmer({super.key, this.count = 10});
  final int count;

  @override
  Widget build(BuildContext context) => ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    padding: 12.padding,
    // shrinkWrap: true,
    itemCount: count,
    itemBuilder: (c, i) => const SalesCardShimmer(),
  );
}
