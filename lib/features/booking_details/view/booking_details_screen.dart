import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/utils/responsive_screen_mixin.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/booking_details_widget.dart';
import 'package:bookie_buddy_web/features/booking_details/view/widgets/complete_elevated_button.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/bloc_booking_details/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view_model/cubit_booking_details_payment_history/booking_details_payment_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookingDetailsScreen extends StatelessWidget with ResponsiveScreenMixin {
  final int bookingId;
  
  const BookingDetailsScreen({
    required this.bookingId,
    super.key,
  });

  @override
  String get screenTitle => 'Booking Details';
  
  @override
  IconData get screenIcon => Icons.receipt_long;

  @override
  Widget buildContent(BuildContext context) {
    return BlocConsumer<BookingDetailsBloc, BookingDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          failed: (value) {
            context.showSnackBar(
              value,
              isError: true,
            );
          },
          success: (message, didPop, needRefresh) {
            if (didPop) {
              // context.read<BookingSelectionCubit>()
              context.pop(true);
            }
            context.showSnackBar(
              message,
            );
            if (needRefresh)
              context.read<BookingDetailsBloc>().add(
                    BookingDetailsEvent.fetchBookingDetails(bookingId),
                  );
          },
        );
      },
      buildWhen: (previous, current) {
        return current.maybeMap(
          orElse: () => true,
          failed: (value) => false,
          success: (value) => false,
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => SizedBox(
            height: context.mediaQueryHeight(0.8),
            child: const Center(
              child: SpinKitFadingCircle(
                color: AppColors.purple,
              ),
            ),
          ),
          error: (error) => CustomErrorWidget(
            errorText: error,
            onRetry: () => context.read<BookingDetailsBloc>().add(
                  BookingDetailsEvent.fetchBookingDetails(bookingId),
                ),
          ),
          loaded: (booking) {
            // Body
            //Booking details
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: 16.padding,
                    child: BlocProvider(
                      create: (context) =>
                          BookingDetailsPaymentHistoryCubit(),
                      child: BookingDetailsWidget(booking: booking),
                    ),
                  ),
                ),

                // Complete work button
                Padding(
                  padding: 16.paddingOnly(
                    left: true,
                    right: true,
                    bottom: true,
                  ),
                  child: const CompleteElevatedButton(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingDetailsBloc>().add(
            BookingDetailsEvent.fetchBookingDetails(bookingId),
          );
    });
    return buildResponsiveScreen(context);
  }
}
