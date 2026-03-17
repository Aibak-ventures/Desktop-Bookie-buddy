import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:bookie_buddy_web/features/client/domain/usecases/add_client_usecase.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/edit_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/components/booking_payment_history_tile.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/dialogs/show_booking_details_add_payment_dialog.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/painters/custom_payment_details_rectangle_painter.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_update_booking/update_booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsPaymentDetailsSection extends StatelessWidget {
  const BookingDetailsPaymentDetailsSection({
    super.key,
    required GlobalKey<State<StatefulWidget>> paymentButtonKey,
    required this.booking,
    required this.productTotalAmount,
    required this.additionalChargesTotal,
    required this.paymentHistoryCubit,
    required this.isPaymentCompleted,
  }) : _paymentButtonKey = paymentButtonKey;

  final GlobalKey<State<StatefulWidget>> _paymentButtonKey;
  final BookingDetailsModel booking;
  final int productTotalAmount;
  final int additionalChargesTotal;
  final BookingDetailsPaymentHistoryCubit paymentHistoryCubit;
  final bool isPaymentCompleted;

  @override
  Widget build(BuildContext context) => BookingDetailsSection(
        title: 'Payment details',
        child: null,
        customChild: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: CustomPaint(
                    painter: CustomPaymentDetailsRectanglePainter(() {
                      final context = _paymentButtonKey.currentContext;
                      if (context != null) {
                        final box = context.findRenderObject() as RenderBox;
                        final size = box.size;
                        return size;
                      }
                      return null;
                    }),
                    child: Padding(
                      padding: 10.padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 15,
                        children: [
                          1.height,
                          // Security amount (if exists)
                          if ((booking.securityAmount ?? 0) > 0)
                            _PaymentDetailsRow(
                              title: 'Security amount',
                              amount: booking.securityAmount ?? 0,
                            ),

                          if ((booking.securityAmount ?? 0) > 0)
                            const Divider(),

                          _PaymentDetailsRow(
                            fontSize: 15,
                            title: 'Product total',
                            amount: productTotalAmount,
                          ),
                          if (booking.additionalCharges.isNotEmpty)
                            ExpansionTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Additional charges (${booking.additionalCharges.length})',
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                  Text(
                                    additionalChargesTotal.toCurrency(),
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                            create: (context) =>
                                                UpdateBookingCubit(
                                              repository: context.read<
                                                  BookingRepositoryImpl>(),
                                              addClient: context
                                                  .read<AddClientUseCase>(),
                                            ),
                                            child: EditBookingScreen(
                                                booking: booking),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit_outlined,
                                      size: 16.sp,
                                      color: AppColors.purple,
                                    ),
                                    label: Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.purple,
                                      ),
                                    ),
                                  ),
                                  const Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                              shape: const Border(),
                              tilePadding: EdgeInsets.zero,
                              children: booking.additionalCharges
                                  .map(
                                    (charge) => Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.h),
                                      child: _PaymentDetailsRow(
                                        title: charge.name ?? '',
                                        amount: charge.amount ?? 0,
                                        fontSize: 15,
                                        color: AppColors.grey200,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),

                          const Divider(),

                          // Total amount
                          _PaymentDetailsRow(
                            title: 'Total amount',
                            amount: booking.totalAmount,
                            // isStrikethrough: true,
                          ),

                          // Discount amount (if exists)
                          if ((booking.discountAmount ?? 0) > 0)
                            _PaymentDetailsRow(
                              title: 'Discount',
                              amount: booking.discountAmount ?? 0,
                            ),

                          // Paid amount
                          _PaymentDetailsRow(
                            title: 'Paid',
                            amount: booking.actualPaidAmount,
                            isPaid: true,
                          ),

                          // Balance
                          _PaymentDetailsRow(
                            title: 'Balance',
                            amount: booking.totalAmount -
                                booking.actualPaidAmount -
                                (booking.discountAmount ?? 0),
                          ),

                          // Show refund details for cancelled bookings
                          if (booking.bookingStatus ==
                              BookingStatus.cancelled) ...[
                            const Divider(),

                            // Show refunded amount
                            if (booking.totalRefunded > 0)
                              _PaymentDetailsRow(
                                title: 'Refunded',
                                amount: booking.totalRefunded.toInt(),
                                color: Colors.green.shade600,
                              ),

                            // Calculate deducted amount: what was paid but not refunded
                            if (booking.totalRefunded <
                                booking.actualPaidAmount) ...[
                              _PaymentDetailsRow(
                                title: 'Deducted',
                                amount: (booking.actualPaidAmount -
                                    booking.totalRefunded.toInt()),
                                color: Colors.red.shade600,
                              ),
                            ],

                            // Show remaining refundable balance
                            if (booking.refundableBalance > 0)
                              _PaymentDetailsRow(
                                title: 'Remaining balance',
                                amount: booking.refundableBalance.toInt(),
                                color: AppColors.purple,
                                fontSize: 15,
                              ),
                          ],

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  if (paymentHistoryCubit.isExpanded) {
                                    paymentHistoryCubit
                                        .collapsePaymentHistory();
                                  } else {
                                    // Use payments data from booking details API (no separate API call)
                                    paymentHistoryCubit.showPaymentHistory(
                                      booking.payments,
                                      booking.refunds,
                                    );
                                  }
                                },
                                label: const Text('Payment history'),
                                iconAlignment: IconAlignment.end,
                                icon: BlocBuilder<
                                    BookingDetailsPaymentHistoryCubit,
                                    BookingDetailsPaymentHistoryState>(
                                  builder: (context, state) {
                                    final bool showExpandedIcon =
                                        state.maybeWhen(
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
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 2,
                  child: ElevatedButton.icon(
                    key: _paymentButtonKey,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: booking.bookingStatus ==
                              BookingStatus.cancelled
                          ? Colors.red.shade100
                          : (isPaymentCompleted ? AppColors.greenLight : null),
                    ),
                    onPressed: (isPaymentCompleted ||
                            booking.bookingStatus == BookingStatus.cancelled)
                        ? null
                        : () {
                            performSecureActionDialog(
                              context,
                              SecretPasswordLocations.bookingPayment,
                              onSuccess: () {
                                final int balance = booking.totalAmount -
                                    booking.actualPaidAmount -
                                    (booking.discountAmount ?? 0);
                                showBookingDetailsAddPaymentDialog(
                                  context: context,
                                  id: booking.id,
                                  balanceAmount: balance,
                                );
                              },
                            );
                          },
                    label: Text(
                      booking.bookingStatus == BookingStatus.cancelled
                          ? 'Cancelled'
                          : (isPaymentCompleted ? 'Completed' : 'Add payment'),
                      style: TextStyle(
                        color: booking.bookingStatus == BookingStatus.cancelled
                            ? Colors.red.shade700
                            : (isPaymentCompleted
                                ? AppColors.green2
                                : AppColors.white),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // ignore: use_decorated_box
                    icon: Container(
                      decoration: (isPaymentCompleted ||
                              booking.bookingStatus == BookingStatus.cancelled)
                          ? ShapeDecoration(
                              shape: CircleBorder(
                                side: BorderSide(
                                  color: AppColors.white,
                                  width: 1.5,
                                ),
                              ),
                            )
                          : null,
                      child: Icon(
                        booking.bookingStatus == BookingStatus.cancelled
                            ? Icons.cancel
                            : (isPaymentCompleted
                                ? Icons.check_circle
                                : Icons.add),
                        color: booking.bookingStatus == BookingStatus.cancelled
                            ? Colors.red.shade700
                            : (isPaymentCompleted ? AppColors.green2 : null),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            5.height,
            BlocConsumer<BookingDetailsPaymentHistoryCubit,
                BookingDetailsPaymentHistoryState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  error: (error) => context.showSnackBar(error, isError: true),
                );
              },
              builder: (context, state) => state.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                loading: () => BookingPaymentHistoryTile(
                  paymentHistory: const [],
                  refunds: booking.refunds,
                  isLoading: true,
                ),
                expanded: (paymentHistory) => BookingPaymentHistoryTile(
                  paymentHistory: paymentHistory,
                  refunds: booking.refunds,
                ),
              ),
            ),
          ],
        ),
      );
}

class _PaymentDetailsRow extends StatelessWidget {
  const _PaymentDetailsRow({
    required this.title,
    required this.amount,
    this.isPaid = false,
    this.color,
    this.fontSize,
  });

  final String title;
  final int amount;
  final bool isPaid;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: (fontSize ?? 16).sp, color: color),
          ),
          !isPaid
              ? Text(
                  amount.toCurrency(),
                  style: TextStyle(fontSize: (fontSize ?? 16).sp, color: color),
                )
              : Container(
                  padding: 5.padding,
                  decoration: BoxDecoration(
                    color: AppColors.purpleLight,
                    borderRadius: 5.radiusBorder,
                  ),
                  child: Text(
                    amount.toCurrency(),
                    style: TextStyle(fontSize: 16.sp, color: AppColors.purple),
                  ),
                ),
        ],
      );
}
