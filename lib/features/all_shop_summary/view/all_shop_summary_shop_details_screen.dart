import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/constants/custom_icons_icons.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/list_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/models/all_shop_summary_model/all_shop_summary_model.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/all_shop_summary_app_bar_date_change_button.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/all_shop_summary_metrics_container.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/shop_summary_expense_breakdown_card.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/shop_summary_performance_overview_metric_card.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view_models/cubit_all_shop_summary/all_shop_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllShopSummaryShopDetailsScreen extends StatelessWidget {
  final int shopId;
  const AllShopSummaryShopDetailsScreen({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllShopSummaryCubit, AllShopSummaryState>(
      listenWhen: (previous, current) =>
          current != previous &&
          current.maybeMap(orElse: () => false, error: (_) => true),
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (error) => context.showSnackBar(error, isError: true),
        );
      },
      builder: (context, state) {
        final allShopSummary = state.maybeWhen(
          orElse: () => AllShopSummaryModel.empty(),
          loaded: (shopSummary) => shopSummary,
        );
        final shopDetails = allShopSummary.shops.firstWhereOrNull(
              (e) => e.shopId == shopId,
            ) ??
            AllShopSummaryShopModel.empty();

        // Get the current month data (you can modify this to show different months)
        final currentMonthData = shopDetails.monthlyDetails.isNotEmpty
            ? shopDetails.monthlyDetails.first
            : null;

        return Scaffold(
          appBar: AppBar(
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(shopDetails.shopName),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14.sp,
                      color: AppColors.grey600,
                    ),
                    4.width,
                    Text(
                      shopDetails.shopAddress,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              AllShopSummaryAppBarDateChangeButton(
                selectedDate: () {
                  final cubit = context.read<AllShopSummaryCubit>();
                  final month = cubit.selectedDate.month;
                  final year = cubit.selectedDate.year;

                  return '01-$month-$year';
                }(),
                // canDateChange: false,
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: 16.padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Total Shop Profit Card (Green)
                _TotalProfitCard(
                  profit: shopDetails.overallRevenue.totalProfit,
                  growth: shopDetails.overallRevenue.profitGrowth,
                ),
                16.height,

                /// Performance Overview
                _PerformanceOverview(
                  currentMonthData: currentMonthData,
                  shopDetails: shopDetails,
                ),

                24.height,

                // Expense Breakdown Section
                if (currentMonthData?.expenseBreakdown.isNotEmpty ?? false) ...[
                  Text(
                    'Expense Breakdown',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black87,
                    ),
                  ),
                  16.height,
                  ShopSummaryExpenseBreakdownCard(
                    expenses: currentMonthData!.expenseBreakdown,
                    totalExpense: shopDetails.overallRevenue.totalExpense,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TotalProfitCard extends StatelessWidget {
  final int profit;
  final int growth;

  const _TotalProfitCard({required this.profit, required this.growth});

  @override
  Widget build(BuildContext context) {
    final isPositive = growth >= 0;
    final haveProfit = profit > 0;
    final color1 = haveProfit
        ? const Color.fromARGB(255, 18, 184, 59)
        : const Color.fromARGB(255, 184, 18, 18);
    final color2 = haveProfit
        ? const Color.fromARGB(255, 116, 253, 150)
        : const Color.fromARGB(255, 253, 116, 116);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: 12.radiusBorder,
        boxShadow: [
          BoxShadow(
            color: color1.changeOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: -10.w,
            child: Image.asset(
              AppAssets.financialAndPayment,
              opacity: const AlwaysStoppedAnimation(0.5),
            ),
          ),
          Padding(
            padding: 20.padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shop Profit',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                2.height,
                FittedBox(
                  child: Text(
                    profit.toCurrency(),
                    style: TextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                4.height,
                Row(
                  children: [
                    Icon(
                      isPositive
                          ? CustomIcons.growthIncrease
                          : CustomIcons.growthDecrease,
                      size: 16.sp,
                      color: Colors.white,
                    ),
                    4.width,
                    Text(
                      '${growth.abs()}% from last month',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
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
}

class _PerformanceOverview extends StatelessWidget {
  const _PerformanceOverview({
    required this.currentMonthData,
    required this.shopDetails,
  });

  final AllShopSummaryShopMonthlyDetailsModel? currentMonthData;
  final AllShopSummaryShopModel shopDetails;

  @override
  Widget build(BuildContext context) {
    return AllShopSummaryMetricsContainer(
      child: Column(
        children: [
          // Bookings and Sales Cards
          Row(
            children: [
              Expanded(
                child: ShopSummaryPerformanceOverviewMetricCard(
                  icon: Icons.description,
                  iconBgColor: Colors.black,
                  label: 'BOOKINGS',
                  value: currentMonthData?.bookingsEarnings ?? 0,
                  subtitle: '${currentMonthData?.bookingsCount ?? 0} bookings',
                  growth: shopDetails.overallRevenue.profitGrowth,
                ),
              ),
              Padding(
                padding: 20.paddingHorizontal,
                child: SizedBox(
                  height: 90.h,
                  child: VerticalDivider(color: AppColors.grey300),
                ),
              ),
              Expanded(
                child: ShopSummaryPerformanceOverviewMetricCard(
                  icon: Icons.shopping_bag,
                  iconBgColor: Colors.black,
                  label: 'SALES',
                  value: currentMonthData?.salesEarnings ?? 0,
                  subtitle: '${currentMonthData?.salesCount ?? 0} transactions',
                  growth: 1, // You can calculate this from monthly data
                ),
              ),
            ],
          ),
          12.height,

          Divider(color: AppColors.grey300),

          12.height,

          // Total Expenses Card
          ShopSummaryPerformanceOverviewMetricCard(
            icon: Icons.account_balance_wallet,
            iconBgColor: Colors.black,
            label: 'TOTAL EXPENSES',
            value: shopDetails.overallRevenue.totalExpense,
            subtitle: 'Multiple categories',
            growth: shopDetails.overallRevenue.expenseGrowth,
            suffixValue: 'vs last month',
            isFullWidth: true,
            negativeColor: true,
          ),
        ],
      ),
    );
  }
}
