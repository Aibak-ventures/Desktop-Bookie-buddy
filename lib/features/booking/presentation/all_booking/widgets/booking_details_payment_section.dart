import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_payment_history_cubit/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/dialogs/show_booking_details_add_payment_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/components/booking_payment_history_tile.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// Payment details section for [BookingDetailsDrawer].
class BookingDetailsPaymentSection extends StatelessWidget {
  final BookingDetailsEntity booking;

  const BookingDetailsPaymentSection({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final productTotal = booking.bookedItems.fold<int>(
      0,
      (sum, item) => sum + (item.amount),
    );
    final additionalTotal = booking.additionalCharges.fold<int>(
      0,
      (sum, charge) => sum + (charge.amount ?? 0),
    );
    final totalAmount = booking.totalAmountWithSecurity ?? booking.totalAmount;
    final paid = booking.paidAmountWithSecurity ?? booking.actualPaidAmount;
    final discount = booking.discountAmount ?? 0;
    final balance = totalAmount - paid - discount;
    final securityAmount = booking.securityAmount ?? 0;
    final isPaymentCompleted = balance <= 0;

    final isCancelled = booking.deliveryStatus == DeliveryStatus.cancelled;
    final isCompleted = booking.bookingStatus == BookingStatus.completed;

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
                    'Payment details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  if (isCancelled)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.red.shade400,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.cancel,
                            color: Colors.red.shade700,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Cancelled',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (isCompleted || isPaymentCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        border: Border.all(color: Colors.green.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green.shade700,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ElevatedButton.icon(
                      onPressed: () {
                        performSecureActionDialog(
                          context,
                          SecretPasswordLocations.bookingPayment,
                          onSuccess: () {
                            showBookingDetailsAddPaymentDialog(
                              context: context,
                              id: booking.id,
                              balanceAmount: balance,
                            );
                          },
                        );
                      },
                      icon: const Icon(LucideIcons.plus, size: 16),
                      label: const Text('Add Payment'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        textStyle: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              _buildPaymentRow('Product total', '₹$productTotal'),
              const SizedBox(height: 8),
              if (discount > 0) ...[
                _buildPaymentRow(
                  'Discount',
                  '- ₹$discount',
                  valueColor: Colors.black87,
                ),
                const SizedBox(height: 8),
              ],
              if (securityAmount > 0) ...[
                _buildPaymentRow('Security amount', '₹$securityAmount'),
                const SizedBox(height: 4),
                if (booking.securityAccountName != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Security payment option',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            booking.securityAccountName!,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  const SizedBox(height: 4),
              ],
              if (additionalTotal > 0) ...[
                Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: const EdgeInsets.only(left: 16, bottom: 8),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Additional amount',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '₹$additionalTotal',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    children: booking.additionalCharges.map((charge) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              charge.name ?? 'Charge',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              '₹${charge.amount ?? 0}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
              ],
              const Divider(height: 24),
              _buildPaymentRow(
                'Total amount',
                '₹$totalAmount',
                isBold: true,
                fontSize: 15,
              ),
              const SizedBox(height: 8),
              _buildPaymentRow(
                'Paid',
                '₹$paid',
                valueColor: Colors.green.shade600,
                isBold: true,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              _buildPaymentRow(
                'Balance',
                '₹$balance',
                valueColor: balance > 0
                    ? Colors.red.shade600
                    : Colors.green.shade600,
                isBold: true,
                fontSize: 15,
              ),
              if (isCancelled) ...[
                const SizedBox(height: 12),
                const Divider(height: 24),
                const SizedBox(height: 8),
                if (booking.totalRefunded > 0)
                  _buildPaymentRow(
                    'Refunded',
                    '₹${booking.totalRefunded.toInt()}',
                    valueColor: Colors.green.shade600,
                    fontSize: 13,
                  ),
                if (booking.totalRefunded < paid) ...[
                  if (booking.totalRefunded > 0) const SizedBox(height: 6),
                  _buildPaymentRow(
                    'Deducted',
                    '₹${(paid - booking.totalRefunded.toInt())}',
                    valueColor: Colors.red.shade600,
                    fontSize: 13,
                  ),
                ],
              ],
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () {
                  final paymentHistoryCubit = context
                      .read<BookingDetailsPaymentHistoryCubit>();
                  if (paymentHistoryCubit.isExpanded) {
                    paymentHistoryCubit.collapsePaymentHistory();
                  } else {
                    paymentHistoryCubit.showPaymentHistory(
                      booking.payments,
                      booking.refunds,
                    );
                  }
                },
                label: const Text('Payment history'),
                iconAlignment: IconAlignment.end,
                icon:
                    BlocBuilder<
                      BookingDetailsPaymentHistoryCubit,
                      BookingDetailsPaymentHistoryState
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
          BookingDetailsPaymentHistoryCubit,
          BookingDetailsPaymentHistoryState
        >(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (error) => context.showSnackBar(error, isError: true),
            );
          },
          builder: (context, state) => state.maybeWhen(
            orElse: () => const SizedBox.shrink(),
            loading: () => BookingPaymentHistoryTile(
              bookingId: booking.id,
              paymentHistory: const [],
              refunds: booking.refunds,
              isLoading: true,
              canDeletePayments: false,
            ),
            expanded: (paymentHistory) => BookingPaymentHistoryTile(
              bookingId: booking.id,
              paymentHistory: paymentHistory,
              refunds: booking.refunds,
              canDeletePayments: !isCancelled && !isCompleted,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRow(
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
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
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
