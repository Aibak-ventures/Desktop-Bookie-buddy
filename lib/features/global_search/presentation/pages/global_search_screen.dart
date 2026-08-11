import 'dart:developer';

import 'package:bookie_buddy_web/core/app/my_app.dart';
import 'package:bookie_buddy_web/core/common/helpers/shop_field_helper.dart';
import 'package:bookie_buddy_web/core/common/models/date_filter_model.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_search_field.dart';
import 'package:bookie_buddy_web/core/common/widgets/date_filter_button.dart';
import 'package:bookie_buddy_web/core/constants/enums/service_type_enums.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_active_filter_indicator.dart';
import 'package:bookie_buddy_web/features/booking/presentation/all_booking/widgets/booking_details_drawer.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/custom_date_filter_widget.dart';
import 'package:bookie_buddy_web/features/global_search/presentation/bloc/global_search_bloc/global_search_bloc.dart';
import 'package:bookie_buddy_web/features/global_search/presentation/widgets/global_search_invoice_search_results.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/mode_toggle_widget.dart';
import 'package:bookie_buddy_web/features/shop/presentation/bloc/service_bloc/service_bloc.dart';
import 'package:bookie_buddy_web/utils/extensions/date_time_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GlobalSearchTypes { booking }

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> {
  final searchController = TextEditingController();
  final dateFilterNotifier = ValueNotifier(const DateFilterModel());
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _resetAll();
      scrollController.addListener(_loadNextPage);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    dateFilterNotifier.dispose();
    scrollController.removeListener(_loadNextPage);
    scrollController.dispose();
    super.dispose();
  }

  void _resetAll() {
    searchController.clear();
    context.read<GlobalSearchBloc>().add(const GlobalSearchEvent.reset());
  }

  void _performSearch() {
    final query = searchController.text.trim();

    final bloc = context.read<GlobalSearchBloc>();
    if (query.isNotEmpty || dateFilterNotifier.value.hasActiveFilter) {
      bloc.add(
        GlobalSearchEvent.search(
          query,
          startDate: dateFilterNotifier.value.startDate?.format(),
          endDate: dateFilterNotifier.value.endDate?.format(),
        ),
      );
    } else {
      bloc.add(const GlobalSearchEvent.reset());
    }
  }

  void _loadNextPage() {
    if (!scrollController.hasClients) return;
    final scrollInfo = scrollController.position;

    if (scrollInfo.pixels >= scrollInfo.maxScrollExtent - 200) {
      final bloc = context.read<GlobalSearchBloc>();
      final loadedState = bloc.loadedState;
      if (loadedState == null) return;

      final isPaginating = loadedState.isPaginating;
      final nextPageUrl = loadedState.nextPageUrl;
      if (isPaginating || nextPageUrl == null) return;
      log('Loading next page: $nextPageUrl', name: 'GlobalSearchBookingList');
      context.read<GlobalSearchBloc>().add(
        GlobalSearchEvent.loadNextSearchResults(
          searchController.text.trim(),
          startDate: dateFilterNotifier.value.startDate?.format(),
          endDate: dateFilterNotifier.value.endDate?.format(),
        ),
      );
      return;
    }
  }

  void _clearDateFilter({bool search = true}) {
    dateFilterNotifier.value = const DateFilterModel();
    if (search) _performSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: 16.padding,
            child: Column(
              children: [
                15.height,
                Row(
                  children: [
                    Text(
                      'Global Search',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                    const Spacer(),
                    _buildActionTabs(),
                  ],
                ),
                35.height,

                // Search Field
                Builder(
                  builder: (context) {
                    final clientName = context
                        .select<ServiceBloc, MainServiceType>(
                          (bloc) => ShopFieldHelper.getEffectiveServiceType(
                            bloc.getServices(),
                          ),
                        )
                        .clientNameType;
                    return Row(
                      children: [
                        Expanded(
                          child: CustomSearchField(
                            searchController: searchController,
                            onChanged: (_) => _performSearch(),
                            padding: 0.padding,
                            hintText: '$clientName name, staff name, or ID',
                            suffixFunction: () {
                              _resetAll();
                              _clearDateFilter(search: false);
                            },
                          ),
                        ),
                        15.width,
                        ValueListenableBuilder(
                          valueListenable: dateFilterNotifier,
                          builder: (context, value, _) => DateFilterButton(
                            hasActiveFilter: value.hasActiveFilter,
                            onTap: () => _showDateFilterBottomSheet(
                              navigatorKey.currentContext ?? context,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),

                // Active Date Filter Indicator
                ValueListenableBuilder(
                  valueListenable: dateFilterNotifier,
                  builder: (context, value, child) => value.hasActiveFilter
                      ? CustomActiveFilterIndicator(
                          dateFilterNotifier: dateFilterNotifier,
                          onClearFilter: (ctx) => _clearDateFilter(),
                          padding: 20.paddingOnly(top: true),
                        )
                      : 10.height,
                ),

                // Results
                Expanded(
                  child: GlobalSearchInvoiceSearchResults(
                    searchController: searchController,
                    dateFilterNotifier: dateFilterNotifier,
                    scrollController: scrollController,
                    onLoadNextPage: () => _loadNextPage(),
                    onClearFilter: (_) => _clearDateFilter(),
                    onRetry: _performSearch,
                  ),
                ),
              ],
            ),
          ),
          // Renders when BookingDetailsDrawerCubit.openDrawer() is called
          // from a tapped row (see AllBookingsBookingTableRow.onTap).
          const BookingDetailsDrawer(),
        ],
      ),
    );
  }

  void _showDateFilterBottomSheet(BuildContext context) {
    showDateFilterDialog(
      context: context,
      initialStartDate: dateFilterNotifier.value.startDate,
      initialEndDate: dateFilterNotifier.value.endDate,
      onDateFilterChanged: (startDate, endDate) {
        dateFilterNotifier.value = dateFilterNotifier.value.copyWith(
          startDate: startDate,
          endDate: endDate,
        );
        _performSearch();
      },
    );
  }

  Widget _buildActionTabs() {
    // add more tabs here in the future if needed, for now we only have booking search
    return ModeToggleWidget<GlobalSearchTypes>(
      selectedValue: GlobalSearchTypes.booking,
      onChanged: (value) {},
      tabs: const [
        ModeToggleTab(
          value: GlobalSearchTypes.booking,
          label: 'Booking',
          icon: Icons.calendar_today,
        ),
      ],
    );
  }
}
