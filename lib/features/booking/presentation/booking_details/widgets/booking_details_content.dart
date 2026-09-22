import 'dart:developer';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/extensions/booking_details_entity_web_extensions.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/booking_details_action_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_customer_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_dates_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_documents_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_header_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_items_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_other_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_payment_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/sections/booking_details_security_refund_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_payment_history_cubit/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_security_refund_history_cubit/booking_details_security_refund_history_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/common/models/unavailable_products_response_model.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/widgets/dialogs/unavailable_products_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// The actual booking-details view: every section (header, dates, items,
/// customer, payment, security/refund, other, documents) plus the bottom
/// action bar, driven by [BookingDetailsBloc]. Content-wise this is
/// screen-equivalent — it just happens to always be shown inside
/// [BookingDetailsDrawer]'s slide-in chrome rather than a full-screen route.
class BookingDetailsContent extends StatelessWidget {
  final int selectedBookingId;

  const BookingDetailsContent({super.key, required this.selectedBookingId});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingDetailsBloc, BookingDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: (booking) {
            final paymentHistoryCubit = context
                .read<BookingDetailsPaymentHistoryCubit>();
            if (paymentHistoryCubit.isExpanded) {
              paymentHistoryCubit.collapsePaymentHistory();
            }
            final securityHistoryCubit = context
                .read<BookingDetailsSecurityRefundHistoryCubit>();
            if (securityHistoryCubit.isExpanded) {
              securityHistoryCubit.collapseHistory();
            }
          },
          success: (message, didPop, needRefresh) {
            context.showSnackBar(message);

            if (needRefresh) {
              context.read<BookingDetailsBloc>().add(
                BookingDetailsEvent.fetchBookingDetails(selectedBookingId),
              );

              final allBookingBloc = context.read<AllBookingBloc>();
              allBookingBloc.state.mapOrNull(
                loaded: (s) => allBookingBloc.add(
                  AllBookingEvent.loadBookings(
                    status: s.status,
                    startDate: s.startDate,
                    endDate: s.endDate,
                    searchQuery: s.searchQuery,
                    purchaseMode: s.purchaseMode,
                  ),
                ),
              );
            }
          },
          failed: (message, error, products) {
            // A structured payload means the API named the conflicting
            // variant — show which products blocked the action instead of a
            // bare snackbar.
            if (error is Map<String, dynamic>) {
              try {
                final conflict = UnavailableProductsResponseModel.fromJson(
                  error,
                ).toEntity();

                // Without a window, or without an item the conflict actually
                // points at, there is nothing for the dialog to show — say it
                // in a snackbar instead of failing silently.
                final unavailableItems =
                    UnavailableProductsDialog.matchingItems(
                      conflict,
                      products ?? const [],
                    );

                if (conflict.dateFrom != null &&
                    conflict.dateTo != null &&
                    unavailableItems.isNotEmpty) {
                  UnavailableProductsDialog.show(
                    context: context,
                    conflict: conflict,
                    unavailableItems: unavailableItems,
                  );
                  return;
                }
                context.showSnackBar(
                  conflict.message ?? message,
                  isError: true,
                );
                return;
              } catch (e, stack) {
                log('Failed to parse stock conflict: $e', stackTrace: stack);
              }
            }
            context.showSnackBar(message, isError: true);
          },
        );
      },
      child: BlocBuilder<BookingDetailsBloc, BookingDetailsState>(
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
                  context.read<BookingDetailsBloc>().add(
                    BookingDetailsEvent.fetchBookingDetails(selectedBookingId),
                  );
                },
              ),
            ),
            loaded: (BookingDetailsEntity booking) => Column(
              key: ValueKey(
                'booking_${booking.id}_${booking.actualPaidAmount}',
              ),
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BookingDetailsHeaderSection(booking: booking),
                        const SizedBox(height: 20),
                        BookingDetailsDatesSection(booking: booking),
                        const SizedBox(height: 20),
                        BookingDetailsItemsSection(booking: booking),
                        const SizedBox(height: 20),
                        BookingDetailsCustomerSection(booking: booking),
                        const SizedBox(height: 20),
                        BookingDetailsPaymentSection(booking: booking),
                        const SizedBox(height: 20),
                        BookingDetailsSecurityRefundSection(booking: booking),
                        const SizedBox(height: 20),
                        BookingDetailsOtherSection(booking: booking),
                        if (booking.documents.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          BookingDetailsDocumentsSection(booking: booking),
                        ],
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
                BookingDetailsActionBar(booking: booking),
              ],
            ),
          );
        },
      ),
    );
  }
}
