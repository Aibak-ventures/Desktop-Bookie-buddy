import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
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
                                              bookingRepository: context
                                                  .read<BookingRepository>(),
                                              clientRepository: context
                                                  .read<ClientRepository>(),
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
                            amount: booking.paidAmount,
                            isPaid: true,
                          ),

                          // Balance
                          _PaymentDetailsRow(
                            title: 'Balance',
                            amount: booking.totalAmount -
                                booking.paidAmount -
                                (booking.discountAmount ?? 0),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  if (paymentHistoryCubit.isExpanded) {
                                    paymentHistoryCubit
                                        .collapsePaymentHistory();
                                  } else {
                                    paymentHistoryCubit.showPaymentHistory(
                                      booking.id,
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
                      backgroundColor:
                          isPaymentCompleted ? AppColors.greenLight : null,
                    ),
                    onPressed: isPaymentCompleted
                        ? () {}
                        : () {
                            performSecureActionDialog(
                              context,
                              SecretPasswordLocations.bookingPayment,
                              onSuccess: () {
                                final int balance = booking.totalAmount -
                                    booking.paidAmount -
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
                      isPaymentCompleted ? 'Completed' : 'Add payment',
                      style: TextStyle(
                        color: isPaymentCompleted
                            ? AppColors.green2
                            : AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // ignore: use_decorated_box
                    icon: Container(
                      decoration: isPaymentCompleted
                          ? const ShapeDecoration(
                              shape: CircleBorder(
                                side: BorderSide(
                                  color: AppColors.white,
                                  width: 1.5,
                                ),
                              ),
                            )
                          : null,
                      child: Icon(
                        isPaymentCompleted ? Icons.check_circle : Icons.add,
                        color: isPaymentCompleted ? AppColors.green2 : null,
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
                loading: () => const BookingPaymentHistoryTile(
                  paymentHistory: [],
                  isLoading: true,
                ),
                expanded: (paymentHistory) =>
                    BookingPaymentHistoryTile(paymentHistory: paymentHistory),
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
