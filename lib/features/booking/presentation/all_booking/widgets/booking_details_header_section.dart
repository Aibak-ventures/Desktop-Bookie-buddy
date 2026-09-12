import 'package:bookie_buddy_shared/core/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/extensions/delivery_status_extensions.dart';
import 'package:bookie_buddy_web/core/constants/enums/secret_password_locations_enum.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/extensions/booking_details_entity_web_extensions.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/dialogs/cancel_booking_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/dialogs/partial_return_dialogs.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Header section for [BookingDetailsDrawer] — shows booking ID, staff, and delivery status.
class BookingDetailsHeaderSection extends StatelessWidget {
  final BookingDetailsEntity booking;

  const BookingDetailsHeaderSection({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final status = booking.deliveryStatus;
    final isCompleted = booking.bookingStatus == BookingStatus.completed;
    final isCancelled = booking.deliveryStatus == DeliveryStatus.cancelled;
    final mainServiceType = booking.mainServiceType;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT — Booking ID
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Booking Id',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '#${booking.invoiceId}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // CENTER — Staff
        if (booking.staffName != null)
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Staff',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking.staffName!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.purple,
                  ),
                ),
              ],
            ),
          ),

        // RIGHT — Delivery Status
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Delivery status',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              if (isCompleted ||
                  isCancelled ||
                  status == DeliveryStatus.returned)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: status.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          status.getServiceSpecificName(mainServiceType),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: status.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              else
                PopupMenuButton<DeliveryStatus>(
                  offset: const Offset(0, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onSelected: (newStatus) async {
                    if (newStatus == DeliveryStatus.cancelled) {
                      performSecureActionDialog(
                        context,
                        SecretPasswordLocations.bookingDelete,
                        onSuccess: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) => CancelBookingDialog(
                              maxRefundAmount: booking.paidAmount,
                              onCancel: () => Navigator.of(dialogContext).pop(),
                              onConfirm: (refundAmount, accountId) {
                                Navigator.of(dialogContext).pop();
                                context.read<BookingDetailsBloc>().add(
                                  BookingDetailsEvent.cancelBooking(
                                    bookingId: booking.id,
                                    refundAmount: refundAmount,
                                    accountId: accountId,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                      return;
                    }

                    if (newStatus == DeliveryStatus.returned) {
                      _onStatusChangeToReturned(context);
                      return;
                    }

                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Change Delivery Status'),
                        content: Text(
                          'Are you sure you want to change delivery status to "${newStatus.getServiceSpecificName(mainServiceType)}"?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true && context.mounted) {
                      context.read<BookingDetailsBloc>().add(
                        BookingDetailsEvent.updateDeliveryStatus(
                          bookingId: booking.id,
                          deliveryStatus: newStatus,
                        ),
                      );
                      context.read<AllBookingBloc>().add(
                        AllBookingEvent.updateDeliveryStatus(
                          bookingId: booking.id,
                          deliveryStatus: newStatus,
                        ),
                      );
                    }
                  },
                  itemBuilder: (context) =>
                      DeliveryStatus.getServiceSpecificStatus(
                        mainServiceType,
                      ).map((s) {
                    return PopupMenuItem(
                      value: s,
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: s.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            s.getServiceSpecificName(mainServiceType),
                            style: TextStyle(
                              fontSize: 13,
                              color: s.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: status.color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            status.name,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: status.color,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 16,
                          color: status.color,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Return flow: confirm all items came back, or pick the ones that did and
  /// re-confirm the expected return date for the rest.
  void _onStatusChangeToReturned(BuildContext context) {
    final bloc = context.read<BookingDetailsBloc>();
    // only the items that haven't come back yet can be returned
    final notReturnedProducts = booking.bookedItems
        .where((e) => e.deliveryStatus.isNotReturned)
        .toList();
    final mainServiceType = booking.mainServiceType;

    showReturnConfirmationDialog(
      context,
      mainServiceType: mainServiceType,
      // partial return only makes sense with more than one item still out
      isPartialReturnButtonVisible: notReturnedProducts.length > 1,
      onAllReturned: () {
        bloc.add(
          BookingDetailsEvent.updatePartialReturn(
            bookingId: booking.id,
            returnedProductIds: notReturnedProducts.map((e) => e.id).toList(),
            notReturnedProductIds: const [],
            newReturnDate: null,
          ),
        );
      },
      onPartialReturn: () {
        showPartialReturnProductSelector(
          context,
          mainServiceType: mainServiceType,
          products: notReturnedProducts,
          onReturnConfirmed: (returnedProductIds, notReturnedProductIds) {
            showReturnDateUpdateDialog(
              context,
              mainServiceType: mainServiceType,
              currentReturnDate: booking.returnDate,
              onConfirmed: (selectedDate) {
                bloc.add(
                  BookingDetailsEvent.updatePartialReturn(
                    bookingId: booking.id,
                    returnedProductIds: returnedProductIds,
                    notReturnedProductIds: notReturnedProductIds,
                    // only send a date when it actually moved
                    newReturnDate:
                        selectedDate.isSameDay(
                          booking.returnDate.parseToDateTime(),
                        )
                        ? null
                        : selectedDate.format(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
