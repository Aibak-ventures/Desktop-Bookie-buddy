import 'package:bookie_buddy_web/core/enums/payment_method_enums.dart';
import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/booking_details_app_bar.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/buttons/complete_elevated_button.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/buttons/custom_swipe_button.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/sections/booking_details_root.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
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
  late final CustomSwipeButtonController swipeButtonController;
  final GlobalKey _paymentButtonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<BookingDetailsPaymentHistoryCubit>().collapsePaymentHistory();
    swipeButtonController = CustomSwipeButtonController();
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
    swipeButtonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    // Custom Appbar
    appBar: BookingDetailsAppBar(),

    body: BlocConsumer<BookingDetailsBloc, BookingDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          failed: (value) {
            swipeButtonController.reset();
            context.showSnackBar(value, isError: true);
          },
          loaded: (booking) {
            final bookingCubit = context.read<BookingSelectionCubit>();

            final updatedBooking = bookingCubit.state.selectedBooking?.copyWith(
              deliveryStatus: state.booking!.deliveryStatus,
              bookedItems: state.booking!.bookedItems
                  .map((e) => e.name)
                  .toList(),
              paymentStatus: state.booking!.paymentStatus == true
                  ? PaymentStatus.completed
                  : PaymentStatus.pending,
            );
            if (updatedBooking != null) {
              bookingCubit.selectBooking(updatedBooking);
            }
          },
          success: (message, didPop, needRefresh) {
            swipeButtonController.reset();
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
              context.pop(true);
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
        // Body
        //Booking details
        loaded: (booking) => Column(
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

            // Complete work button
            Padding(
              padding: 16.paddingOnly(left: true, right: true, bottom: true),
              child: CompleteElevatedButton(
                isLoading: state.isLoading,
                isSuccess: state.isSuccess,
                isFailure: state.isFailure,
                swipeButtonController: swipeButtonController,
              ),
            ),
          ],
        ),
      ),
    ),
    resizeToAvoidBottomInset: false,
  );
}
