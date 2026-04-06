import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/features/booking/domain/entities/booking_details_entity/booking_details_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/booking_details_drawer_cubit/booking_details_drawer_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_action_bar.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_customer_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_dates_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_documents_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_header_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_items_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_payment_section.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_bloc/booking_details_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/bloc/booking_details_payment_history_cubit/booking_details_payment_history_cubit.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/features/auth/presentation/bloc/user_cubit/user_cubit.dart';
import 'package:bookie_buddy_web/core/common/entities/user_entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BookingDetailsDrawer extends StatelessWidget {
  const BookingDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserEntity?>(
      listenWhen: (previous, current) {
        if (previous == null || current == null) return false;
        return previous.shopDetails.id != current.shopDetails.id;
      },
      listener: (context, user) {
        context.read<BookingDetailsDrawerCubit>().closeDrawer();
      },
      child: BlocBuilder<BookingDetailsDrawerCubit, BookingDetailsDrawerState>(
        builder: (context, drawerState) {
          return AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            right: drawerState.isOpen ? 0 : -650,
            top: 0,
            bottom: 0,
            width: 470,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
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
                      // Close button header
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_right, size: 28),
                              onPressed: () {
                                context
                                    .read<BookingDetailsDrawerCubit>()
                                    .closeDrawer();
                              },
                              tooltip: 'Close',
                              color: Colors.grey.shade600,
                              hoverColor: Colors.grey.shade100,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _buildContent(context, drawerState),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context, BookingDetailsDrawerState drawerState) {
    if (!drawerState.isOpen || drawerState.selectedBookingId == null) {
      return const SizedBox.shrink();
    }

    return BlocListener<BookingDetailsBloc, BookingDetailsState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: (booking) {
            final paymentHistoryCubit =
                context.read<BookingDetailsPaymentHistoryCubit>();
            if (paymentHistoryCubit.isExpanded) {
              paymentHistoryCubit.collapsePaymentHistory();
            }
          },
          success: (message, didPop, needRefresh) {
            context.showSnackBar(message);

            if (needRefresh && drawerState.selectedBookingId != null) {
              context.read<BookingDetailsBloc>().add(
                    BookingDetailsEvent.fetchBookingDetails(
                      drawerState.selectedBookingId!,
                    ),
                  );

              final allBookingBloc = context.read<AllBookingBloc>();
              allBookingBloc.state.mapOrNull(
                loaded: (s) => allBookingBloc.add(AllBookingEvent.loadBookings(
                  status: s.status,
                  startDate: s.startDate,
                  endDate: s.endDate,
                  searchQuery: s.searchQuery,
                )),
              );
            }
          },
          failed: (error) {
            context.showSnackBar(error, isError: true);
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
            loaded: (BookingDetailsEntity booking) => Column(
              key: ValueKey(
                  'booking_${booking.id}_${booking.actualPaidAmount}'),
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
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
                        BookingDetailsDocumentsSection(booking: booking),
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
