import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_summary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LedgerSummarySimpleWidget extends StatelessWidget {
  const LedgerSummarySimpleWidget({
    required this.title,
    required this.amount,
    super.key,
  });
  final String title;
  final int amount;
  @override
  Widget build(BuildContext context) => LedgerSummaryContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
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
                title,
                style: TextStyle(
                  color: AppColors.purple,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
            ),
            Text(
              amount.toCurrency(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
}
