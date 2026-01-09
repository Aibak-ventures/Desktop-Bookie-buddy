import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/repositories/booking_repository.dart';
import 'package:bookie_buddy_web/core/repositories/client_repository.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/utils/open_external_applications.dart';
import 'package:bookie_buddy_web/features/booking_details/view/edit_booking_screen/edit_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/painters/custom_payment_details_rectangle_painter.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_client_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_date_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_invoice_and_delivery_status_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_location_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_other_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_product_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_time_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_update_booking/update_booking_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BookingDetailsRoot extends StatelessWidget {
  const BookingDetailsRoot({
    required this.booking,
    required this.paymentButtonKey,
    super.key,
  });

  final BookingDetailsModel booking;
  final GlobalKey paymentButtonKey;

  @override
  Widget build(BuildContext context) {
    final paymentHistoryCubit =
        context.read<BookingDetailsPaymentHistoryCubit>();
    final isPaymentCompleted = booking.paidAmount >=
        (booking.totalAmount - (booking.discountAmount ?? 0));
    final locationStart = booking.otherDetails.locationStart ?? '';
    final locationFrom = booking.otherDetails.locationFrom ?? '';
    final locationTo = booking.otherDetails.locationTo ?? '';
    final isHaveCoolingPeriod = booking.coolingPeriodDate != null &&
        !booking.coolingPeriodDate!.parseToDateTime().isSameDay(
              booking.returnDate.parseToDateTime(),
            );
    final productTotalAmount = booking.bookedItems.fold<int>(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
    final additionalChargesTotal = booking.additionalCharges.fold<int>(
      0,
      (previousValue, element) => previousValue + (element.amount ?? 0),
    );
    if (kDebugMode) {
      log(booking.toString(), name: 'BookingDetailsWidget');
    }

    final isWeb = MediaQuery.of(context).size.width > 768;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Responsive grid layout for web
        if (isWeb) ...[
          _buildWebSections(
            context,
            booking,
            locationStart,
            locationFrom,
            locationTo,
            isHaveCoolingPeriod,
            productTotalAmount,
            additionalChargesTotal,
            paymentHistoryCubit,
            isPaymentCompleted,
          ),
        ] else ...[
          _buildMobileSections(
            context,
            booking,
            locationStart,
            locationFrom,
            locationTo,
            isHaveCoolingPeriod,
            productTotalAmount,
            additionalChargesTotal,
            paymentHistoryCubit,
            isPaymentCompleted,
          ),
        ],
      ],
    );
  }

  Widget _buildWebSections(
    BuildContext context,
    BookingDetailsModel booking,
    String locationStart,
    String locationFrom,
    String locationTo,
    bool isHaveCoolingPeriod,
    int productTotalAmount,
    int additionalChargesTotal,
    BookingDetailsPaymentHistoryCubit paymentHistoryCubit,
    bool isPaymentCompleted,
  ) {
    return Column(
      children: [
        // Top row - Invoice & Status
        Container(
          width: double.infinity,
          // padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.only(bottom: 20),
          // decoration: BoxDecoration(
          //   color: Colors.blue.shade50,
          //   borderRadius: BorderRadius.circular(12),
          //   border: Border.all(color: Colors.blue.shade200),
          // ),
          child:
              BookingDetailsInvoiceAndDeliveryStatusSection(booking: booking),
        ),
        Row(
          children: [
            SizedBox(width: 10.w),
            Text(
              'Date & Time',
              style: TextStyle(
                color: Color(0xFF707070),
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        // SizedBox(height: 4.h),

        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup',
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          booking.pickupDate?.formatToRelativeDateTime() ??
                              'N/A',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Booked on',
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          booking.bookedDate.formatToUiDate(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Return',
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          booking.returnDate.formatToRelativeDateTime() ??
                              'N/A',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Available from',
                          style: TextStyle(
                            color: Color(0xFF707070),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          booking.returnDate.formatToUiDate(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            SizedBox(width: 10.w),
            Text(
              'Customer details',
              style: TextStyle(
                color: Color(0xFF707070),
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h),

        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            booking.client.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone 1',
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  booking.client.phone1.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              _launchPhoneCall(
                                  phone: booking.client.phone2.toString()),
                              SizedBox(width: 8.w),
                              _launchWhatsApp(
                                  phone: booking.client.phone2.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Place',
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            booking.address ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone 2',
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  booking.client.phone2.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              _launchPhoneCall(
                                  phone: booking.client.phone2.toString()),
                              SizedBox(width: 8.w),
                              _launchWhatsApp(
                                  phone: booking.client.phone2.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: BookingDetailsProductSection(booking: booking),
        ),
        // Row(
        //   children: [
        //     SizedBox(width: 18.w),
        //     Text(
        //       'Customer details',
        //       style: TextStyle(
        //         color: Color(0xFF707070),
        //         fontWeight: FontWeight.w400,
        //         fontSize: 18.sp,
        //       ),
        //     ),
        //   ],
        // ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   spacing: 15,
        //   children: [
        //     1.height,
        //     // Security amount (if exists)
        //     if ((booking.securityAmount ?? 0) > 0)
        //       _PaymentDetailsRow(
        //         title: 'Security amount',
        //         amount: booking.securityAmount ?? 0,
        //       ),

        //     if ((booking.securityAmount ?? 0) > 0) const Divider(),

        //     _PaymentDetailsRow(
        //       title: 'Product total',
        //       amount: productTotalAmount,
        //     ),
        //     if (booking.additionalCharges.isNotEmpty)
        //       ExpansionTile(
        //         title: Row(
        //           children: [
        //             Expanded(
        //               child: Text(
        //                 'Additional charges (${booking.additionalCharges.length})',
        //                 style: TextStyle(fontSize: 16.sp),
        //               ),
        //             ),
        //             Text(
        //               additionalChargesTotal.toCurrency(),
        //               style: TextStyle(fontSize: 16.sp),
        //             ),
        //           ],
        //         ),
        //         trailing: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           children: [
        //             TextButton.icon(
        //               onPressed: () {
        //                 Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                     builder: (context) => BlocProvider(
        //                       create: (context) => UpdateBookingCubit(
        //                         bookingRepository:
        //                             context.read<BookingRepository>(),
        //                         clientRepository:
        //                             context.read<ClientRepository>(),
        //                       ),
        //                       child: EditBookingScreen(booking: booking),
        //                     ),
        //                   ),
        //                 );
        //               },
        //               icon: Icon(
        //                 Icons.edit_outlined,
        //                 size: 16.sp,
        //                 color: AppColors.purple,
        //               ),
        //               label: Text(
        //                 'Edit',
        //                 style: TextStyle(
        //                   fontSize: 14.sp,
        //                   color: AppColors.purple,
        //                 ),
        //               ),
        //             ),
        //             const Icon(Icons.keyboard_arrow_down),
        //           ],
        //         ),
        //         shape: const Border(),
        //         tilePadding: EdgeInsets.zero,
        //         children: booking.additionalCharges
        //             .map(
        //               (charge) => Padding(
        //                 padding: EdgeInsets.symmetric(vertical: 5.h),
        //                 child: _PaymentDetailsRow(
        //                   title: charge.name ?? '',
        //                   amount: charge.amount ?? 0,
        //                   fontSize: 15,
        //                   color: AppColors.grey200,
        //                 ),
        //               ),
        //             )
        //             .toList(),
        //       ),

        //     const Divider(),

        //     // Total amount
        //     _PaymentDetailsRow(
        //       title: 'Total amount',
        //       amount: booking.totalAmount,
        //       // isStrikethrough: true,
        //     ),

        //     // Discount amount (if exists)
        //     if ((booking.discountAmount ?? 0) > 0)
        //       _PaymentDetailsRow(
        //         title: 'Discount',
        //         amount: booking.discountAmount ?? 0,
        //       ),

        //     // Paid amount
        //     _PaymentDetailsRow(
        //       title: 'Paid',
        //       amount: booking.paidAmount,
        //       isPaid: true,
        //     ),

        //     // Balance
        //     _PaymentDetailsRow(
        //       title: 'Balance',
        //       amount: booking.totalAmount -
        //           booking.paidAmount -
        //           (booking.discountAmount ?? 0),
        //     ),
        //     Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         TextButton.icon(
        //           onPressed: () {
        //             if (paymentHistoryCubit.isExpanded) {
        //               paymentHistoryCubit.collapsePaymentHistory();
        //             } else {
        //               paymentHistoryCubit.showPaymentHistory(
        //                 booking.id,
        //               );
        //             }
        //           },
        //           label: const Text('Payment history'),
        //           iconAlignment: IconAlignment.end,
        //           icon: BlocBuilder<BookingDetailsPaymentHistoryCubit,
        //               BookingDetailsPaymentHistoryState>(
        //             builder: (context, state) {
        //               final bool showExpandedIcon = state.maybeWhen(
        //                 orElse: () => false,
        //                 expanded: (_) => true,
        //                 loading: () => true,
        //               );
        //               return Icon(
        //                 showExpandedIcon
        //                     ? Icons.arrow_drop_up_outlined
        //                     : Icons.arrow_drop_down_outlined,
        //               );
        //             },
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  if (booking
                          .bookedItems.firstOrNull?.mainServiceType.isVehicle ??
                      false)
                    _buildWebCard(
                      'Location Details',
                      BookingDetailsLocationDetailsSection(
                        locationStart: locationStart,
                        locationFrom: locationFrom,
                        locationTo: locationTo,
                      ),
                    ),
                  // const SizedBox(height: 24),
                ],
              ),
            ),

            const SizedBox(width: 12),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileSections(
    BuildContext context,
    BookingDetailsModel booking,
    String locationStart,
    String locationFrom,
    String locationTo,
    bool isHaveCoolingPeriod,
    int productTotalAmount,
    int additionalChargesTotal,
    BookingDetailsPaymentHistoryCubit paymentHistoryCubit,
    bool isPaymentCompleted,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 15.h,
      children: [
        // Title row with invoice id and delivery status
        BookingDetailsInvoiceAndDeliveryStatusSection(booking: booking),

        // Client details section
        BookingDetailsClientSection(booking: booking),

        // Vehicle location details section
        if (booking.bookedItems.firstOrNull?.mainServiceType.isVehicle ?? false)
          BookingDetailsLocationDetailsSection(
            locationStart: locationStart,
            locationFrom: locationFrom,
            locationTo: locationTo,
          ),

        // Product details section
        BookingDetailsProductSection(booking: booking),

        // Time details section
        BookingDetailsTimeDetailsSection(booking: booking),

        // Date details section
        BookingDetailsDateSection(
          booking: booking,
          isHaveCoolingPeriod: isHaveCoolingPeriod,
        ),

        // Other details section
        BookingDetailsOtherDetailsSection(booking: booking),

        15.height,
      ],
    );
  }

  Widget _buildWebCard(String title, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _launchPhoneCall extends StatelessWidget {
  const _launchPhoneCall({required this.phone});
  final String phone;
  @override
  Widget build(BuildContext context) =>
      Icon(Icons.phone, size: 18.sp).onTapInkWell(
        () => OpenExternalApplications.makePhoneCall(phoneNumber: phone),
      );
}

class _launchWhatsApp extends StatelessWidget {
  const _launchWhatsApp({required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
        AppAssets.whatsAppSvg,
        colorFilter: const ColorFilter.mode(
          Color.fromARGB(255, 33, 192, 92), // WhatsApp green color
          BlendMode.srcIn,
        ),
        semanticsLabel: 'WhatsApp Icon',
        width: 20,
        height: 20,
      ).onTapInkWell(
          () => OpenExternalApplications.launchWhatsApp(phone: phone));
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
