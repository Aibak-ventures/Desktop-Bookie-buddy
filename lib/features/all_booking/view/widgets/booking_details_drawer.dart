import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/models/booking_details_model/booking_details_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/cubit_booking_details_drawer/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_root.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_payment_details_section.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookingDetailsDrawer extends StatelessWidget {
  const BookingDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingDetailsDrawerCubit, BookingDetailsDrawerState>(
      builder: (context, drawerState) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          right: drawerState.isOpen ? 0 : -650,
          top: 0,
          bottom: 0,
          width: 470,
          child: Material(
            elevation: 16,
            shadowColor: Colors.black.withOpacity(0.3),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(-4, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: _buildContent(context, drawerState),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(
      BuildContext context, BookingDetailsDrawerState drawerState) {
    if (!drawerState.isOpen || drawerState.selectedBookingId == null) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => SizedBox(
            height: context.mediaQueryHeight(0.8),
            child: const Center(
              child: SpinKitFadingCircle(color: AppColors.purple),
            ),
          ),
          error: (error) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomErrorWidget(
              errorText: error,
              onRetry: () {
                if (drawerState.selectedBookingId != null) {
                  context.read<BookingDetailsBloc>().add(
                        BookingDetailsEvent.fetchBookingDetails(
                          drawerState.selectedBookingId!,
                        ),
                      );
                }
              },
            ),
          ),
          loaded: (booking) => SingleChildScrollView(
            key: ValueKey('booking_${booking.id}_${booking.actualPaidAmount}'),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main booking details
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: BookingDetailsRoot(
                    booking: booking,
                    paymentButtonKey: GlobalKey(),
                  ),
                ),

                const SizedBox(height: 24),

                // Payment details section
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: BookingDetailsPaymentDetailsSection(
                      paymentButtonKey: GlobalKey(),
                      booking: booking,
                      productTotalAmount: booking.bookedItems.fold<int>(
                        0,
                        (int previousValue, dynamic element) =>
                            previousValue + ((element.amount as int?) ?? 0),
                      ),
                      additionalChargesTotal: booking.additionalCharges
                              ?.fold<int>(
                            0,
                            (int previousValue, dynamic element) =>
                                previousValue + ((element.amount as int?) ?? 0),
                          ) ??
                          0,
                      paymentHistoryCubit:
                          context.read<BookingDetailsPaymentHistoryCubit>(),
                      isPaymentCompleted: booking.actualPaidAmount >=
                          (booking.totalAmount - (booking.discountAmount ?? 0)),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Action buttons
                // _buildActionButtons(context, booking),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context, dynamic booking) {
    return Column(
      children: [
        // Edit button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement edit functionality
              context.showSnackBar('Edit functionality coming soon');
            },
            icon: const Icon(Icons.edit, color: Colors.white),
            label: const Text(
              'Edit Booking',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Delete button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Implement delete functionality
              context.showSnackBar('Delete functionality coming soon');
            },
            icon: Icon(Icons.delete, color: Colors.red.shade600),
            label: Text(
              'Delete Booking',
              style: TextStyle(
                color: Colors.red.shade600,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: BorderSide(color: Colors.red.shade600, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
