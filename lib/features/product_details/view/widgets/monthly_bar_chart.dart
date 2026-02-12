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
          color: Colors.grey.shade50,
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

    // Find max value for scaling considering both expense and earned
    double maxValue = 0;
    for (var data in monthlyData) {
      if (data.totalEarned > maxValue) maxValue = data.totalEarned;
      if (data.totalExpense > maxValue) maxValue = data.totalExpense;
    }

    // Add some padding to maxValue so bars don't hit the top
    maxValue = maxValue == 0 ? 100 : maxValue * 1.2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legend
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildLegendItem('Earned', const Color(0xFF818CF8)),
              const SizedBox(width: 16),
              _buildLegendItem('Expense', const Color(0xFFFCA5A5)),
            ],
          ),
        ),
        Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: monthlyData.map<Widget>((data) {
                final earnedHeight =
                    (data.totalEarned / maxValue) * (height - 60);
                final expenseHeight =
                    (data.totalExpense / maxValue) * (height - 60);

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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Earned Bar
                          _buildBar(
                            height: earnedHeight.clamp(6.0, height - 60),
                            color: const Color(0xFF818CF8),
                            value: data.totalEarned,
                          ),
                          const SizedBox(width: 4),
                          // Expense Bar
                          _buildBar(
                            height: expenseHeight.clamp(6.0, height - 60),
                            color: const Color(0xFFFCA5A5),
                            value: data.totalExpense,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Month label
                      Text(
                        monthName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBar(
      {required double height, required Color color, required double value}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (value > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              value >= 1000
                  ? '${(value / 1000).toStringAsFixed(1)}k'
                  : value.toInt().toString(),
              style: TextStyle(
                fontSize: 9,
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        Container(
          width: 24,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
