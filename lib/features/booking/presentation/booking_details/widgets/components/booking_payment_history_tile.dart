// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/constants/enums/secret_password_locations_enum.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';

// Unified transaction entry for display
class TransactionEntry {
  final int? id;
  final int amount;
  final String? accountName;
  final int? accountId;
  final String dateTime;
  final bool isRefund;
  final BookingPaymentHistoryPaymentType paymentType;

  TransactionEntry({
    required this.id,
    required this.amount,
    required this.accountName,
    required this.accountId,
    required this.dateTime,
    required this.isRefund,
    this.paymentType = BookingPaymentHistoryPaymentType.payment,
  });

  @override
  String toString() {
    return 'TransactionEntry(id: $id, amount: $amount, accountName: $accountName, accountId: $accountId, dateTime: $dateTime, isRefund: $isRefund, paymentType: $paymentType)';
  }
}

class BookingPaymentHistoryTile extends StatelessWidget {
  const BookingPaymentHistoryTile({
    super.key,
    required this.bookingId,
    required this.paymentHistory,
    this.refunds = const [],
    this.isLoading = false,
    this.canDeletePayments = false,
    this.canDeleteRefunds = false,
  });

  final int bookingId;
  final List<BookingPaymentHistoryEntity> paymentHistory;
  final List<dynamic> refunds;
  final bool isLoading;
  final bool canDeletePayments;
  final bool canDeleteRefunds;

  List<TransactionEntry> _getMergedTransactions() {
    final List<TransactionEntry> transactions = [];

    // Add payments
    for (final payment in paymentHistory) {
      transactions.add(
        TransactionEntry(
          id: payment.id,
          amount: payment.amount,
          accountName: payment.accountName,
          accountId: payment.accountId,
          dateTime: payment.createdAt,
          isRefund: false,
          paymentType: payment.paymentType,
        ),
      );
    }

    // Add refunds - API uses 'refunded_amount' field
    for (final refund in refunds) {
      if (refund is Map<String, dynamic>) {
        final dynamic refundIdRaw = refund['id'];
        // Try 'refunded_amount' first (from API), then fallback to 'amount'
        final dynamic refundAmountRaw =
            refund['refunded_amount'] ?? refund['amount'] ?? 0;
        final int amount = refundAmountRaw is num ? refundAmountRaw.toInt() : 0;

        final String? accountName = refund['account_name'] as String?;
        final int? accountId = refund['account_id'] as int?;
        final dateTime = refund['created_at'] ?? refund['datetime'] ?? '';

        transactions.add(
          TransactionEntry(
            id: refundIdRaw is num ? refundIdRaw.toInt() : null,
            amount: amount,
            accountName: accountName,
            accountId: accountId,
            dateTime: dateTime.toString(),
            isRefund: true,
          ),
        );
      }
    }

    // Sort by datetime (newest first)
    transactions.sort((a, b) => b.dateTime.compareTo(a.dateTime));

    return transactions;
  }

  // Calculate total paid and total refunded without security
  ({int totalPaid, int totalRefunded}) _getTotalsWithoutSecurity(
    List<TransactionEntry> transactions,
  ) {
    int totalPaid = 0;
    int totalRefunded = 0;
    for (final trans in transactions) {
      if (trans.paymentType == BookingPaymentHistoryPaymentType.security) {
        continue;
      }
      if (trans.isRefund) {
        totalRefunded += trans.amount;
      } else {
        totalPaid += trans.amount;
      }
    }

    return (totalPaid: totalPaid, totalRefunded: totalRefunded);
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
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final canDeleteThisPayment =
                      canDeletePayments &&
                      !transaction.isRefund &&
                      transaction.id != null;
                  final canDeleteThisRefund =
                      canDeleteRefunds &&
                      transaction.isRefund &&
                      transaction.id != null;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.purple.withValues(
                        alpha: 0.05,
                      ), // Light purple for payments
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
                                  ? Colors
                                        .red
                                        .shade700 // Red for refunds
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
                                  ? Colors
                                        .red
                                        .shade700 // Red for refunds
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        // Payment Icon
                        Expanded(
                          flex: 2,
                          child: Text(
                            transaction.accountName ?? 'Payment',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 12),
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
                                  ? Colors
                                        .red
                                        .shade700 // Red for refunds
                                  : Colors.black87,
                            ),
                          ),
                        ),

                        PopupMenuButton<String>(
                          tooltip: 'More options',
                          enabled: canDeleteThisPayment || canDeleteThisRefund,
                          icon: const Icon(
                            Icons.more_vert,
                            size: 18,
                            color: Colors.black54,
                          ),
                          onSelected: (value) {
                            if (value == 'delete') {
                              if (transaction.paymentType ==
                                  BookingPaymentHistoryPaymentType.security) {
                                context.showSnackBar(
                                  'Security deposit payments cannot be deleted',
                                  title: 'Action not allowed',
                                  isError: true,
                                );
                                return;
                              }

                              if (canDeleteThisRefund) {
                                _onDeleteRefundPressed(context, transaction);
                                return;
                              }

                              final (
                                totalPaid: totalPaid,
                                totalRefunded: totalRefunded,
                              ) = _getTotalsWithoutSecurity(
                                transactions,
                              );
                              // payment cannot be deleted if this payment decreases balance below 0
                              if ((totalPaid - transaction.amount) <
                                  totalRefunded) {
                                context.showSnackBar(
                                  'Payment cannot be deleted, balance cannot be less than 0',
                                  title: 'Action not allowed',
                                  isError: true,
                                );
                                return;
                              }

                              _onDeletePaymentPressed(context, transaction);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<String>(
                              value: 'delete',
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.delete_outline,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    canDeleteThisRefund
                                        ? 'Delete refund'
                                        : 'Delete payment',
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  Future<void> _onDeleteRefundPressed(
    BuildContext context,
    TransactionEntry transaction,
  ) async {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.bookingPayment,
      onSuccess: () async {
        final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Delete Refund'),
            content: Text(
              'Are you sure you want to delete ${transaction.amount.toCurrency()} from refund history?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );

        if (shouldDelete == true && context.mounted && transaction.id != null) {
          context.read<BookingDetailsBloc>().add(
            BookingDetailsEvent.deleteRefund(
              bookingId: bookingId,
              refundId: transaction.id!,
            ),
          );
        }
      },
    );
  }

  Future<void> _onDeletePaymentPressed(
    BuildContext context,
    TransactionEntry transaction,
  ) async {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.bookingPayment,
      onSuccess: () async {
        final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Delete Payment'),
            content: Text(
              'Are you sure you want to delete ${transaction.amount.toCurrency()} from payment history?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );

        if (shouldDelete == true && context.mounted && transaction.id != null) {
          context.read<BookingDetailsBloc>().add(
            BookingDetailsEvent.deletePayment(
              bookingId: bookingId,
              paymentId: transaction.id!,
            ),
          );
        }
      },
    );
  }
}
