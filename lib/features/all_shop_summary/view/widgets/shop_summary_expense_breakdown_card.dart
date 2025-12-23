import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/features/all_shop_summary/view/widgets/all_shop_summary_metrics_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopSummaryExpenseBreakdownCard extends StatelessWidget {
  final Map<String, int> expenses;
  final int totalExpense;

  const ShopSummaryExpenseBreakdownCard({
    super.key,
    required this.expenses,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    final expenseCategories = _getExpenseCategories(expenses);

    return AllShopSummaryMetricsContainer(
      child: Column(
        children: expenseCategories.map((category) {
          final amount = expenses[category.key] ?? 0;
          final percentage = amount.percentageOf(totalExpense).round();

          return _ExpenseItem(
            label: category.label,
            amount: amount,
            percentage: percentage,
            color: category.color,
            isLast: category == expenseCategories.last,
          );
        }).toList(),
      ),
    );
  }

  List<_ExpenseCategory> _getExpenseCategories(Map<String, int> expenses) {
    return expenses.entries
        .map(
          (e) => _ExpenseCategory(
            key: e.key,
            label: e.key.capitalizeFirstLetter(),
            color: Colors.yellow,
          ),
        )
        .toList();
  }
}

class _ExpenseCategory {
  final String key;
  final String label;
  final Color color;

  _ExpenseCategory({
    required this.key,
    required this.label,
    required this.color,
  });
}

// Reusable Expense Item
class _ExpenseItem extends StatelessWidget {
  final String label;
  final int amount;
  final int percentage;
  final Color color;
  final bool isLast;

  const _ExpenseItem({
    required this.label,
    required this.amount,
    required this.percentage,
    required this.color,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 12.paddingVertical,
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          // Color Dot
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          12.width,

          // Label
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Amount and Percentage
          Row(
            children: [
              Text(
                amount.toCurrency(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              8.width,
              Text(
                '$percentage%',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
