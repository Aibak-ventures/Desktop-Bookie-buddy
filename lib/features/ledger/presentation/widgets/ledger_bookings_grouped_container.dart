import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/pages/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/ledger/domain/models/ledger_booking_model/ledger_booking_model.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/widgets/generate_statement_pdf.dart';
import 'package:bookie_buddy_web/features/ledger/presentation/widgets/ledger_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LedgerBookingsGroupedContainer extends StatelessWidget {
  const LedgerBookingsGroupedContainer({
    super.key,
    required this.groupedDate,
    required this.bookings,
  });

  final String groupedDate;
  final List<LedgerBookingModel> bookings;

  @override
  Widget build(BuildContext context) => Column(
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
                if (bookings
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
                        includeBookings: true,
                        isExcel: false,
                      );
                    }),
                  ),
              ],
            ),
          ),
          ...bookings.map(
            (booking) => LedgerListTile(
              onTap: () {
                context
                    .push(BookingDetailsScreen(bookingId: booking.bookingId));
              },
              icon: Column(
                children: [
                  Text(
                    booking.advanceAmount.toCurrency(),
                    style: TextStyle(fontSize: 14.sp, color: AppColors.black),
                  ),
                  Text(
                    'Paid',
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                  ),
                ],
              ),
              content: Column(
                children: [
                  Text(booking.clientName),
                  Text(
                    'Items: ${booking.bookedItems.join(', ')}',
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              trailing: Expanded(
                child: Column(
                  children: [
                    Text(
                      booking.totalAmount.toCurrency(),
                      style: TextStyle(fontSize: 14.sp, color: AppColors.black),
                    ),
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 12.sp, color: AppColors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}

class LedgerBookingListTileShimmer extends StatelessWidget {
  const LedgerBookingListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) => LedgerListTile(
        icon: Column(
          children: [
            CustomShimmerBox(width: 40.w, height: 12.sp),
            4.height,
            CustomShimmerBox(width: 30.w, height: 10.sp),
          ],
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
            children: [
              CustomShimmerBox(width: 50.w, height: 12.sp),
              4.height,
              CustomShimmerBox(width: 30.w, height: 10.sp),
            ],
          ),
        ),
      );
}
