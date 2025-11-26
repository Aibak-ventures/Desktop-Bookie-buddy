import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/view_model/user_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/ledger/models/payment_model/payment_model.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/generate_payment_pdf.dart';
import 'package:bookie_buddy_web/features/ledger/view/widgets/ledger_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LedgerPaymentGroupContainer extends StatelessWidget {
  const LedgerPaymentGroupContainer({
    required this.summaryDay,
    required this.payments,
    required this.date,
    super.key,
  });

  final String summaryDay;
  final List<PaymentModel> payments;
  final String date;

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
                  summaryDay,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.grey600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (payments
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
                      final currentDate =
                          payments.first.createdAt.formatToUiDate();
                      final total = payments.fold<double>(
                        0,
                        (previousValue, payment) =>
                            previousValue + payment.paymentAmount,
                      );
                      final entries = payments
                          .map(
                            (payment) => PaymentEntry(
                              date: payment.createdAt.formatToUiDate(),
                              time: payment.createdAt.formatToUiTime(),
                              details: payment.paymentMethod.name,
                              amount: payment.paymentAmount,
                            ),
                          )
                          .toList();
                      final user = builderContext.read<UserCubit>().state!;
                      final shop = user.shopDetails;
                      await PaymentPDFService.sharePaymentStatement(
                        context: builderContext,
                        paymentData: PaymentSummary(
                          shopDetails: shop,
                          fromDate: currentDate,
                          toDate: currentDate,
                          totalAmount: total,
                          entries: entries,
                        ),
                      );
                    }),
                  ),
              ],
            ),
          ),
          ...payments.map(
            (payment) => LedgerListTile(
              onTap: () {
                context
                    .push(BookingDetailsScreen(bookingId: payment.bookingId));
              },
              icon: Column(
                children: [
                  payment.paymentMethod.isCash ? AppAssets.cash : AppAssets.upi,
                  Text(
                    payment.createdAt.formatToUiTime(),
                    style: TextStyle(fontSize: 12.sp, color: AppColors.grey600),
                  ),
                ],
              ),
              content: Text(
                payment.clientName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              amount: payment.paymentAmount,
            ),
          ),
        ],
      );
}

class LedgerPaymentGroupShimmer extends StatelessWidget {
  const LedgerPaymentGroupShimmer({super.key});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header shimmer (summaryDay + Share button)
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                shimmerBox(height: 14), // summaryDay shimmer
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      shimmerCircle(size: 16),
                      const SizedBox(width: 6),
                      shimmerBox(width: 40, height: 14),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          /// 3 Ledger List Tile Shimmers (you can adjust how many based on need)
          ...List.generate(3, (index) => const LedgerListTileShimmer()),
        ],
      );

  Widget shimmerBox({
    double width = 100,
    double height = 16,
    double radius = 6,
  }) =>
      Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      );

  Widget shimmerCircle({double size = 20}) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      );
}
