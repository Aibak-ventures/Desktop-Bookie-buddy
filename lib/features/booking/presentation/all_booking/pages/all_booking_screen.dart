import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/widget_extensions.dart';
import 'package:bookie_buddy_web/core/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/booking_date_filter.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_search_field.dart';
import 'package:bookie_buddy_web/core/common/widgets/date_filter_button.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/pages/all_booking_future_tab.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/pages/all_booking_past_tab.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_bloc/all_booking_bloc.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/bloc/all_booking_past_bloc/all_booking_past_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// This will show upcoming bookings that not completed,
///
/// unlike dashboard where only show upcoming bookings after today
class AllBookingScreen extends StatefulWidget {
  final int index;
  AllBookingScreen({super.key, this.index = 0});

  @override
  State<AllBookingScreen> createState() => _AllBookingScreenState();
}

class _AllBookingScreenState extends State<AllBookingScreen>
    with SingleTickerProviderStateMixin {
  // notifiers
  final dateFilterNotifier = ValueNotifier(const DateFilterModel());
  final isSearchingNotifier = ValueNotifier(false);

  // controller
  final searchController = TextEditingController();
  late final TabController _tabController;

  // focus node
  final FocusNode searchFocusNode = FocusNode();

  //
  final tabCurrentState = [false, false];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _onTabListener(widget.index);
    if (widget.index == 1) {
      _tabController.animateTo(1);
    }
    _tabController.addListener(() => _onTabListener(_tabController.index));
  }

  void _onTabListener(int index) {
    if (searchController.text.trim().isNotEmpty ||
        dateFilterNotifier.value.hasActiveFilter) {
      return _fetchBookingsWithFilter(context);
    }
    if (tabCurrentState[index] == true) return;
    if (index == 0) {
      context.read<AllBookingBloc>().add(const AllBookingEvent.loadBookings());
    } else {
      context.read<AllBookingPastBloc>().add(
            const AllBookingPastEvent.loadBookings(),
          );
    }
    tabCurrentState[index] = true;
  }

  @override
  void dispose() {
    // listeners
    _tabController.removeListener(() => _onTabListener(_tabController.index));

    // controller
    searchController.dispose();
    _tabController.dispose();

    // notifiers
    dateFilterNotifier.dispose();
    isSearchingNotifier.dispose();

    // focus node
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: kIsWeb ? AppColors.grey100 : Colors.white,
        appBar: AppBar(
          title: const Text('Bookings'),
          centerTitle: kIsWeb,
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

                if (isSearchingNotifier.value) {
                  searchFocusNode.requestFocus();
                } else {
                  searchFocusNode.unfocus();
                  if (searchController.text.trim().isNotEmpty ||
                      dateFilterNotifier.value.hasActiveFilter) {
                    searchController.clear();
                    _fetchBookingsWithFilter(context);
                  }
                }
              }),
            ),
            8.width,
            // Date Filter Button
            ValueListenableBuilder(
              valueListenable: dateFilterNotifier,
              builder: (context, value, child) => DateFilterButton(
                hasActiveFilter: value.hasActiveFilter,
                onTap: () => _showDateFilterBottomSheet(context),
              ),
            ),

            10.width,
          ],
        ),
        body: Center(
          child: Container(
            constraints: kIsWeb ? const BoxConstraints(maxWidth: 1200) : null,
            child: Column(
              children: [
                // Active Search filed
                ValueListenableBuilder(
                  valueListenable: isSearchingNotifier,
                  builder: (context, isSearching, child) => isSearching
                      ? Container(
                          color: Colors.white,
                          child: CustomSearchField(
                            searchController: searchController,
                            padding: (16, 8).padding,
                            focusNode: searchFocusNode,
                            onChanged: (query) {
                              _fetchBookingsWithFilter(context);
                            },
                            hintText: 'Search by name or ID...',
                            suffixFunction: () {
                              searchController.clear();
                              _fetchBookingsWithFilter(context, 2);
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                // Active Filter Indicator
                ValueListenableBuilder(
                  valueListenable: dateFilterNotifier,
                  builder: (context, value, child) => value.hasActiveFilter
                      ? Container(
                          color: Colors.white,
                          child: _buildActiveFilterIndicator(context),
                        )
                      : const SizedBox.shrink(),
                ),

                Container(
                  color: Colors.white,
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Pending'),
                      Tab(text: 'Past'),
                    ],
                  ),
                ),
                10.height,
                Expanded(
                  child: Padding(
                    padding: kIsWeb
                        ? const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16)
                        : 10.padding,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        AllBookingFutureTab(
                          dateFilterNotifier: dateFilterNotifier,
                          searchController: searchController,
                        ),
                        AllBookingPastTab(
                          dateFilterNotifier: dateFilterNotifier,
                          searchController: searchController,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildActiveFilterIndicator(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.purple.withValues(alpha: 0.1),
          borderRadius: 8.radiusBorder,
          border: Border.all(color: AppColors.purple),
        ),
        child: Row(
          children: [
            Icon(Icons.filter_list, size: 16.sp, color: AppColors.purple),
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
            Container(
              padding: 2.padding,
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close, size: 14.sp, color: AppColors.purple),
            ).onTap(() => _clearDateFilter(context)),
          ],
        ),
      );

  void _clearDateFilter(BuildContext context) {
    dateFilterNotifier.value = const DateFilterModel();

    _fetchBookingsWithFilter(context, 2);
  }

  // Widget _buildEmptyState(BuildContext context) {
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

  void _fetchBookingsWithFilter(BuildContext context, [int? index]) {
    // Add your date filter parameters to the bloc event
    // You'll need to modify your AllBookingEvent to accept date parameters
    index ??= _tabController.index;
    final startDate = dateFilterNotifier.value.startDate?.format(reverse: true);
    final endDate = dateFilterNotifier.value.endDate?.format(reverse: true);
    final searchQuery = searchController.text.trim().isEmpty
        ? null
        : searchController.text.trim();
    if (index == 0) {
      context.read<AllBookingBloc>().add(
            AllBookingEvent.loadBookings(
              startDate: startDate,
              endDate: endDate,
              searchQuery: searchQuery,
            ),
          );
    } else if (index == 1) {
      context.read<AllBookingPastBloc>().add(
            AllBookingPastEvent.loadBookings(
              startDate: startDate,
              endDate: endDate,
              searchQuery: searchQuery,
            ),
          );
    } else {
      context.read<AllBookingBloc>().add(
            AllBookingEvent.loadBookings(
              startDate: startDate,
              endDate: endDate,
              searchQuery: searchQuery,
            ),
          );
      context.read<AllBookingPastBloc>().add(
            AllBookingPastEvent.loadBookings(
              startDate: startDate,
              endDate: endDate,
              searchQuery: searchQuery,
            ),
          );
    }
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
