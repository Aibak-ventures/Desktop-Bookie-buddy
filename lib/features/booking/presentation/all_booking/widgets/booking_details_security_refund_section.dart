import 'package:bookie_buddy_core/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/secret_password_locations_enum.dart';
import 'package:bookie_buddy_web/core/constants/enums/security_payment_enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_security_adjustment_dialog.dart';
import 'package:bookie_buddy_web/features/accounts/domain/entities/account_entity/account_entity.dart';
import 'package:bookie_buddy_core/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/extensions/booking_details_entity_web_extensions.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_security_refund_history_cubit/booking_details_security_refund_history_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/components/booking_security_refund_history_tile.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/components/payment_transaction_row.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Security deposit refund/deduction section for [BookingDetailsDrawer].
///
/// Only rendered when the booking has a security deposit. This is separate
/// from the normal payment/refund flow in [BookingDetailsPaymentSection]
/// since the security deposit is excluded from that balance calculation.
class BookingDetailsSecurityRefundSection extends StatelessWidget {
  final BookingDetailsEntity booking;

  const BookingDetailsSecurityRefundSection({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final securityDeposit = (booking.securityPayment?.amount ?? 0);
    if (securityDeposit <= 0 || !booking.showSecurityRefundSection) {
      return const SizedBox.shrink();
    }

    final isCancelled = booking.deliveryStatus == DeliveryStatus.cancelled;
    final isCompleted = booking.bookingStatus == BookingStatus.completed;

    final summary = booking.securityTransactionSummary;
    final pendingAmount =
        (securityDeposit - (summary.totalRefunded + summary.totalDeducted))
            .clamp(0, securityDeposit)
            .toInt();
    final isRefundCompleted = pendingAmount <= 0;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Security Deposit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: isRefundCompleted
                        ? null
                        : () => _onAddRefundPressed(context, pendingAmount),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isRefundCompleted
                            ? Colors.green.shade50
                            : Colors.white,
                        border: Border.all(
                          color: isRefundCompleted
                              ? Colors.green.shade200
                              : AppColors.purple,
                          width: isRefundCompleted ? 1 : 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isRefundCompleted ? Icons.check_circle : Icons.add,
                            color: isRefundCompleted
                                ? Colors.green.shade700
                                : AppColors.purple,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isRefundCompleted ? 'Completed' : 'Add Refund',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isRefundCompleted
                                  ? Colors.green.shade700
                                  : AppColors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (booking.securityPayment != null)
                PaymentTransactionRow(
                  dateTime:
                      booking.securityPayment!.paidAt ??
                      booking.securityPayment!.createdAt ??
                      '',
                  accountName: booking.securityPayment!.accountName,
                  amount: booking.securityPayment!.amount,
                  showMoreOptions: false,
                )
              else
                _buildRow('Security deposit', securityDeposit.toCurrency()),
              const Divider(height: 24),
              _buildRow(
                'Pending refund',
                pendingAmount.toCurrency(),
                isBold: true,
                fontSize: 15,
                valueColor: pendingAmount > 0 ? Colors.red.shade600 : null,
              ),
              const SizedBox(height: 8),
              if (summary.totalRefunded > 0) ...[
                _buildRow(
                  'Refunded',
                  summary.totalRefunded.toInt().toCurrency(),
                ),
                const SizedBox(height: 8),
              ],
              if (summary.totalDeducted > 0) ...[
                _buildRow(
                  'Deducted',
                  summary.totalDeducted.toInt().toCurrency(),
                ),
                const SizedBox(height: 8),
              ],

              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () {
                  final historyCubit = context
                      .read<BookingDetailsSecurityRefundHistoryCubit>();
                  if (historyCubit.isExpanded) {
                    historyCubit.collapseHistory();
                  } else {
                    historyCubit.showHistory(
                      booking.securityTransactionHistory,
                    );
                  }
                },
                label: const Text('Security history'),
                iconAlignment: IconAlignment.end,
                icon:
                    BlocBuilder<
                      BookingDetailsSecurityRefundHistoryCubit,
                      BookingDetailsSecurityRefundHistoryState
                    >(
                      builder: (context, state) {
                        final bool showExpandedIcon = state.maybeWhen(
                          orElse: () => false,
                          expanded: (_) => true,
                          loading: () => true,
                        );
                        return Icon(
                          showExpandedIcon
                              ? Icons.arrow_drop_up_outlined
                              : Icons.arrow_drop_down_outlined,
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        BlocConsumer<
          BookingDetailsSecurityRefundHistoryCubit,
          BookingDetailsSecurityRefundHistoryState
        >(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (error) => context.showSnackBar(error, isError: true),
            );
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => const BookingSecurityRefundHistoryTile(
              refundHistory: [],
              isLoading: true,
              onDeletePayment: _noop,
            ),
            expanded: (history) => BookingSecurityRefundHistoryTile(
              refundHistory: history,
              canDelete: !isCancelled && !isCompleted,
              onDeletePayment: (refund) {
                context.read<BookingDetailsBloc>().add(
                  BookingDetailsEvent.deleteSecurityRefundedPayment(
                    bookingId: booking.id,
                    paymentId: refund.id,
                    securityPaymentType: refund.type,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  static void _noop(dynamic _) {}

  void _onAddRefundPressed(BuildContext context, int pendingAmount) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.bookingPayment,
      onSuccess: () {
        showSecurityAdjustmentDialog(
          context: context,
          balanceAmount: pendingAmount,
          onSubmit: ({required amount, required action, account, note}) =>
              _submitAdjustment(
                context: context,
                amount: amount,
                action: action,
                account: account,
                note: note,
              ),
        );
      },
    );
  }

  Future<String?> _submitAdjustment({
    required BuildContext context,
    required int amount,
    required SecurityTransactionAction action,
    AccountEntity? account,
    String? note,
  }) async {
    final accountId = action.isDeduction
        ? (booking.securityPayment?.accountId ?? account?.id)
        : account?.id;

    if (accountId == null) {
      return 'Please select an account';
    }

    final bloc = context.read<BookingDetailsBloc>();

    bloc.add(
      BookingDetailsEvent.updateSecurityRefund(
        bookingId: booking.id,
        refundAmount: action.isDeduction ? null : amount,
        deductionAmount: action.isDeduction ? amount : null,
        accountId: accountId,
        note: note,
      ),
    );

    final state = await bloc.stream
        .firstWhere(
          (state) => state.maybeWhen(
            loaded: (_) => true,
            failed: (_, _, _) => true,
            orElse: () => false,
          ),
        )
        .timeout(
          const Duration(seconds: 30),
          onTimeout: () => throw Exception('Request timed out'),
        );

    return state.maybeWhen(
      loaded: (_) => null,
      failed: (error, _, _) => error,
      orElse: () => null,
    );
  }

  Widget _buildRow(
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
    double? fontSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize ?? 13,
            color: Colors.black87,
            fontWeight: isBold ? .w600 : .w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize ?? 13,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}
