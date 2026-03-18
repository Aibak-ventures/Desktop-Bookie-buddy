import 'package:bookie_buddy_web/utils/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/pages/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/pending_model/ledger_pending_model.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/widgets/generate_statement_pdf.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/widgets/ledger_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LedgerPendingsGroupedContainer extends StatelessWidget {
  const LedgerPendingsGroupedContainer({
    super.key,
    required this.groupedDate,
    required this.pendings,
  });

  final String groupedDate;
  final List<LedgerPendingModel> pendings;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  groupedDate.getDateHeading(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.grey600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (pendings
                    .isNotEmpty) // Only show share button if payments exist
                  Builder(
                    builder: (builderContext) => Container(
                      decoration: BoxDecoration(
                        color: AppColors.purpleLightShade,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: 8.padding,
                      child: Row(
                        spacing: 4,
                        children: [
                          Icon(
                            Icons.share_outlined,
                            size: 18.sp,
                            semanticLabel: 'Share',
                          ),
                          Text(
                            'Share',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ).onTap(() async {
                      final date = groupedDate.formatToUiDate();

                      final user = builderContext.read<UserCubit>().state!;
                      await LedgerPDFService.shareLedgerInvoice(
                        context: builderContext,
                        user: user,
                        fromDate: date,
                        toDate: date,
                        includePendings: true,
                        isExcel: false,
                      );
                    }),
                  ),
              ],
            ),
          ),
          ...pendings.map((pending) {
            final date = pending.returnDate.parseToDateTime();
            return LedgerListTile(
              onTap: () {
                context
                    .push(BookingDetailsScreen(bookingId: pending.bookingId));
              },
              icon: const Icon(Icons.access_time_outlined, size: 28),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(pending.clientName),
                  Text.rich(
                    TextSpan(
                      text: 'Return date: ',
                      children: [
                        TextSpan(
                          text: date.format(),
                          style: TextStyle(
                            color: DateTime.now().isAfter(date.add(1.days()))
                                ? AppColors.redTomato.lighten(0.2)
                                : AppColors.black.lighten(0.2),
                          ),
                        ),
                      ],
                      style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
              amount: pending.remainingAmount,
            );
          }),
        ],
      );
}

class LedgerPendingsListTileShimmer extends StatelessWidget {
  const LedgerPendingsListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) => LedgerListTile(
        icon: Column(
          children: [CustomShimmerBox(width: 30.w, height: 30.sp)],
        ),
        content: Column(
          children: [
            CustomShimmerBox(width: 100.w, height: 14.sp),
            8.height,
            CustomShimmerBox(width: 160.w, height: 12.sp),
          ],
        ),
        trailing: Expanded(
          child: Column(
            children: [CustomShimmerBox(width: 50.w, height: 20.sp)],
          ),
        ),
      );
}
