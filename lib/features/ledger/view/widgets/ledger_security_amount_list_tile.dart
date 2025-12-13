import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/ledger/models/ledger_security_amount_model/ledger_security_amount_model.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LedgerSecurityAmountListTile extends StatelessWidget {
  const LedgerSecurityAmountListTile({
    super.key,
    required this.securityAmountModel,
    required this.date,
  });

  final LedgerSecurityAmountModel securityAmountModel;
  final DateTime date;

  @override
  Widget build(BuildContext context) => LedgerListTile(
        onTap: () {
          context.push(BookingDetailsScreen(
            bookingId: securityAmountModel.bookingId,
          ));
        },
        icon: Icon(
          LucideIcons.shieldUser,
          size: 28.sp,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              securityAmountModel.clientName,
            ),
            Text.rich(
              TextSpan(
                text: 'Booking date: ',
                children: [
                  TextSpan(
                    text: date.format(),
                    style: TextStyle(
                      color: AppColors.black.lighten(0.2),
                    ),
                  ),
                ],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.grey,
                ),
              ),
              maxLines: 2,
            ),
          ],
        ),
        amount: securityAmountModel.securityAmount,
      );
}

class LedgerSecurityAmountListTileShimmer extends StatelessWidget {
  const LedgerSecurityAmountListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) => LedgerListTile(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomShimmerBox(width: 30.w, height: 30.sp),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomShimmerBox(width: 100.w, height: 14.sp),
            8.height,
            CustomShimmerBox(width: 160.w, height: 12.sp),
          ],
        ),
        trailing: Expanded(
          child: Column(
            children: [
              CustomShimmerBox(width: 50.w, height: 20.sp),
            ],
          ),
        ),
      );
}
