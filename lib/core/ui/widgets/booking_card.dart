import 'dart:developer';

import 'package:bookie_buddy_web/core/constants/app_assets.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/string_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_model/booking_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/utils/app_date_utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class BookingCard extends StatelessWidget {
  final BookingsModel booking;
  final VoidCallback onTap;
  final bool useReturnDate;

  const BookingCard({
    required this.booking,
    required this.onTap,
    this.useReturnDate = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String clientName = booking.clientName;
    // final String paymentStatus = booking.paymentStatus.name;
    final deliveryStatus = booking.deliveryStatus;

    // Use return date if useReturnDate is true, otherwise use pickup date
    final DateTime? displayDate = useReturnDate
        ? (booking.returnDate != null
            ? booking.returnDate!.parseToDateTime()
            : null)
        : (booking.pickupDate != null
            ? booking.pickupDate!.parseToDateTime()
            : null);

    final isAfterReturnDate = booking.returnDate != null &&
        booking.bookingStatus != BookingStatus.completed &&
        DateTime.now().isAfter(
          booking.returnDate!.parseToDateTime().dateOnly.add(1.days()),
        );

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: 9.radiusBorder,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: AppColors.grey200),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          hoverColor: AppColors.purple.withOpacity(0.08),
          highlightColor: AppColors.purple.withOpacity(0.05),
          splashColor: AppColors.purple.withOpacity(0.1),
          child: Padding(
            padding: 16.padding,
            child: Row(
              children: [
                // Date Section
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: isAfterReturnDate
                        ? AppColors.redLight
                        : AppColors.purpleLight,
                    borderRadius: 9.radiusBorder,
                  ),
                  child: displayDate != null
                      ? _buildDateDisplay(displayDate, isAfterReturnDate)
                      : const Center(child: Text('--/--')),
                ),

                const SizedBox(width: 16),

                // Content Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Client Name
                      Text(
                        clientName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.purple,
                            size: 20.sp,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Items : ${booking.bookedItems.join(', ')}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      4.height,
                      // Status Badge
                      Row(
                        spacing: 5,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  deliveryStatus.color.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    deliveryStatus.color.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              deliveryStatus.name,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: deliveryStatus.color,
                              ),
                            ),
                          ),
                          if (isAfterReturnDate)
                            Tooltip(
                              message: 'Return date has passed',
                              triggerMode: TooltipTriggerMode.tap,
                              child: SvgPicture.asset(
                                AppAssets.infoDangerSvg,
                                errorBuilder: (context, error, stackTrace) {
                                  log(error.toString(), stackTrace: stackTrace);
                                  return const Icon(Icons.info);
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow Icon
                Icon(Icons.arrow_forward_ios,
                    color: AppColors.grey, size: 16.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build date display without Today/Tomorrow labels (shown in group headers instead)
  Widget _buildDateDisplay(DateTime displayDate, bool isAfterReturnDate) {
    final textColor = isAfterReturnDate ? AppColors.red : AppColors.purple;

    // Always show day and month consistently
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          displayDate.day.toString(),
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        Text(
          AppDateUtils.getMonthName(displayDate.month),
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class BookingCardShimmer extends StatelessWidget {
  const BookingCardShimmer({super.key});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: 16.padding,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: const Color(0xFFF0F0F0)),
        ),
        child: Shimmer.fromColors(
          baseColor: AppColors.grey300,
          highlightColor: AppColors.grey100,
          child: Row(
            children: [
              // Date Section Shimmer
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              const SizedBox(width: 16),

              // Content Section Shimmer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    // Client Name Shimmer
                    Container(
                      height: 24,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    // Payment Status Row Shimmer
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          height: 16,
                          width: 120,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),

                    // Status Badge Shimmer
                    Container(
                      height: 24,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              const Icon(Icons.arrow_forward_ios,
                  color: AppColors.grey, size: 16),
            ],
          ),
        ),
      );
}

// Shimmer List Widget for multiple cards
class BookingListShimmer extends StatelessWidget {
  final int itemCount;
  final bool alwaysScrollable;

  const BookingListShimmer({
    super.key,
    this.itemCount = 5,
    this.alwaysScrollable = true,
  });

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        physics: alwaysScrollable
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: itemCount,
        itemBuilder: (context, index) => const BookingCardShimmer(),
      );
}
