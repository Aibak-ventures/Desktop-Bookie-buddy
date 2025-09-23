import 'dart:developer';

import 'package:bookie_buddy_web/core/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_card.dart';
import 'package:bookie_buddy_web/core/ui/widgets/booking_date_filter.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_search_field.dart';
import 'package:bookie_buddy_web/core/ui/widgets/date_filter_button.dart';
import 'package:bookie_buddy_web/core/utils/responsive_helper.dart';
import 'package:bookie_buddy_web/core/view_model/cubit_booking_selection/booking_selection_cubit.dart';
import 'package:bookie_buddy_web/core/widgets/responsive_widget.dart';
import 'package:bookie_buddy_web/features/all_booking/view_model/bloc_all_booking/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/booking_details/view/booking_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// This will show upcoming bookings that not completed,
///
/// unlike dashboard where only show upcoming bookings after today
class AllBookingScreen extends StatelessWidget {
  AllBookingScreen({super.key});

  // Date filter state
  final dateFilterNotifier = ValueNotifier(const DateFilterModel());
  final searchController = TextEditingController();
  final isSearchingNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AllBookingBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(const AllBookingEvent.loadBookings());
    });
    return Scaffold(
      backgroundColor: ResponsiveHelper.isDesktop(context) 
          ? const Color(0xFFF8F9FA) 
          : null,
      appBar: ResponsiveHelper.isMobile(context)
          ? AppBar(
              title: const Text('Bookings'),
              actions: _buildAppBarActions(context),
            )
          : null,
      body: ResponsiveWidget(
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
        largeDesktop: _buildDesktopLayout(context),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
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
        ).onTap(
          () {
            isSearchingNotifier.value = !isSearchingNotifier.value;
          },
        ),
      ),
      8.width,
      // Date Filter Button
      ValueListenableBuilder(
        valueListenable: dateFilterNotifier,
        builder: (context, value, child) {
          return DateFilterButton(
            hasActiveFilter: value.hasActiveFilter,
            onTap: () => _showDateFilterBottomSheet(context),
          );
        },
      ),
      10.width,
    ];
  }

  Widget _buildMobileLayout(BuildContext context) {
    return _buildBookingContent(context);
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 40,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.collections_bookmark_rounded,
                    color: AppColors.purple,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Bookings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      'Manage your bookings',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ..._buildAppBarActions(context),
              ],
            ),
          ),
          
          // Content Section
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: _buildBookingContent(context),
              ),
            ),
          ),
          
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F9FA),
            Color(0xFFE9ECEF),
          ],
        ),
      ),
      child: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 60,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.grey.shade700,
                    fixedSize: const Size(48, 48),
                  ),
                ),
                const SizedBox(width: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.collections_bookmark_rounded,
                    color: AppColors.purple,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Bookings',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Text(
                      'Manage your bookings',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ..._buildAppBarActions(context),
              ],
            ),
          ),
          
          // Content Section
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                margin: EdgeInsets.symmetric(horizontal: 80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: _buildBookingContent(context),
              ),
            ),
          ),
          
          SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildBookingContent(BuildContext context) {
    final bloc = context.read<AllBookingBloc>();
    
    return Column(
      children: [
        // Active Search filed
        ValueListenableBuilder(
          valueListenable: isSearchingNotifier,
          builder: (context, isSearching, child) => isSearching
              ? CustomSearchField(
                  searchController: searchController,
                  padding: (16, 8).padding,
                  onChanged: (query) {
                    _fetchBookingsWithFilter(context);
                  },
                  hintText: 'Search by name or ID...',
                  suffixFunction: () {
                    searchController.clear();
                    _fetchBookingsWithFilter(context);
                  },
                )
              : const SizedBox.shrink(),
        ),
        // Active Filter Indicator
        ValueListenableBuilder(
          valueListenable: dateFilterNotifier,
          builder: (context, value, child) => value.hasActiveFilter
              ? _buildActiveFilterIndicator(context)
              : const SizedBox.shrink(),
        ),

        // Main Content
        Expanded(
          child: RefreshIndicator.adaptive(
            onRefresh: () async {
              _fetchBookingsWithFilter(context);
            },
            child: Padding(
              padding: 16.padding,
              child: BlocBuilder<AllBookingBloc, AllBookingState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const Center(child: Text('No bookings')),
                    error: (error) {
                      return CustomErrorWidget(
                        errorText: error,
                        onRetry: () => _fetchBookingsWithFilter(context),
                      );
                    },
                    loading: () => const BookingListShimmer(
                      itemCount: 10,
                    ),
                    loaded: (bookings, nextPageUrl, isPaginating) {
                      if (bookings.isEmpty) {
                        return _buildEmptyState(context);
                      }
                      return NotificationListener<ScrollNotification>(
                        onNotification: (scrollInfo) {
                          if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent - 200 &&
                              nextPageUrl != null &&
                              !isPaginating) {
                            bloc.add(
                              AllBookingEvent.loadNextPageBookings(
                                startDate: dateFilterNotifier.value.startDate
                                    ?.format(reverse: true),
                                endDate: dateFilterNotifier.value.endDate
                                    ?.format(reverse: true),
                                searchQuery:
                                    searchController.text.trim().isEmpty
                                        ? null
                                        : searchController.text.trim(),
                              ),
                            );
                          }

                          return false;
                        },
                        child: ListView.builder(
                          key: const PageStorageKey('all-booking-list'),
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: bookings.length + (isPaginating ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index < bookings.length) {
                              final booking = bookings[index];

                              return BookingCard(
                                booking: booking,
                                onTap: () async {
                                  final bookingCubit =
                                      context.read<BookingSelectionCubit>();
                                  bookingCubit.selectBooking(booking);

                                  await context.push(
                                    BookingDetailsScreen(
                                      bookingId: booking.id!,
                                    ),
                                  );
                                  if (bookingCubit.state.isModified) {
                                    final updated =
                                        bookingCubit.state.selectedBooking;

                                    // Update that specific booking in your list
                                    bloc.add(
                                      AllBookingEvent.updateBooking(
                                        updated,
                                        shouldRefresh:
                                            bookingCubit.state.shouldRefresh,
                                      ),
                                    );
                                    log('update booking called');

                                    bookingCubit.reset();
                                  }
                                },
                              );
                            } else {
                              return const BookingCardShimmer();
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveFilterIndicator(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.purple),
      ),
      child: Row(
        children: [
          Icon(
            Icons.filter_list,
            size: 16.sp,
            color: AppColors.purple,
          ),
          8.width,
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
              child: Icon(
                Icons.close,
                size: 14.sp,
                color: AppColors.purple,
              ),
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
            Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              dateFilterNotifier.value.hasActiveFilter
                  ? 'No bookings found for selected dates'
                  : 'No bookings',
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
                child: const Text('Clear filter to see all bookings'),
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

        _fetchBookingsWithFilter(context);
      },
    );
  }

  void _fetchBookingsWithFilter(BuildContext context) {
    // Add your date filter parameters to the bloc event
    // You'll need to modify your AllBookingEvent to accept date parameters
    context.read<AllBookingBloc>().add(
          AllBookingEvent.loadBookings(
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

    _fetchBookingsWithFilter(context);
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
