import 'dart:developer';
import 'package:bookie_buddy_web/core/di/app_dependencies.dart';
import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_card.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_date_filter.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_search_field.dart';
import 'package:bookie_buddy_web/core/common/widgets/date_filter_button.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/features/booking/presentation/add_old_booking/pages/add_old_booking_screen.dart';
import 'package:bookie_buddy_web/features/booking/presentation/add_old_booking/bloc/add_old_bookings_bloc/add_old_bookings_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/booking_details/pages/booking_details_screen.dart';
import 'package:bookie_buddy_web/features/booking/presentation/completed_bookings/bloc/completed_bookings_bloc/completed_bookings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CompletedBookingsScreen extends StatelessWidget {
  CompletedBookingsScreen({super.key});

  final dateFilterNotifier = ValueNotifier(const DateFilterModel());
  final searchController = TextEditingController();
  final isSearchingNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CompletedBookingsBloc>()
          .add(const CompletedBookingsEvent.loadCompletedBookings());
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Works'),
        actions: [
          ValueListenableBuilder(
            valueListenable: isSearchingNotifier,
            builder: (context, isSearching, child) => Container(
              decoration: BoxDecoration(
                color: AppColors.purpleLightShade,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: 8.padding,
              child: Icon(
                isSearching ? Icons.close : LucideIcons.search500,
                size: 20.sp,
              ),
            ).onTap(() {
              isSearchingNotifier.value = !isSearchingNotifier.value;
            }),
          ),
          8.width,
          ValueListenableBuilder(
            valueListenable: dateFilterNotifier,
            builder: (context, value, child) {
              return DateFilterButton(
                showLabel: context.isMobile ? false : true,
                hasActiveFilter: value.hasActiveFilter,
                onTap: () => _showDateFilterBottomSheet(context),
              );
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'old_bookings') {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => AddOldBookingsBloc(
                        createOldBooking: getIt.get(),
                        addClient: getIt.get(),
                      ),
                      child: const AddOldBookingScreen(),
                    ),
                  ),
                );

                context
                    .read<CompletedBookingsBloc>()
                    .add(const CompletedBookingsEvent.loadCompletedBookings());
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'old_bookings',
                  child: CustomPopupMenuItem(
                    title: 'Add old bookings',
                    icon: Icon(Icons.add),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // 🔍 Search field
                ValueListenableBuilder(
                  valueListenable: isSearchingNotifier,
                  builder: (context, isSearching, child) => isSearching
                      ? CustomSearchField(
                          searchController: searchController,
                          padding: (16, 8).padding,
                          onChanged: (_) =>
                              _fetchCompletedWorksWithFilter(context),
                          hintText: 'Search by name or ID...',
                          suffixFunction: () {
                            searchController.clear();
                            _fetchCompletedWorksWithFilter(context);
                          },
                        )
                      : const SizedBox.shrink(),
                ),
                // 📅 Active filter
                ValueListenableBuilder(
                  valueListenable: dateFilterNotifier,
                  builder: (context, value, child) => value.hasActiveFilter
                      ? _buildActiveFilterIndicator(context)
                      : const SizedBox.shrink(),
                ),
                // 📋 Main content
                Expanded(
                  child: RefreshIndicator.adaptive(
                    onRefresh: () async =>
                        _fetchCompletedWorksWithFilter(context),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: BlocBuilder<CompletedBookingsBloc,
                          CompletedBookingsState>(
                        builder: (context, state) => state.when(
                          initial: () => _buildEmptyState(context),
                          error: (error) => CustomErrorWidget(
                            errorText: error,
                            onRetry: () =>
                                _fetchCompletedWorksWithFilter(context),
                          ),
                          loading: () =>
                              const BookingListShimmer(itemCount: 10),
                          loaded: (completedWorks, nextPageUrl, isPaginating, _,
                              __, ___) {
                            if (completedWorks.isEmpty) {
                              return _buildEmptyState(context);
                            }

                            return NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (scrollInfo.metrics.pixels >=
                                        scrollInfo.metrics.maxScrollExtent -
                                            200 &&
                                    nextPageUrl != null &&
                                    !isPaginating) {
                                  context.read<CompletedBookingsBloc>().add(
                                        const CompletedBookingsEvent
                                            .loadNextPageCompletedBookings(),
                                      );
                                }
                                return false;
                              },
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 1000),
                                  child: ListView.builder(
                                    key: const PageStorageKey(
                                        'completed-work-list'),
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: completedWorks.length +
                                        (isPaginating ? 1 : 0),
                                    itemBuilder: (context, index) {
                                      if (index < completedWorks.length) {
                                        final booking = completedWorks[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: BookingCard(
                                            booking: booking,
                                            onTap: () async {
                                              final bookingCubit = context
                                                  .read<BookingSelectionCubit>()
                                                ..selectBooking(booking);
                                              final result =
                                                  await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingDetailsScreen(
                                                    bookingId: booking.id!,
                                                  ),
                                                ),
                                              );
                                              if (bookingCubit
                                                  .state.isModified) {
                                                final updated = bookingCubit
                                                    .state.selectedBooking;
                                                context
                                                    .read<
                                                        CompletedBookingsBloc>()
                                                    .add(CompletedBookingsEvent
                                                        .updateBooking(
                                                      updated,
                                                      shouldRefresh:
                                                          bookingCubit.state
                                                              .shouldRefresh,
                                                      isDeleted: result == true,
                                                    ));
                                                log('update booking called');
                                                bookingCubit.reset();
                                              }
                                            },
                                          ),
                                        );
                                      } else {
                                        return const BookingCardShimmer();
                                      }
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFilterIndicator(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.purple),
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_list, size: 16, color: AppColors.purple),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _getFilterDisplayText(),
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.purple,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _clearDateFilter(context),
            child: Container(
              padding: 2.padding,
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 14, color: AppColors.purple),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: context.screenHeight * 0.3),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt_outlined,
                size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              dateFilterNotifier.value.hasActiveFilter
                  ? 'No completed works found for selected dates'
                  : 'No Completed Works',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            if (dateFilterNotifier.value.hasActiveFilter) ...[
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _clearDateFilter(context),
                child: const Text('Clear filter to see all completed works'),
              ),
            ],
          ],
        ),
      ],
    );
  }

  void _showDateFilterBottomSheet(BuildContext context) {
    showDateFilterBottomSheet(
      context: context,
      initialStartDate: dateFilterNotifier.value.startDate,
      initialEndDate: dateFilterNotifier.value.endDate,
      onDateFilterChanged: (startDate, endDate) {
        dateFilterNotifier.value = dateFilterNotifier.value.copyWith(
          startDate: startDate,
          endDate: endDate,
        );
        _fetchCompletedWorksWithFilter(context);
      },
    );
  }

  void _fetchCompletedWorksWithFilter(BuildContext context) {
    context.read<CompletedBookingsBloc>().add(
          CompletedBookingsEvent.loadCompletedBookings(
            startDate:
                dateFilterNotifier.value.startDate?.format(reverse: true),
            endDate: dateFilterNotifier.value.endDate?.format(reverse: true),
            searchQuery: searchController.text.trim().isEmpty
                ? null
                : searchController.text.trim(),
          ),
        );
  }

  void _clearDateFilter(BuildContext context) {
    dateFilterNotifier.value = const DateFilterModel();
    _fetchCompletedWorksWithFilter(context);
  }

  String _getFilterDisplayText() {
    final startDate = dateFilterNotifier.value.startDate;
    final endDate = dateFilterNotifier.value.endDate;
    if (startDate != null && endDate != null) {
      if (startDate.isAtSameMomentAs(endDate)) {
        return 'Filtered by: ${startDate.format()}';
      } else {
        return 'Filtered by: ${startDate.format()} - ${endDate.format()}';
      }
    } else if (startDate != null) {
      return 'From: ${startDate.format()}';
    } else if (endDate != null) {
      return 'Until: ${endDate.format()}';
    }
    return 'Date filter active';
  }
}

class CustomPopupMenuItem extends StatelessWidget {
  final Icon? icon;
  final String title;
  const CustomPopupMenuItem({super.key, this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        if (icon != null) icon!,
        Text(title),
      ],
    );
  }
}
