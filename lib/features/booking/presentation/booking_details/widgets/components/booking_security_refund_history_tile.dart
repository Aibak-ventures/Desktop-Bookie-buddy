import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/constants/enums/secret_password_locations_enum.dart';
import 'package:bookie_buddy_core/features/booking/domain/entities/booking_payment_history_entity/booking_payment_history_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/components/payment_transaction_row.dart';

class BookingSecurityRefundHistoryTile extends StatelessWidget {
  const BookingSecurityRefundHistoryTile({
    super.key,
    required this.refundHistory,
    required this.onDeletePayment,
    this.isLoading = false,
    this.canDelete = false,
  });

  final List<BookingSecurityRefundHistoryEntity> refundHistory;
  final bool isLoading;
  final bool canDelete;
  final void Function(BookingSecurityRefundHistoryEntity refund)
  onDeletePayment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Skeletonizer(
        enabled: isLoading,
        child: refundHistory.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text(
                    'No History',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: refundHistory.length,
                itemBuilder: (context, index) {
                  final refund = refundHistory[index];

                  return PaymentTransactionRow(
                    dateTime: refund.createdAt,
                    accountName: refund.accountName,
                    amount: refund.amount,
                    isNegative: refund.type.isDeduction,
                    rowColor: refund.type.isDeduction
                        ? Colors.red.shade700
                        : null,
                    note: refund.note,
                    canDelete: canDelete,
                    deleteLabel: refund.type.isDeduction
                        ? 'Delete deduction'
                        : 'Delete refund',
                    onDelete: () {
                      performSecureActionDialog(
                        context,
                        SecretPasswordLocations.bookingPayment,
                        onSuccess: () => onDeletePayment(refund),
                      );
                    },
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
