import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/desktop_booking_item_entity/desktop_booking_item_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Dropdown for changing the delivery status of a booking with optimistic UI update.
class AllBookingsDeliveryStatusDropdown extends StatefulWidget {
  final DesktopBookingItemEntity booking;

  const AllBookingsDeliveryStatusDropdown({super.key, required this.booking});

  @override
  State<AllBookingsDeliveryStatusDropdown> createState() =>
      _AllBookingsDeliveryStatusDropdownState();
}

class _AllBookingsDeliveryStatusDropdownState
    extends State<AllBookingsDeliveryStatusDropdown> {
  DeliveryStatus? _optimisticStatus;

  @override
  void didUpdateWidget(AllBookingsDeliveryStatusDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset optimistic status when booking data actually updates from bloc
    if (oldWidget.booking.deliveryStatus != widget.booking.deliveryStatus) {
      _optimisticStatus = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStatus =
        _optimisticStatus ??
        widget.booking.deliveryStatus ??
        DeliveryStatus.booked;

    return PopupMenuButton<DeliveryStatus>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (DeliveryStatus newStatus) {
        setState(() => _optimisticStatus = newStatus);
        context.read<AllBookingBloc>().add(
          AllBookingEvent.updateDeliveryStatus(
            bookingId: widget.booking.id,
            deliveryStatus: newStatus,
          ),
        );
      },
      itemBuilder: (context) => DeliveryStatus.values.map((s) {
        return PopupMenuItem<DeliveryStatus>(
          value: s,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(color: s.color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 8),
              Text(
                s.name,
                style: TextStyle(fontSize: 13, color: s.color, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      }).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        decoration: BoxDecoration(
          color: effectiveStatus.color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: effectiveStatus.color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                effectiveStatus.name,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: effectiveStatus.color, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 2),
            Icon(Icons.keyboard_arrow_down, size: 12, color: effectiveStatus.color),
          ],
        ),
      ),
    );
  }
}
