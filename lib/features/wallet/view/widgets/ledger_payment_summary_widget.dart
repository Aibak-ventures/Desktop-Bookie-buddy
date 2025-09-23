import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/wallet/models/daily_summary_model/daily_summary_model.dart';
import 'package:bookie_buddy_web/features/wallet/view/widgets/ledger_summary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LedgerPaymentSummaryWidget extends StatelessWidget {
  const LedgerPaymentSummaryWidget({
    required this.totalSummary,
    required this.summaryDay,
    super.key,
  });
  final PaymentsSummary? totalSummary;
  final String summaryDay;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        LedgerSummaryContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: _buildTotalColumn('UPI', totalSummary?.gpay ?? 0)),
              Expanded(
                  child: _buildTotalColumn('Cash', totalSummary?.cash ?? 0)),
              Expanded(
                  child: _buildTotalColumn(
                      'Total ', totalSummary?.total ?? 0, true)),
            ],
          ),
        ),
        Positioned(
          top: -15,
          left: 16,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
            decoration: BoxDecoration(
                color: AppColors.purpleLightShade,
                borderRadius: 5.radiusBorder,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withAlpha(80),
                    blurRadius: 4,
                    offset: const Offset(0, 1.5),
                  )
                ]),
            child: Text(
              summaryDay,
              style: TextStyle(
                color: AppColors.purple,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalColumn(
    String label,
    int value, [
    bool isTotal = false,
  ]) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        Text(
          value.toCurrency(decimalDigits: 0),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: (isTotal ? 20 : 18).sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
