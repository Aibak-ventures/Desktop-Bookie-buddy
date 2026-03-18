import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/core/constants/enums/enums.dart';
import 'package:bookie_buddy_web/core/constants/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/features/staff/domain/models/staff_model/staff_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/perform_secure_action_dialog.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:bookie_buddy_web/features/staff/presentation/bloc/staff_search_cubit/staff_search_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/edit_booking/pages/edit_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/booking_details_app_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/dialogs/cancel_booking_dialog.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/update_booking_cubit/update_booking_cubit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:bookie_buddy_web/core/constants/enums/booking_status_enums.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_root.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_payment_details_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_payment_history_cubit/booking_details_payment_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookingDetailsScreen extends StatefulWidget {
  final int bookingId;
  const BookingDetailsScreen({required this.bookingId, super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final GlobalKey _paymentButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<BookingDetailsPaymentHistoryCubit>().collapsePaymentHistory();

    // Defer dispatch to ensure context is ready
    Future.microtask(() {
      if (!mounted) return;
      context.read<BookingDetailsBloc>().add(
            BookingDetailsEvent.fetchBookingDetails(widget.bookingId),
          );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = context.screenWidth > 768;

    return Scaffold(
      backgroundColor: isWeb ? const Color(0xFFF5F7FA) : null,
      // Custom Appbar
      appBar: BookingDetailsAppBar(),

      body: BlocConsumer<BookingDetailsBloc, BookingDetailsState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            failed: (value) {
              // swipeButtonController.reset();
              context.showSnackBar(value, isError: true);
            },
            loaded: (booking) {
              final bookingCubit = context.read<BookingSelectionCubit>();

              final updatedBooking =
                  bookingCubit.state.selectedBooking?.copyWith(
                deliveryStatus: state.booking!.deliveryStatus,
                bookedItems:
                    state.booking!.bookedItems.map((e) => e.name).toList(),
                paymentStatus: state.booking!.paymentStatus == true
                    ? PaymentStatus.completed
                    : PaymentStatus.pending,
              );
              if (updatedBooking != null) {
                bookingCubit.selectBooking(updatedBooking);
              }
            },
            success: (message, didPop, needRefresh) {
              // swipeButtonController.reset();
              final bookingCubit = context.read<BookingSelectionCubit>()
                ..markModified();

              final updatedBooking = state.booking != null
                  ? bookingCubit.state.selectedBooking?.copyWith(
                      deliveryStatus: state.booking!.deliveryStatus,
                      bookedItems: state.booking!.bookedItems
                          .map((e) => e.name)
                          .toList(),
                      paymentStatus: state.booking!.paymentStatus == true
                          ? PaymentStatus.completed
                          : PaymentStatus.pending,
                    )
                  : null;
              if (updatedBooking != null) {
                bookingCubit.selectBooking(updatedBooking);
              }
              if (didPop) {
                bookingCubit.markModified(shouldRefresh: true);
                NavigatorX(context).pop();
              }
              context.showSnackBar(message);
              if (needRefresh)
                context.read<BookingDetailsBloc>().add(
                      BookingDetailsEvent.fetchBookingDetails(widget.bookingId),
                    );
            },
          );
        },
        buildWhen: (previous, current) => current.maybeMap(
          orElse: () => true,
          failed: (value) => false,
          success: (value) => false,
        ),
        builder: (context, state) => state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => SizedBox(
            height: context.mediaQueryHeight(0.8),
            child: const Center(
              child: SpinKitFadingCircle(color: AppColors.purple),
            ),
          ),
          error: (error) => CustomErrorWidget(
            errorText: error,
            onRetry: () => context.read<BookingDetailsBloc>().add(
                  BookingDetailsEvent.fetchBookingDetails(widget.bookingId),
                ),
          ),
          // Body - Web responsive design
          loaded: (booking) => isWeb
              ? _buildWebLayout(context, state, booking)
              : _buildMobileLayout(context, state, booking),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildWebLayout(
      BuildContext context, BookingDetailsState state, dynamic booking) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1600,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main content - Left side (70%)
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: 2,
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: BookingDetailsRoot(
                      booking: booking,
                      paymentButtonKey: _paymentButtonKey,
                    ),
                  ),
                ),

                const SizedBox(width: 32),

                // Action panel - Right side (30%)
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // Quick actions card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Quick Actions',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Primary action buttons for web
                            _buildWebActionButtons(context, state, booking),

                            const SizedBox(height: 20),

                            // Secondary action buttons
                            _buildSecondaryActionButtons(context, booking),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Payment Details Section (Complete)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: BookingDetailsPaymentDetailsSection(
                          paymentButtonKey: _paymentButtonKey,
                          booking: booking,
                          productTotalAmount: booking.bookedItems.fold<int>(
                            0,
                            (int previousValue, dynamic element) =>
                                previousValue + ((element.amount as int?) ?? 0),
                          ),
                          additionalChargesTotal:
                              booking.additionalCharges?.fold<int>(
                                    0,
                                    (int previousValue, dynamic element) =>
                                        previousValue +
                                        ((element.amount as int?) ?? 0),
                                  ) ??
                                  0,
                          paymentHistoryCubit:
                              context.read<BookingDetailsPaymentHistoryCubit>(),
                          isPaymentCompleted: booking.actualPaidAmount >=
                              (booking.totalAmount -
                                  (booking.discountAmount ?? 0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
      BuildContext context, BookingDetailsState state, dynamic booking) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: 16.padding,
            child: BookingDetailsRoot(
              booking: booking,
              paymentButtonKey: _paymentButtonKey,
            ),
          ),
        ),

        // Complete work button for mobile
        Padding(
          padding: 16.paddingOnly(left: true, right: true, bottom: true),
          child: _buildMobileActionButton(context, state, booking),
        ),
      ],
    );
  }

  Widget _buildMobileActionButton(
      BuildContext context, BookingDetailsState state, dynamic booking) {
    final isBookingCompleted = booking.bookingStatus == BookingStatus.completed;

    if (isBookingCompleted) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade700),
            const SizedBox(width: 8),
            Text(
              'Booking Completed',
              style: TextStyle(
                color: Colors.green.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: state.isLoading
          ? null
          : () => _handleCompleteBooking(
              context,
              booking,
              (booking.totalAmount ?? 0) -
                  (booking.actualPaidAmount) -
                  (booking.discountAmount ?? 0)),
      icon: state.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            )
          : const Icon(Icons.check_circle, color: Colors.white),
      label: Text(
        state.isLoading ? 'Processing...' : 'Complete Booking',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
      ),
    );
  }

  Widget _buildWebActionButtons(
      BuildContext context, BookingDetailsState state, dynamic booking) {
    final isBookingCompleted = booking.bookingStatus == BookingStatus.completed;
    final balanceAmount = (booking.totalAmount ?? 0) -
        (booking.actualPaidAmount) -
        (booking.discountAmount ?? 0);

    return Column(
      children: [
        // ✅ Disable "Complete Booking" if already completed
        ElevatedButton.icon(
          onPressed: isBookingCompleted || state.isLoading
              ? null
              : () => _handleCompleteBooking(context, booking, balanceAmount),
          icon: state.isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.check_circle, color: Colors.white),
          label: Text(
            isBookingCompleted
                ? 'Booking Completed'
                : (state.isLoading ? 'Processing...' : 'Complete Booking'),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isBookingCompleted
                ? Colors.grey.shade400
                : Colors.green.shade600,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSecondaryActionButtons(BuildContext context, dynamic booking) {
    final isBookingCompleted = booking.bookingStatus == BookingStatus.completed;
    final isBookingCancelled = booking.bookingStatus == BookingStatus.cancelled;

    return Column(
      children: [
        // ✅ Disable "Edit Booking" if completed or cancelled
        ElevatedButton.icon(
          onPressed: (isBookingCompleted || isBookingCancelled)
              ? null
              : () => _handleEditBooking(context, booking),
          icon: const Icon(Icons.edit, color: Colors.white),
          label: Text(
            (isBookingCompleted || isBookingCancelled)
                ? 'Edit Disabled'
                : 'Edit Booking',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: (isBookingCompleted || isBookingCancelled)
                ? Colors.grey.shade400
                : Colors.blue.shade600,
            minimumSize: const Size(double.infinity, 48),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
          ),
        ),

        const SizedBox(height: 12),

        // Cancel Booking button (only if not completed or cancelled)
        if (!isBookingCompleted && !isBookingCancelled) ...[
          ElevatedButton.icon(
            onPressed: () => _handleCancelBooking(context, booking),
            icon: const Icon(Icons.cancel, color: Colors.white),
            label: const Text(
              'Cancel Booking',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade600,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 2,
            ),
          ),
          const SizedBox(height: 12),
        ],

        // ✅ Keep Delete Booking active (if you want to always allow deleting)
        ElevatedButton.icon(
          onPressed: () => _handleDeleteBooking(context, booking),
          icon: const Icon(Icons.delete, color: Colors.white),
          label: const Text(
            'Delete Booking',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600,
            minimumSize: const Size(double.infinity, 48),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 2,
          ),
        ),
      ],
    );
  }

  void _handleCompleteBooking(
      BuildContext context, dynamic booking, int balanceAmount) async {
    if (balanceAmount > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please clear the balance amount of ₹$balanceAmount before completing the booking.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Complete Booking',
        ),
        content: const Text(
            'Are you sure you want to mark this booking as completed?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Complete',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      context.read<BookingDetailsBloc>().add(
            BookingDetailsEvent.updateBookingStatus(
              bookingId: booking.id,
              bookingStatus: BookingStatus.completed,
            ),
          );
    }
  }

  void _handleCancelBooking(BuildContext context, dynamic booking) {
    showDialog(
      context: context,
      builder: (context) => CancelBookingDialog(
        maxRefundAmount: booking.actualPaidAmount,
        onCancel: () => Navigator.of(context).pop(),
        onConfirm: (refundAmount, paymentMethod) {
          context.read<BookingDetailsBloc>().add(
                BookingDetailsEvent.cancelBooking(
                  bookingId: booking.id,
                  refundAmount: refundAmount,
                  paymentMethod: paymentMethod,
                ),
              );
        },
      ),
    );
  }

  void _handleDeleteBooking(BuildContext context, dynamic booking) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.bookingDelete,
      onSuccess: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Booking'),
            content: const Text(
                'Are you sure you want to delete this booking? This action cannot be undone.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Add delete booking logic here
                  context.read<BookingDetailsBloc>().add(
                        BookingDetailsEvent.deleteBooking(booking.id),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking deleted successfully!'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleEditBooking(BuildContext context, dynamic booking) {
    performSecureActionDialog(
      context,
      SecretPasswordLocations.bookingEdit,
      onSuccess: () {
        try {
          StaffModel? existingStaff;
          if (booking.staffId != null) {
            existingStaff = StaffModel(
              id: booking.staffId!,
              name: booking.staffName ?? 'Staff Name',
              phoneNumber: '',
            );
          }
          context
            ..read<StaffSearchCubit>().clearSelectedStaff()
            ..read<StaffSearchCubit>().getAllStaffs(
              booking.staffId,
              existingStaff,
            )
            ..read<ClientCubit>().clearSelected();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => UpdateBookingCubit(
                  updateBooking: getIt.get(),
                  addClient: getIt.get(),
                ),
                child: EditBookingScreen(booking: booking),
              ),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Edit booking feature is not available at the moment.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      },
    );
  }

  void _handleShareDetails(BuildContext context, dynamic booking) async {
    try {
      final shareText = '''
📋 *Booking Details*

🆔 Booking ID: #${booking.invoiceId}
👤 Client: ${booking.client?.clientName ?? 'N/A'}
📞 Phone: ${booking.client?.clientPhone1 ?? 'N/A'}
📅 Pickup: ${booking.pickupDate ?? 'N/A'}
📅 Return: ${booking.returnDate ?? 'N/A'}
💰 Total Amount: ₹${booking.totalAmount}
💳 Paid Amount: ₹${booking.actualPaidAmount}
📊 Status: ${booking.deliveryStatus.name.toUpperCase()}

🛍️ Items:
${booking.bookedItems.map((item) => '• ${item.productName} (₹${item.amount})').join('\n')}

---
Shared via Bookie Buddy
      ''';

      await Share.share(
        shareText,
        subject: 'Booking Details - #${booking.invoiceId}',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to share booking details. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // void _handlePrintBooking(BuildContext context, dynamic booking) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Print/Download feature will be available soon.'),
  //       backgroundColor: Colors.blue,
  //     ),
  //   );
  // }
}
