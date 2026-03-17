import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/domain/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Unified transaction entry for display
class TransactionEntry {
  final int amount;
  final PaymentMethod paymentMethod;
  final String dateTime;
  final bool isRefund;

  TransactionEntry({
    required this.amount,
    required this.paymentMethod,
    required this.dateTime,
    required this.isRefund,
  });
}

class BookingPaymentHistoryTile extends StatelessWidget {
  const BookingPaymentHistoryTile({
    super.key,
    required this.paymentHistory,
    this.refunds = const [],
    this.isLoading = false,
  });

  final List<BookingDetailsPaymentHistoryModel> paymentHistory;
  final List<dynamic> refunds;
  final bool isLoading;

  List<TransactionEntry> _getMergedTransactions() {
    final List<TransactionEntry> transactions = [];

    // Add payments
    for (final payment in paymentHistory) {
      transactions.add(TransactionEntry(
        amount: payment.amount,
        paymentMethod: payment.paymentMethod,
        dateTime: payment.dateTime,
        isRefund: false,
      ));
    }

    // Add refunds - API uses 'refunded_amount' field
    for (final refund in refunds) {
      if (refund is Map<String, dynamic>) {
        // Try 'refunded_amount' first (from API), then fallback to 'amount'
        final dynamic refundAmountRaw =
            refund['refunded_amount'] ?? refund['amount'] ?? 0;
        final int amount = refundAmountRaw is num ? refundAmountRaw.toInt() : 0;
        // API uses 'refund_method' for refunds
        final paymentMethodStr =
            refund['refund_method'] ?? refund['payment_method'] ?? 'cash';
        final dateTime = refund['created_at'] ?? refund['datetime'] ?? '';

        transactions.add(TransactionEntry(
          amount: amount,
          paymentMethod: PaymentMethod.fromJson(paymentMethodStr.toString()),
          dateTime: dateTime.toString(),
          isRefund: true,
        ));
      }
    }

    // Sort by datetime (newest first)
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return transactions;
  }

  @override
  Widget build(BuildContext context) {
    final transactions = _getMergedTransactions();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Skeletonizer(
        enabled: isLoading,
        child: transactions.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    'No Payment History',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];

                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: transaction.isRefund
                          ? Colors.transparent // No background for refunds
                          : AppColors.purple
                              .withOpacity(0.05), // Light purple for payments
                    ),
                    child: Row(
                      children: [
                        // Date
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.dateTime.formatToUiDate(),
                            style: TextStyle(
                              fontSize: 13,
                              color: transaction.isRefund
                                  ? Colors.red.shade700 // Red for refunds
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        // Time
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.dateTime.formatToUiTime(),
                            style: TextStyle(
                              fontSize: 13,
                              color: transaction.isRefund
                                  ? Colors.red.shade700 // Red for refunds
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        // Payment Icon
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.center,
                            child:
                                transaction.paymentMethod == PaymentMethod.cash
                                    ? AppAssets.cash
                                    : AppAssets.upi,
                          ),
                        ),
                        // Amount
                        Expanded(
                          flex: 3,
                          child: Text(
                            transaction.isRefund
                                ? '-${transaction.amount.toCurrency()}'
                                : transaction.amount.toCurrency(),
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: transaction.isRefund
                                  ? Colors.red.shade700 // Red for refunds
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey.shade300,
                ),
              ),
      ),
    );
  }
}
