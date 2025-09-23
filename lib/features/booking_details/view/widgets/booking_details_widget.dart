import 'package:bookie_buddy_web/core/enums/enums.dart';
import 'package:bookie_buddy_web/core/extensions/color_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/ui/widgets/customization_expansion_tile.dart';
import 'package:bookie_buddy_web/core/ui/widgets/product_simple_details_tile.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/alert_dialog_with_text_field.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/booking_payment_history_widget.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/custom_payment_details_rectangle_painter.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDetailsWidget extends StatelessWidget {
  BookingDetailsWidget({
    required this.booking,
    super.key,
  });

  final BookingDetailsModel booking;
  final showPaymentHistoryNotifier = ValueNotifier<bool>(false);
  final GlobalKey _paymentButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final paymentHistoryCubit =
        context.read<BookingDetailsPaymentHistoryCubit>();
    final isPaymentCompleted = booking.paidAmount >=
        (booking.totalAmount - (booking.discountAmount ?? 0));
    final locationStart =
        booking.otherDetails['location_start'] as String? ?? '';
    final locationFrom = booking.otherDetails['location_from'] as String? ?? '';
    final locationTo = booking.otherDetails['location_to'] as String? ?? '';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTitleRow(
          title: '',
          // Invoice id
          leading: Flexible(
            child: Container(
              padding: 8.padding,
              decoration: BoxDecoration(
                color: AppColors.purpleLightShade,
                borderRadius: 5.radiusBorder,
              ),
              child: Text(
                'ID: ${booking.invoiceId}',
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),

          // Delivery status
          trailing: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 6.w,
            ),
            decoration: BoxDecoration(
              color: booking.deliveryStatus.color.lighten(0.9),
              borderRadius: 50.radiusBorder,
            ),
            child: DropdownButton<DeliveryStatus>(
              alignment: Alignment.center,
              value: booking.deliveryStatus,
              underline: const SizedBox(),
              dropdownColor: AppColors.white,
              isDense: true,
              borderRadius: 10.radiusBorder,
              onChanged: booking.bookingStatus == BookingStatus.completed
                  ? null
                  : (newValue) {
                      if (newValue != null &&
                          newValue != booking.deliveryStatus) {
                        _confirmStatusChange(
                          context,
                          newValue,
                        );
                      }
                    },
              items: DeliveryStatus.values.map(
                (status) {
                  return DropdownMenuItem<DeliveryStatus>(
                    alignment: Alignment.center,
                    value: status,
                    child: Text(
                      status.name,
                      style: TextStyle(
                        color: status.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),

        15.height,

        _buildTitleRow(title: 'Client details'),

        10.height,

        // Client details card
        _buildContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.h,
            children: [
              _buildDetailColumn(
                'Name',
                booking.client.name,
              ),
              _buildDetailColumn(
                'Phone 1',
                booking.client.phone1.toString(),
              ),
              if (booking.client.phone2 != null)
                _buildDetailColumn(
                  'Phone 2',
                  booking.client.phone2.toString(),
                ),
              if (booking.address != null && booking.address!.isNotEmpty)
                _buildDetailColumn(
                  'Place',
                  booking.address!,
                ),
            ],
          ),
          padding: 18.padding,
        ),
        15.height,
        if ((booking.bookedItems.firstOrNull?.mainServiceType.isVehicle ??
            false)) ...[
          _buildTitleRow(title: 'Location details'),
          5.height,
          _buildContainer(
            Column(
              spacing: 15,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildNormalText('Start Location'),
                    ),
                    Expanded(
                      child: _buildNormalText(
                        locationStart.isNotEmpty
                            ? locationStart
                            : 'Not available',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildNormalText('Pickup Location'),
                    ),
                    Expanded(
                      child: _buildNormalText(
                        locationFrom.isNotEmpty
                            ? locationFrom
                            : 'Not available',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildNormalText(
                        'Destination',
                      ),
                    ),
                    Expanded(
                      child: _buildNormalText(
                        locationTo.isNotEmpty ? locationTo : 'Not available',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            padding: 18.padding,
          ),
        ],

        15.height,
        _buildTitleRow(title: 'Product details'),

        5.height,
        _buildContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: booking.bookedItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = booking.bookedItems[index];

                  return Column(
                    children: [
                      ProductSimpleDetailsTile(
                        product: product,
                        amount: product.amount,
                      ),
                      if ((product.mainServiceType.isDress ||
                              product.mainServiceType.isVehicle) &&
                          product.measurements.isNotEmpty)
                        CustomizationExpansionTile(
                          expansionTitle: product.mainServiceType.isVehicle
                              ? 'More Details'
                              : null,
                          measurements: product.measurements,
                          isButtonVisible: false,
                          trailingWidget: product.measurements.isNotEmpty
                              ? 5.height
                              : Padding(
                                  padding: 10.padding,
                                  child: const Text('No measurements'),
                                ),
                        )
                    ],
                  );
                },
              ),
              if (booking.description != null &&
                  booking.description!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(
                    // top: 16.w,
                    left: 16.w,
                    right: 16.w,
                    bottom: 20.w,
                  ),
                  child: _buildDetailColumn(
                    'Note',
                    booking.description!,
                  ),
                )
            ],
          ),
        ),

        15.height,

        _buildTitleRow(title: 'Times'),

        5.height,
        _buildContainer(
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 15.w,
            runSpacing: 15.w,
            children: [
              _buildDetailColumn(
                'Pickup Time',
                booking.pickupDate?.formatToUiTime() ?? 'N/A',
              ),
              _buildDetailColumn(
                'Return Time',
                booking.returnDate.formatToUiTime(),
              ),
            ],
          ),
          padding: 12.padding,
        ),
        15.height,

        _buildTitleRow(title: 'Dates'),

        5.height,
        _buildContainer(
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 15.w,
            runSpacing: 15.w,
            children: [
              _buildDetailColumn(
                'Booked date',
                booking.bookedDate.formatToUiDate(),
              ),
              // 80.width,
              _buildDetailColumn(
                'Pickup date',
                booking.pickupDate?.formatToUiDate() ?? 'N/A',
              ),
              _buildDetailColumn(
                'Return date',
                booking.returnDate.formatToUiDate(),
              ),
            ],
          ),
          padding: 12.padding,
        ),

        15.height,

        _buildTitleRow(title: 'Payment details'),

        5.height,
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: CustomPaint(
                painter: CustomPaymentDetailsRectanglePainter(
                  () {
                    final context = _paymentButtonKey.currentContext;
                    if (context != null) {
                      final box = context.findRenderObject() as RenderBox;
                      final size = box.size;
                      return size;
                    }
                    return null;
                  },
                ),
                child: Padding(
                  padding: 10.padding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 15,
                    children: [
                      1.height,
                      // Security amount (if exists)
                      if ((booking.securityAmount ?? 0) > 0)
                        _buildPaymentDetailsRow(
                          title: 'Security amount',
                          amount: booking.securityAmount ?? 0,
                        ),

                      if ((booking.securityAmount ?? 0) > 0) const Divider(),

                      // Total amount
                      _buildPaymentDetailsRow(
                        title: 'Total amount',
                        amount: booking.totalAmount,
                        // isStrikethrough: true,
                      ),

                      // Discount amount (if exists)
                      if ((booking.discountAmount ?? 0) > 0)
                        _buildPaymentDetailsRow(
                          title: 'Discount',
                          amount: (booking.discountAmount ?? 0),
                        ),

                      // Paid amount
                      _buildPaymentDetailsRow(
                        title: 'Paid',
                        amount: booking.paidAmount,
                        isPaid: true,
                      ),

                      // Balance
                      _buildPaymentDetailsRow(
                        title: 'Balance',
                        amount: booking.totalAmount -
                            booking.paidAmount -
                            (booking.discountAmount ?? 0),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              if (paymentHistoryCubit.isExpanded) {
                                paymentHistoryCubit.collapsePaymentHistory();
                              } else {
                                paymentHistoryCubit
                                    .showPaymentHistory(booking.id);
                              }
                            },
                            label: const Text('Payment history'),
                            iconAlignment: IconAlignment.end,
                            icon: BlocBuilder<BookingDetailsPaymentHistoryCubit,
                                BookingDetailsPaymentHistoryState>(
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
                          'payment',
                          onSuccess: () {
                            final int balance =
                                booking.totalAmount - booking.paidAmount;
                            showCustomAlertDialog(
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
                    color:
                        isPaymentCompleted ? AppColors.green2 : AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
            )
          ],
        ),

        5.height,

        BlocConsumer<BookingDetailsPaymentHistoryCubit,
            BookingDetailsPaymentHistoryState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              error: (error) => context.showSnackBar(
                error,
                isError: true,
              ),
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const SizedBox.shrink(),
              loading: () => const BookingPaymentHistoryWidget(
                paymentHistory: [],
                isLoading: true,
              ),
              expanded: (paymentHistory) => BookingPaymentHistoryWidget(
                paymentHistory: paymentHistory,
              ),
            );
          },
        ),

        15.height,

        _buildTitleRow(title: 'Other details'),

        5.height,

        _buildContainer(
          Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailColumn('Staff name', booking.staffName),
              _buildDetailColumn('Purchase mode', booking.purchaseMode.name),
            ],
          ),
          padding: 12.padding,
        ),

        15.height,
      ],
    );
  }

  //*######### Helper methods and widgets ###########//

  Text _buildNormalText(
    String text, {
    TextAlign? textAlign,
    double fontSize = 14,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize.sp,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Row _buildPaymentDetailsRow({
    required String title,
    required int amount,
    bool isPaid = false,
    bool isStrikethrough = false, // New parameter for strikethrough
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
          ),
        ),
        !isPaid
            ? Text(
                amount.toCurrency(),
                style: TextStyle(
                  fontSize: 16.sp,
                  decoration:
                      isStrikethrough ? TextDecoration.lineThrough : null,
                  decorationColor:
                      isStrikethrough ? Colors.grey.shade500 : null,
                  decorationThickness: isStrikethrough ? 2.0 : null,
                  color: isStrikethrough ? Colors.grey.shade600 : null,
                ),
              )
            : Container(
                padding: 5.padding,
                decoration: BoxDecoration(
                  color: AppColors.purpleLight,
                  borderRadius: 5.radiusBorder,
                ),
                child: Text(
                  amount.toCurrency(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.purple,
                  ),
                ),
              )
      ],
    );
  }

  Container _buildContainer(
    Widget child, {
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: 10.radiusBorder,
        border: Border.all(color: AppColors.greyBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey200,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildTitleRow({
    required String title,
    Widget? trailing,
    Widget? leading,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (leading != null) leading,
        if (title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  void _confirmStatusChange(
    BuildContext context,
    DeliveryStatus newStatus,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Status Change"),
        content: Text(
          "Are you sure you want to change the status to '${newStatus.name}'?",
        ),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              context.pop();

              context.read<BookingDetailsBloc>().add(
                    BookingDetailsEvent.updateDeliveryStatus(
                      bookingId: booking.id,
                      deliveryStatus: newStatus,
                    ),
                  );

              final bookingCubit = context.read<BookingSelectionCubit>();
              bookingCubit.markModified();
              final newBooking = bookingCubit.state.selectedBooking!
                  .copyWith(deliveryStatus: newStatus);
              bookingCubit.selectBooking(newBooking);
            },
            child: const Text(
              "Confirm",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
