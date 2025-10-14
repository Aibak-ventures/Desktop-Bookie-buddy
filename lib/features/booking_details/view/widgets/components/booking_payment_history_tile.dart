import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookingPaymentHistoryTile extends StatelessWidget {
  const BookingPaymentHistoryTile({
    super.key,
    required this.paymentHistory,
    this.isLoading = false,
  });

  final List<BookingDetailsPaymentHistoryModel> paymentHistory;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Container(
    padding: 12.padding,
    decoration: BoxDecoration(
      color: AppColors.purpleLight,
      borderRadius: 5.radiusBorder,
      boxShadow: [
        BoxShadow(
          color: AppColors.grey200,
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Skeletonizer(
      enabled: isLoading, // control shimmer automatically
      child: paymentHistory.isEmpty
          ? const Center(child: Text('No Payment History'))
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: paymentHistory.length,
              itemBuilder: (context, index) {
                final history = paymentHistory[index];

                return Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        history.dateTime.formatToUiDate(),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        history.dateTime.formatToUiTime(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Expanded(
                    //   child: Align(
                    //     alignment: Alignment.centerRight,
                    //     child: Image.asset(
                    //       history.paymentMethod == PaymentMethod.cash
                    //           ? 'assets/icons/cash-icon.png'
                    //           : AppIcons.upiIcon,
                    //       width: 20.w,
                    //       height: 20.w,
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        child: history.paymentMethod == PaymentMethod.cash
                            ? AppAssets.cash
                            : AppAssets.upi,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        history.amount.toCurrency(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
    ),
  );
}
