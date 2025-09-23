import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showDeleteBookingDialog(
  BuildContext context,
  int bookingId,
) async {
  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this booking?'),
      actions: [
        // Cancel button
        TextButton(
          onPressed: context.pop, // Closes the dialog
          child: const Text('Cancel'),
        ),
        // Confirm Delete button
        ElevatedButton(
          onPressed: () {
            context.read<BookingDetailsBloc>().add(
                  BookingDetailsEvent.deleteBooking(bookingId),
                );

            context
                .read<BookingSelectionCubit>()
                .markModified(shouldRefresh: true);
            context.pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
