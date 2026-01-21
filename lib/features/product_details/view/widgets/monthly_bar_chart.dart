import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/product/models/product_monthly_expense_model/product_monthly_data_model.dart';
import 'package:flutter/material.dart';

class MonthlyBarChart extends StatelessWidget {
  final List<ProductMonthlyDataModel> monthlyData;
  final double height;

  const MonthlyBarChart({
    super.key,
    required this.monthlyData,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    if (monthlyData.isEmpty) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.purple.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            'No sales data available',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      );
    }

    // Find max value for scaling
    final maxValue = monthlyData.fold<int>(
      0,
      (max, data) => data.totalEarned > max ? data.totalEarned : max,
    );

    return Container(
      height: height,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.purple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: monthlyData.map<Widget>((data) {
            final barHeight = maxValue > 0
                ? (data.totalEarned / maxValue) * (height - 40)
                : 20.0;
            final monthNames = [
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec'
            ];
            final monthName = data.month >= 1 && data.month <= 12
                ? monthNames[data.month - 1]
                : '';

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Bar
                    Container(
                      height: barHeight.clamp(20, height - 60),
                      decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Month label
                    Text(
                      monthName,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
