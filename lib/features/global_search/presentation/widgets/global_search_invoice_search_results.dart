import 'package:bookie_buddy_web/core/common/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_error_text_widget.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_empty_filter_state_widget.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/all_bookings_booking_table_header.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/all_bookings_booking_table_row.dart';
import 'package:bookie_buddy_web/features/global_search/presentation/bloc/global_search_bloc/global_search_bloc.dart';
import 'package:bookie_buddy_web/features/global_search/presentation/widgets/search_screen_shared_widgets.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalSearchInvoiceSearchResults extends StatelessWidget {
  final TextEditingController searchController;
  final ValueNotifier<DateFilterModel> dateFilterNotifier;
  final void Function(BuildContext) onClearFilter;
  final VoidCallback onRetry;
  final ScrollController scrollController;
  final VoidCallback? onLoadNextPage;

  const GlobalSearchInvoiceSearchResults({
    super.key,
    required this.searchController,
    required this.dateFilterNotifier,
    required this.onClearFilter,
    required this.onRetry,
    required this.scrollController,
    required this.onLoadNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
      builder: (context, state) => Column(
        children: [
          15.height,
          const AllBookingsBookingTableHeader(),
          Expanded(
            child: state.when(
              initial: () => const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlobalSearchInitialAnimation(),
                  Text('Search for invoices', textAlign: TextAlign.center),
                ],
              ),
              loading: () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) =>
                    const AllBookingsBookingTableRowShimmer(),
              ),
              error: (error) =>
                  CustomErrorWidget(errorText: error, onRetry: onRetry),
              loaded: (searchData, nextPageUrl, isPaginating) {
                if (searchData.isEmpty) {
                  return CustomEmptyFilterStateWidget(
                    dataText: 'result',
                    dateFilterNotifier: dateFilterNotifier,
                    onClearFilter: onClearFilter,
                    heightR: 0.25,
                  );
                }
                return NotificationListener<ScrollMetricsNotification>(
                  // Fires whenever this ListView's scroll metrics are
                  // (re)established, including the initial layout. If the content
                  // doesn't overflow the viewport the user has no scroll gesture
                  // to trigger pagination with, so kick off the next page here.
                  onNotification: (notification) {
                    if (notification.metrics.maxScrollExtent <= 0) {
                      onLoadNextPage?.call();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    key: const PageStorageKey('global-search-storage-key'),
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        searchData.length +
                        (nextPageUrl != null && isPaginating ? 1 : 0),
                    itemBuilder: (context, index) {
                      final adjustedIndex = index;
                      if (adjustedIndex < searchData.length) {
                        final data = searchData[adjustedIndex];
                        if (data.booking == null) {
                          return const SizedBox.shrink();
                        }
                        final booking = data.booking!;
                        return AllBookingsBookingTableRow(booking: booking);
                      } else {
                        return const AllBookingsBookingTableRowShimmer();
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
