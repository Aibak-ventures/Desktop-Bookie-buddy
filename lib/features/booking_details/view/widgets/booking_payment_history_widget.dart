import 'package:bookie_buddy_web/core/app_icons.dart';
import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookingPaymentHistoryWidget extends StatelessWidget {
  const BookingPaymentHistoryWidget({
    super.key,
    required this.paymentHistory,
    this.isLoading = false,
  });

  final List<BookingDetailsPaymentHistoryModel> paymentHistory;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(history.dateTime.formatToUiDate()),
                      Text(history.dateTime.formatToUiTime()),
                      // Image.asset(
                      //   history.paymentMethod == PaymentMethod.cash
                      //       ? 'assets/icons/cash-icon.png'
                      //       : AppIcons.upiIcon,
                      //   width: 28,
                      //   height: 28,
                      // ),
                      history.paymentMethod == PaymentMethod.cash
                          ? AppIcons.cash
                          : AppIcons.upi,
                      Text(history.amount.toCurrency()),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
      ),
    );
  }
}
