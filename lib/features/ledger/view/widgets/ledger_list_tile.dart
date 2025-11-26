import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LedgerListTile extends StatelessWidget {
  final Widget icon;
  final Widget content;
  final int? amount;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  LedgerListTile({
    required this.icon,
    required this.content,
    this.amount,
    this.trailing,
    this.padding = const EdgeInsets.all(10),
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: padding,
        padding: 10.padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 10.radiusBorder,
          border: Border.all(
            color: AppColors.grey200,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey300,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // icon
            Expanded(
              child: icon,
            ),

            ///  content
            Expanded(
              flex: 2,
              child: DefaultTextStyle(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                child: content,
              ),
            ),

            // amount
            if (amount != null)
              Expanded(
                child: Text(
                  amount!.toCurrency(
                    symbol: false,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

            if (trailing != null) trailing!,
          ],
        ),
      ).onTap(onTap);
}

class LedgerListTileShimmer extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  const LedgerListTileShimmer({
    this.padding = const EdgeInsets.all(10),
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: padding,
        padding: 10.padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), // using same radiusBorder
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            /// Icon Placeholder
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 40,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: 10.radiusBorder,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            /// Content Placeholder
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: 10.radiusBorder,
                        color: Colors.grey.shade300,
                      ),
                      height: 15,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: 10.radiusBorder,
                        color: Colors.grey.shade300,
                      ),
                      height: 12,
                      width: 80,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            /// Amount Placeholder
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: 10.radiusBorder,
                    color: Colors.grey.shade300,
                  ),
                  height: 30,
                  width: 40,
                ),
              ),
            ),
          ],
        ),
      );
}
