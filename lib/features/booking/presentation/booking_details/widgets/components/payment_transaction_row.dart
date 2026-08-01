import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

/// Single row rendering for any booking money transaction — a normal
/// payment, a refund, a security deposit payment, or a security
/// refund/deduction. Shared by [BookingPaymentHistoryTile],
/// [BookingSecurityRefundHistoryTile], and the security deposit summary row
/// so all money-transaction lists in booking details look identical.
class PaymentTransactionRow extends StatelessWidget {
  const PaymentTransactionRow({
    super.key,
    required this.dateTime,
    this.accountName,
    required this.amount,
    this.isNegative = false,
    this.amountColor,
    this.rowColor,
    this.note,
    this.canDelete = false,
    this.deleteLabel = 'Delete',
    this.onDelete,
    this.showMoreOptions = true,
  });

  /// ISO-ish date/time string, formatted internally via [formatToUiDate]/
  /// [formatToUiTime].
  final String dateTime;
  final String? accountName;
  final int amount;

  /// Whether to prefix the amount with `-` and default its color to red
  /// (used for refunds/deductions).
  final bool isNegative;
  final Color? amountColor;
  final Color? rowColor;
  final String? note;

  /// Whether the trailing overflow menu's delete action is enabled.
  final bool canDelete;
  final String deleteLabel;

  /// Called when the delete action is selected. The row itself doesn't
  /// perform any confirmation/auth — callers wrap this with whatever secure
  /// action / confirmation dialog is appropriate for their context.
  final VoidCallback? onDelete;
  final bool showMoreOptions;

  @override
  Widget build(BuildContext context) {
    final resolvedColor = rowColor ?? Colors.black87;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.05),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  dateTime.formatToUiDate(),
                  style: TextStyle(fontSize: 13, color: resolvedColor),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  dateTime.formatToUiTime(),
                  style: TextStyle(fontSize: 13, color: resolvedColor),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  accountName ?? '-',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  isNegative ? '-${amount.toCurrency()}' : amount.toCurrency(),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: amountColor ?? resolvedColor,
                  ),
                ),
              ),
              if (showMoreOptions)
                PopupMenuButton<String>(
                  tooltip: 'More options',
                  enabled: canDelete,
                  icon: const Icon(
                    Icons.more_vert,
                    size: 18,
                    color: Colors.black54,
                  ),
                  onSelected: (value) {
                    if (value == 'delete') onDelete?.call();
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
                          Text(deleteLabel),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (note != null && note!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Icon(Icons.notes, size: 12, color: Colors.grey.shade500),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      note!,
                      style: TextStyle(
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
