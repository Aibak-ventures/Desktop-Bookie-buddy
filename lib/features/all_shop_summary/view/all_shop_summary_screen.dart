import 'dart:io';

import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/models/all_shop_summary_model/all_shop_summary_model.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/all_shop_summary_shop_details_screen.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/all_shop_summary_app_bar_date_change_button.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/all_shop_summary_metrics_card.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/all_shop_summary_shop_performance_card.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view_models/cubit_all_shop_summary/all_shop_summary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllShopSummaryScreen extends StatelessWidget {
  AllShopSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllShopSummaryCubit, AllShopSummaryState>(
      builder: (context, state) {
        String? errorMessage;
        final allShopSummary = state.maybeWhen(
          orElse: () => AllShopSummaryModel.empty(),
          error: (error) {
            errorMessage = error;
            return null;
          },
          loaded: (shopSummary) => shopSummary,
        );

        final topPerformerIndex = _getTopPerformerIndex(
          allShopSummary?.shops ?? [],
        );
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              tooltip: 'Back',
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              ),
            ),
            title: const Text('Performance'),
            actions: [
              AllShopSummaryAppBarDateChangeButton(
                selectedDate: () {
                  final cubit = context.read<AllShopSummaryCubit>();
                  final month = cubit.selectedDate.month;
                  final year = cubit.selectedDate.year;
                  return '01-$month-$year';
                }(),
              ),
            ],
          ),
          body: allShopSummary == null
              ? CustomErrorWidget(
                  errorText: errorMessage ?? 'Something went wrong',
                  onRetry: () => _fetchData(context),
                )
              : RefreshIndicator.adaptive(
                  onRefresh: () async {
                    await _fetchData(context);
                  },
                  child: SingleChildScrollView(
                    padding: 16.padding,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Overall Metrics Section
                        _OverallMetricsSection(
                          overallRevenue: allShopSummary.overallRevenue,
                        ),
                        24.height,

                        // Shop Cards
                        if (allShopSummary.shops.length == 0)
                          SizedBox(
                            height: 0.35.heightR,
                            child: Center(
                              child: Text(
                                'No Shop Found',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black87,
                                ),
                              ),
                            ),
                          )
                        else ...[
                          // Shop Performance Section
                          Row(
                            children: [
                              Icon(
                                Icons.store_mall_directory_outlined,
                                color: AppColors.black87,
                              ),
                              8.width,
                              Text(
                                'Shop-wise Performance',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black87,
                                ),
                              ),
                            ],
                          ),
                          16.height,
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: allShopSummary.shops.length,
                            itemBuilder: (context, index) {
                              final shop = allShopSummary.shops[index];
                              return Padding(
                                padding: 12.paddingOnly(bottom: true),
                                child: AllShopSummaryShopPerformanceCard(
                                  shop: shop,
                                  isTopPerformer: topPerformerIndex == index,
                                  onTap: () {
                                    if (shop.shopId == -1) return;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BlocProvider(
                                          create: (context) =>
                                              AllShopSummaryCubit(getIt.get())
                                                ..fetchAllShopSummary(
                                                  year: DateTime.now().year,
                                                  month: DateTime.now().month,
                                                  shopId: shop.shopId,
                                                ),
                                          child:
                                              AllShopSummaryShopDetailsScreen(
                                            shopId: shop.shopId,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }

  ///  Fetch Data helper method
  Future<void> _fetchData(BuildContext context) async {
    final cubit = context.read<AllShopSummaryCubit>();
    final month = cubit.selectedDate.month;
    final year = cubit.selectedDate.year;
    await cubit.fetchAllShopSummary(year: year, month: month);
  }

  int _getTopPerformerIndex(List<AllShopSummaryShopModel> allShops) {
    if (allShops.isEmpty) return -1;
    int topPerformerIndex = 0;
    int topPerformerGrowth = 0;

    for (var i = 0; i < allShops.length; i++) {
      final currentGrowth = allShops[i].overallRevenue.profitGrowth;
      if (currentGrowth > topPerformerGrowth) {
        topPerformerIndex = i;
        topPerformerGrowth = currentGrowth;
      }
    }
    if (topPerformerGrowth <= 0) return -1;
    return topPerformerIndex;
  }
}

///  Overall Metrics Section
class _OverallMetricsSection extends StatelessWidget {
  final AllShopSummaryOverallRevenueModel overallRevenue;

  const _OverallMetricsSection({required this.overallRevenue});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Total Profit Card (Full Width)
        AllShopSummaryMetricsCard(
          label: 'Overall Profit',
          value: overallRevenue.totalProfit,
          growth: overallRevenue.profitGrowth,
          isFullWidth: true,
          valueColor: _greenColor,
          growthPrefix: 'vs last month',
          gradient: LinearGradient(
            colors: [
              const Color(0xFF6A38F4),
              const Color(0xFF9571FF).changeOpacity(.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // background: Positioned(
          //   right: 0,
          //   top: -20,
          //   child: Image.asset(
          //     AppAssets.crossCrossLines,
          //     width: 250.w,
          //     color: AppColors.white.changeOpacity(.4),
          //   ),
          // ),
          background: Positioned(
            right: -20.w,
            top: -20.w,
            child: Image.asset(AppAssets.financialGrowth, width: 260.w),
          ),
        ),
        12.height,

        // Revenue and Expense Row
        Row(
          children: [
            Expanded(
              child: AllShopSummaryMetricsCard(
                label: 'Overall Revenue',
                value: overallRevenue.totalRevenue,
                growth: overallRevenue.revenueGrowth,
                valueColor: AppColors.purple,
                growthColor: Colors.white,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF009BD8),
                    const Color(0xFF52AACC).changeOpacity(.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                background: Positioned(
                  top: -20.w,
                  right: -30.w,
                  child: Image.asset(
                    AppAssets.revenueOrMoney,
                    opacity: const AlwaysStoppedAnimation(0.4),
                    width: 210.w,
                  ),
                ),
              ),
            ),
            12.width,
            Expanded(
              child: AllShopSummaryMetricsCard(
                label: 'Overall Expense',
                value: overallRevenue.totalExpense,
                growth: overallRevenue.expenseGrowth,
                growthColor: Colors.white,
                valueColor: _redColor,
                // negativeGrowth: true,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFF4A4A),
                    const Color(0xFFFF4A4A).changeOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                background: Positioned(
                  right: 0,
                  child: Image.asset(
                    AppAssets.investment,
                    height: 110.w,
                    opacity: const AlwaysStoppedAnimation(0.4),
                  ),
                ),
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
