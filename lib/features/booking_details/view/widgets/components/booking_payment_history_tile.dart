import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking_details/models/booking_details_payment_history_model/booking_details_payment_history_model.dart';
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

    // Add refunds (assuming refunds have same structure as payments)
    for (final refund in refunds) {
      if (refund is Map<String, dynamic>) {
        final amount = refund['amount'] as int? ?? 0;
        final paymentMethodStr = refund['payment_method'] as String? ?? 'cash';
        final dateTime = refund['datetime'] ?? refund['created_at'] ?? '';

        transactions.add(TransactionEntry(
          amount: amount,
          paymentMethod: PaymentMethod.fromJson(paymentMethodStr),
          dateTime: dateTime,
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
        child: transactions.isEmpty
            ? const Center(child: Text('No Payment History'))
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];

                  return Row(
                    children: [
                      // Type indicator (Payment/Refund)
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: transaction.isRefund
                                ? Colors.red.shade50
                                : Colors.green.shade50,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: transaction.isRefund
                                  ? Colors.red.shade200
                                  : Colors.green.shade200,
                            ),
                          ),
                          child: Text(
                            transaction.isRefund ? 'Refund' : 'Payment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: transaction.isRefund
                                  ? Colors.red.shade700
                                  : Colors.green.shade700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 4,
                        child: Text(
                          transaction.dateTime.formatToUiDate(),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          transaction.dateTime.formatToUiTime(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Align(
                          child: transaction.paymentMethod == PaymentMethod.cash
                              ? AppAssets.cash
                              : AppAssets.upi,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          transaction.isRefund
                              ? '- ${transaction.amount.toCurrency()}'
                              : transaction.amount.toCurrency(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: transaction.isRefund
                                ? Colors.red.shade700
                                : Colors.black,
                          ),
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
}
