import 'package:bookie_buddy_web/core/constants/custom_icons_icons.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/models/all_shop_summary_model/all_shop_summary_model.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/all_shop_summary_metrics_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllShopSummaryShopPerformanceCard extends StatelessWidget {
  final AllShopSummaryShopModel shop;
  final bool isTopPerformer;
  final VoidCallback onTap;

  const AllShopSummaryShopPerformanceCard({
    super.key,
    required this.shop,
    required this.onTap,
    this.isTopPerformer = false,
  });

  @override
  Widget build(BuildContext context) {
    return AllShopSummaryMetricsContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shop.shopName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    if (shop.shopAddress.isNotNullOrEmpty) ...[
                      4.height,
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14.sp,
                            color: Colors.grey[600],
                          ),
                          4.width,
                          Flexible(
                            child: Text(
                              shop.shopAddress,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              if (isTopPerformer) const _TopShopBadge(),
              8.width,
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey[600],
                size: 16.sp,
              ),
              8.width,
            ],
          ),

          8.height,
          const Divider(color: Color(0xFFE2E2E2)),
          8.height,

          // Shop Metrics
          Row(
            children: [
              Expanded(
                child: _ShopMetricItem(
                  label: 'Revenue',
                  value: shop.overallRevenue.totalRevenue,
                ),
              ),
              Expanded(
                child: _ShopMetricItem(
                  label: 'Profit',
                  value: shop.overallRevenue.totalProfit,
                ),
              ),
              Expanded(
                child: _ShopMetricGrowth(
                  label: 'Growth',
                  growth: shop.overallRevenue.profitGrowth,
                ),
              ),
            ],
          ),
        ],
      ),
    ).onTap(onTap);
  }
}

class _TopShopBadge extends StatelessWidget {
  const _TopShopBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (10, 4).padding,
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700),
        borderRadius: 10.radiusBorder,
      ),
      child: Row(
        children: [
          Icon(Icons.star, size: 12.sp, color: Colors.white),
          4.width,
          Text(
            'Top',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopMetricItem extends StatelessWidget {
  final String label;
  final int value;

  const _ShopMetricItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
            letterSpacing: 0.3,
          ),
        ),
        4.height,
        Text(
          value.toCurrency(),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ShopMetricGrowth extends StatelessWidget {
  final String label;
  final int growth;

  const _ShopMetricGrowth({required this.label, required this.growth});

  @override
  Widget build(BuildContext context) {
    final isPositive = growth >= 0;
    final growthColor = isPositive ? _greenColor : _redColor;

    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
            letterSpacing: 0.3,
          ),
        ),
        4.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPositive
                  ? CustomIcons.growthIncrease
                  : CustomIcons.growthDecrease,
              size: 14.sp,
              color: growthColor,
            ),
            2.width,
            Text(
              '${growth.abs()}%',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: growthColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Color get _greenColor => AppColors.green;
  Color get _redColor => AppColors.redTomato;
}
