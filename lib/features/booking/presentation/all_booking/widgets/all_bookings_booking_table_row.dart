import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/desktop_booking_item_entity/desktop_booking_item_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A single data row in the bookings table of [AllBookingsDesktopScreen].
///
/// Tapping the row opens the [BookingDetailsDrawer] for the given booking.
class AllBookingsBookingTableRow extends StatelessWidget {
  final DesktopBookingItemEntity booking;
  final String Function(String dateStr) formatDateWithLabel;
  final Color Function(String? staffColor) parseStaffColor;

  const AllBookingsBookingTableRow({
    super.key,
    required this.booking,
    required this.formatDateWithLabel,
    required this.parseStaffColor,
  });

  @override
  Widget build(BuildContext context) {
    final status = booking.deliveryStatus ?? DeliveryStatus.booked;
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.read<BookingDetailsDrawerCubit>().openDrawer(booking.id);
            context.read<BookingDetailsBloc>().add(
              BookingDetailsEvent.fetchBookingDetails(booking.id),
            );
          },
          hoverColor: const Color(0xFF8A63FE).withOpacity(0.08),
          splashColor: const Color(0xFF8A63FE).withOpacity(0.12),
          highlightColor: const Color(0xFF8A63FE).withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Tooltip(
                    message: booking.staffName ?? 'No staff assigned',
                    decoration: BoxDecoration(
                      color: parseStaffColor(booking.staffColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    textStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                    child: Text(
                      booking.shopBookingId,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 105,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: status.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10, color: status.color, fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 95,
                  child: Text(
                    formatDateWithLabel(booking.pickupDate),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    booking.bookedItems,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 110,
                  child: Text(
                    booking.client,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 70,
                  child: Text('₹${booking.advanceAmount}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 70,
                  child: Text('₹${booking.remainingAmount}', style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 90,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: booking.paymentStatus
                          ? const Color(0xFF20D400).withOpacity(0.1)
                          : const Color(0xFFD4B800).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      booking.paymentStatus ? 'Completed' : 'Pending',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: booking.paymentStatus ? const Color(0xFF0F9D00) : const Color(0xFFB89600),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 80,
                  child: Text(
                    booking.staffName ?? 'N/A',
                    style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.chevron_right, size: 18, color: Colors.blueAccent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
